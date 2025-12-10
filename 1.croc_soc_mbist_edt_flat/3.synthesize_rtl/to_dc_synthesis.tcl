define_design_lib work -path work

set tessent_hierarchy_separator /
  # The instances must be preserved in the post-synthesis netlist in order to perform further actions on it:
  #   add_core_instances
  #   scan_insertion       superset of 'add_core_instances' list
  #   icl_extract          superset of 'scan_insertion' list
set preserve_type icl_extract

## Edit to cater to your design_name and design_id
set PDK_ROOT ../../tech
set design_name croc_chip
set design_id rtl2

## Reading in the file written out during Step 2 using write_design_import_script
source ../2.insert_occ_edt/for_dc_synthesis_edt_occ.tcl
read_verilog ${PDK_ROOT}/tessent/memories/RM_IHPSG13_1P_256x64_c2_bm_bist.v_interface
set_dont_touch RM_IHPSG13_1P_256x64_c2_bm_bist
## Reading in the sdc written out from the second insertion pass
source ../tsdb_outdir/dft_inserted_designs/${design_name}_${design_id}.dft_inserted_design/${design_name}.sdc
tessent_set_default_variables
elaborate ${design_name}
link
check_design
current_design ${design_name}


## Do not perform boundary optimization on tessent_get_preserve_instances

set preserve_instances [tessent_get_preserve_instances ${preserve_type}]
set_boundary_optimization  $preserve_instances false
set_ungroup $preserve_instances false
# DC ultra only
# set_compile_directives $preserve_instances -delete_unloaded_gate false
# For DC Shell only
set compile_seqmap_propagate_high_effort false
set compile_seqmap_enable_output_inversion true
set compile_delete_unloaded_sequential_cells false


set optimize_instances [tessent_get_optimize_instances]
set_boundary_optimization $optimize_instances true
set size_only_instances [tessent_get_size_only_instances]
set_size_only -all_instances $size_only_instances

#create_clock clk_i -period 10.0 -name clk_i
#create_clock ref_clk_i -period 10.0 -name ref_clk_i

#set croc_chip_tck_period      20.0; # No units allowed, nanoseconds assumed
#set tessent_tck_period [set ${design_name}_tck_period]
# Call non_modal SDC proc sourced at the top of the dofile
tessent_constrain_${design_name}_non_modal


## Synthesize
#compile_ultra -no_autoungroup -no_boundary_optimization
compile
remove_design RM_IHPSG13_1P_256x64_c2_bm_bist
## Write the synthesized netlist out
write -f verilog -hierarchy -output croc_chip_synthesized.vg

report_area > mbist_edt_area.rpt
report_power > mbist_edt_power.rpt
report_timing >  mbist_edt_timing.rpt

exit

