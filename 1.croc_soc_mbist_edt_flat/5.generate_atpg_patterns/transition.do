#! /bin/sh -f
#\
exec tessent -shell -log logfiles/$0.log -replace -dofile "$0"


set PDK_ROOT ../../tech
set design_name croc_chip 

set_context patterns -scan

# Read the cell library 
read_cell_library ${PDK_ROOT}/tessent/ihp-sg13g2_stdcell.tcelllib
read_cell_library ${PDK_ROOT}/tessent/ihp-sg13g2_io.tcelllib

# Point to the TSDB directory
set_tsdb_output_directory ../tsdb_outdir

# Read the scan inserted design from the TSDB
read_design ${design_name} -design_id gate -verbose
add_black_boxes -modules { \
                    RM_IHPSG13_1P_256x64_c2_bm_bist \
             }
             
set_current_design ${design_name}

if {$env(SCAN_TOOL) == "Tessent_Scan"} {
   import_scan_mode edt_mode -fast_capture_mode on -verbose
} else {
   # If scan was inserted by a third-party tool, use the TCD core mapping flow
   # Associate the TCD with each of the EDT, OCC, Boundary Scan, and SIB instances that it describes
   # This automates the control of the pins and constraints required during test_setup for ATPG

   # EDT
   set edt_top_module [get_single_name [get_module *_edt_c1]]
   set edt_top_module_instance "${edt_top_module}_inst"
   add_core_instance -module $edt_top_module

   # OCC
   set occ_instances [get_instances -of_icl_instances [get_icl_instances -filter tessent_instrument_type==mentor::occ]]
   add_core_instances -instance $occ_instances -parameter_values "fast_capture_mode on"

   # Boundary Scan
   set bscan_interface_inst [get_instances -of_icl_instances [get_icl_instances -filter tessent_instrument_type==mentor::jtag_bscan]]
   add_core_instances -instance $bscan_interface_inst

   # STI SIB 
   set sti_sib_instance [get_instances -of_icl_instances [get_icl_instances * -filter "tessent_dft_function==scan_tested_instrument_host"]]
   add_core_instances -instances $sti_sib_instance

   # Import clocks from TSDB
   import_clocks
   
   set_static_dft_signal_values edt_mode 1
}

# Report the cores that are described
report_core_descriptions
report_clocks
report_dft_signals
report_static_dft_signal_settings

# Set the following DFT Signal values to use the boundary scan chain to apply/capture values that would normally use the I/O pads
set_static_dft_signal_values int_ltest_en 1
set_static_dft_signal_values output_pad_disable 1

# Set the following DFT Signal value to apply the shift_capture_clock to the Scan Tested network during capture phase of ATPG
set_static_dft_signal_values tck_occ_en 1
report_static_dft_signal_settings

add_rtl_to_gates_mapping -instance_name_map_list {croc_chip_rtl1_tessent_bscan_interface_I/tessent_persistent_cell_output_pad_disable_buf/y croc_chip_rtl1_tessent_bscan_interface_I/tessent_persistent_cell_output_pad_disable_buf/X}
add_rtl_to_gates_mapping -instance_name_map_list {croc_chip_rtl1_tessent_bscan_interface_I/tessent_persistent_cell_bscan_clamp_enable_buf/y croc_chip_rtl1_tessent_bscan_interface_I/tessent_persistent_cell_bscan_clamp_enable_buf/X}
add_rtl_to_gates_mapping -instance_name_map_list {croc_chip_rtl1_tessent_bscan_interface_I/tessent_persistent_cell_int_ltest_en_buf/y croc_chip_rtl1_tessent_bscan_interface_I/tessent_persistent_cell_int_ltest_en_buf/X  }

set_system_mode analysis

set_fault_type transition
set_external_capture_options -pll_cycles 5 [lindex [get_timeplate_list] 0]
get_timeplate_list

# Add more processors to run ATPG
add_processors localhost:4

# Generate patterns
create_patterns

report_statistics -detailed_analysis
report_scan_volume

# Store TCD, flat model, fault list and PatDB format files in the TSDB directory
write_tsdb_data -replace

# Write Verilog patterns for simulation
write_patterns patterns/${design_name}_transition_parallel.v -verilog -parallel -replace -scan -parameter_list {SIM_KEEP_PATH 1}
set_pattern_filtering -sample_per_type 2
write_patterns patterns/${design_name}_transition_serial.v -verilog -serial -replace -parameter_list {SIM_KEEP_PATH 1}

# Write the STIL pattern for application on a tester
write_patterns patterns/${design_name}_transition.stil -stil -replace

exit

