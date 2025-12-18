define_design_lib work -path work

#set tessent_hierarchy_separator /
#  # The instances must be preserved in the post-synthesis netlist in order to perform further actions on it:
#  #   add_core_instances
#  #   scan_insertion       superset of 'add_core_instances' list
#  #   icl_extract          superset of 'scan_insertion' list
#set preserve_type icl_extract
#set design_name croc_soc_GpioCount32
#set design_id rtl2
#
#source ../tsdb_outdir/dft_inserted_designs/${design_name}_${design_id}.dft_inserted_design/${design_name}.sdc

read_verilog -netlist ../tsdb_outdir/dft_inserted_designs/croc_soc_GpioCount32_gate3.dft_inserted_design/croc_soc_GpioCount32.vg

current_design croc_soc_GpioCount32
source ../0.netlist_generation/croc_soc.sdc

#set preserve_instances [tessent_get_preserve_instances ${preserve_type}]
#set_boundary_optimization  $preserve_instances false
#set_ungroup $preserve_instances false

## To flatten
set_dont_touch [get_cells tessent_persistent_* -hier -filter "is_hierarchical==true"]
set_size_only [get_cells tessent_persistent_* -hier -filter "is_hierarchical==false"]
## This needs a compile, this is what layout tools use
## 
set_flatten true
ungroup -all 
compile

## Write the flatenned netlist out
write -f verilog -hierarchy -output croc_soc_GpioCount32_layout.vg

exit
