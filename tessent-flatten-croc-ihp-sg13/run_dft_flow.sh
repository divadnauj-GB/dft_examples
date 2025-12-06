#run first dft pass
cd ./1.insert_bscan_mbist

cd ../1.insert_bscan_mbist
./run_insert_bscan_mbist

#run second dft pass
cd ../2.insert_occ_edt
./run_insert_occ_edt

# run synthesis of the design
cd ../3.synthesize_rtl
./run_dc_synthesis

# insert test points for Lbist
cd ../4.insert_scan
./run_scan_insertion

# insert test points for Lbist
cd ../5.generate_atpg_patterns
./1.run_stuck_tessent_scan
./2.run_transition_tessent_scan
./3.run_sims

# insert test points for Lbist
cd ../6.validate_mbist_gate_level
./run_mbist_gate_sim
