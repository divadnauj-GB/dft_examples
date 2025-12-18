define_design_lib work -path work


## Edit to cater to your design_name and design_id
set design_name croc_soc

source ./croc_flist.tcl
 

elaborate ${design_name} -parameters "GpioCount=32"
link
check_design

#define functional clock 
create_clock -period 10.0 clk_i
create_clock -period 10.0 jtag_tck_i


## Reading in the sdc written out from the  insertion pass

# compile -boundary_optimization -exact_map 
## Synthesize
# 
set_flatten true
ungroup -all 
compile_ultra
#compile
## Write the synthesized netlist out
write -f verilog -hierarchy -output ${design_name}_synthesized.vg
#remove_bus {user_mgr_obi_req_i user_mgr_obi_rsp_o user_sbr_obi_req_o user_sbr_obi_rsp_i}

# create_bus { \
# \user_mgr_obi_req_i[a][addr][31]  \user_mgr_obi_req_i[a][addr][30] \ 
# \user_mgr_obi_req_i[a][addr][29]  \user_mgr_obi_req_i[a][addr][28] \ 
# \user_mgr_obi_req_i[a][addr][27]  \user_mgr_obi_req_i[a][addr][26] \ 
# \user_mgr_obi_req_i[a][addr][25]  \user_mgr_obi_req_i[a][addr][24] \ 
# \user_mgr_obi_req_i[a][addr][23]  \user_mgr_obi_req_i[a][addr][22] \ 
# \user_mgr_obi_req_i[a][addr][21]  \user_mgr_obi_req_i[a][addr][20] \ 
# \user_mgr_obi_req_i[a][addr][19]  \user_mgr_obi_req_i[a][addr][18] \ 
# \user_mgr_obi_req_i[a][addr][17]  \user_mgr_obi_req_i[a][addr][16] \ 
# \user_mgr_obi_req_i[a][addr][15]  \user_mgr_obi_req_i[a][addr][14] \ 
# \user_mgr_obi_req_i[a][addr][13]  \user_mgr_obi_req_i[a][addr][12] \ 
# \user_mgr_obi_req_i[a][addr][11]  \user_mgr_obi_req_i[a][addr][10] \ 
# \user_mgr_obi_req_i[a][addr][9]  \user_mgr_obi_req_i[a][addr][8] \ 
# \user_mgr_obi_req_i[a][addr][7]  \user_mgr_obi_req_i[a][addr][6] \ 
# \user_mgr_obi_req_i[a][addr][5]  \user_mgr_obi_req_i[a][addr][4] \ 
# \user_mgr_obi_req_i[a][addr][3]  \user_mgr_obi_req_i[a][addr][2] \ 
# \user_mgr_obi_req_i[a][addr][1]  \user_mgr_obi_req_i[a][addr][0] } user_mgr_obi_req_i_a_addr
# 
# create_bus { \
# \user_mgr_obi_req_i[a][be][3] \user_mgr_obi_req_i[a][be][2]  \user_mgr_obi_req_i[a][be][1] \
# \user_mgr_obi_req_i[a][be][0] } user_mgr_obi_req_i_a_be
# 
# 
# create_bus { \
# \user_mgr_obi_req_i[a][wdata][31] \ 
# \user_mgr_obi_req_i[a][wdata][30]  \user_mgr_obi_req_i[a][wdata][29] \ 
# \user_mgr_obi_req_i[a][wdata][28]  \user_mgr_obi_req_i[a][wdata][27] \ 
# \user_mgr_obi_req_i[a][wdata][26]  \user_mgr_obi_req_i[a][wdata][25] \ 
# \user_mgr_obi_req_i[a][wdata][24]  \user_mgr_obi_req_i[a][wdata][23] \ 
# \user_mgr_obi_req_i[a][wdata][22]  \user_mgr_obi_req_i[a][wdata][21] \ 
# \user_mgr_obi_req_i[a][wdata][20]  \user_mgr_obi_req_i[a][wdata][19] \ 
# \user_mgr_obi_req_i[a][wdata][18]  \user_mgr_obi_req_i[a][wdata][17] \ 
# \user_mgr_obi_req_i[a][wdata][16]  \user_mgr_obi_req_i[a][wdata][15] \ 
# \user_mgr_obi_req_i[a][wdata][14]  \user_mgr_obi_req_i[a][wdata][13] \ 
# \user_mgr_obi_req_i[a][wdata][12]  \user_mgr_obi_req_i[a][wdata][11] \ 
# \user_mgr_obi_req_i[a][wdata][10]  \user_mgr_obi_req_i[a][wdata][9] \ 
# \user_mgr_obi_req_i[a][wdata][8]  \user_mgr_obi_req_i[a][wdata][7] \ 
# \user_mgr_obi_req_i[a][wdata][6]  \user_mgr_obi_req_i[a][wdata][5] \ 
# \user_mgr_obi_req_i[a][wdata][4]  \user_mgr_obi_req_i[a][wdata][3] \ 
# \user_mgr_obi_req_i[a][wdata][2]  \user_mgr_obi_req_i[a][wdata][1] \ 
# \user_mgr_obi_req_i[a][wdata][0]  } user_mgr_obi_req_i_a_wdata
# 
# create_bus { \
# \user_mgr_obi_req_i[a][wdata][31] \ 
# \user_mgr_obi_req_i[a][wdata][30]  \user_mgr_obi_req_i[a][wdata][29] \ 
# \user_mgr_obi_req_i[a][wdata][28]  \user_mgr_obi_req_i[a][wdata][27] \ 
# \user_mgr_obi_req_i[a][wdata][26]  \user_mgr_obi_req_i[a][wdata][25] \ 
# \user_mgr_obi_req_i[a][wdata][24]  \user_mgr_obi_req_i[a][wdata][23] \ 
# \user_mgr_obi_req_i[a][wdata][22]  \user_mgr_obi_req_i[a][wdata][21] \ 
# \user_mgr_obi_req_i[a][wdata][20]  \user_mgr_obi_req_i[a][wdata][19] \ 
# \user_mgr_obi_req_i[a][wdata][18]  \user_mgr_obi_req_i[a][wdata][17] \ 
# \user_mgr_obi_req_i[a][wdata][16]  \user_mgr_obi_req_i[a][wdata][15] \ 
# \user_mgr_obi_req_i[a][wdata][14]  \user_mgr_obi_req_i[a][wdata][13] \ 
# \user_mgr_obi_req_i[a][wdata][12]  \user_mgr_obi_req_i[a][wdata][11] \ 
# \user_mgr_obi_req_i[a][wdata][10]  \user_mgr_obi_req_i[a][wdata][9] \ 
# \user_mgr_obi_req_i[a][wdata][8]  \user_mgr_obi_req_i[a][wdata][7] \ 
# \user_mgr_obi_req_i[a][wdata][6]  \user_mgr_obi_req_i[a][wdata][5] \ 
# \user_mgr_obi_req_i[a][wdata][4]  \user_mgr_obi_req_i[a][wdata][3] \ 
# \user_mgr_obi_req_i[a][wdata][2]  \user_mgr_obi_req_i[a][wdata][1] \ 
# \user_mgr_obi_req_i[a][wdata][0]  } user_mgr_obi_req_i_a_wdata
# 
# create_bus { \user_mgr_obi_req_i[a][we] } user_mgr_obi_req_i_a_we
# 
# create_bus { \user_mgr_obi_req_i[a][aid][0] } user_mgr_obi_req_i_a_aid
# 
# create_bus { \user_mgr_obi_req_i[a][a_optional] } user_mgr_obi_req_i_a_a_optional
# create_bus { \user_mgr_obi_req_i[req] } user_mgr_obi_req_i_req
# 
# create_bus { \
# \user_mgr_obi_rsp_o[r][rdata][31]  \user_mgr_obi_rsp_o[r][rdata][30] \ 
# \user_mgr_obi_rsp_o[r][rdata][29]  \user_mgr_obi_rsp_o[r][rdata][28] \ 
# \user_mgr_obi_rsp_o[r][rdata][27]  \user_mgr_obi_rsp_o[r][rdata][26] \ 
# \user_mgr_obi_rsp_o[r][rdata][25]  \user_mgr_obi_rsp_o[r][rdata][24] \ 
# \user_mgr_obi_rsp_o[r][rdata][23]  \user_mgr_obi_rsp_o[r][rdata][22] \ 
# \user_mgr_obi_rsp_o[r][rdata][21]  \user_mgr_obi_rsp_o[r][rdata][20] \ 
# \user_mgr_obi_rsp_o[r][rdata][19]  \user_mgr_obi_rsp_o[r][rdata][18] \ 
# \user_mgr_obi_rsp_o[r][rdata][17]  \user_mgr_obi_rsp_o[r][rdata][16] \ 
# \user_mgr_obi_rsp_o[r][rdata][15]  \user_mgr_obi_rsp_o[r][rdata][14] \ 
# \user_mgr_obi_rsp_o[r][rdata][13]  \user_mgr_obi_rsp_o[r][rdata][12] \ 
# \user_mgr_obi_rsp_o[r][rdata][11]  \user_mgr_obi_rsp_o[r][rdata][10] \ 
# \user_mgr_obi_rsp_o[r][rdata][9]  \user_mgr_obi_rsp_o[r][rdata][8] \ 
# \user_mgr_obi_rsp_o[r][rdata][7]  \user_mgr_obi_rsp_o[r][rdata][6] \ 
# \user_mgr_obi_rsp_o[r][rdata][5]  \user_mgr_obi_rsp_o[r][rdata][4] \ 
# \user_mgr_obi_rsp_o[r][rdata][3]  \user_mgr_obi_rsp_o[r][rdata][2] \ 
# \user_mgr_obi_rsp_o[r][rdata][1]  \user_mgr_obi_rsp_o[r][rdata][0] } user_mgr_obi_rsp_o_r_rdata
# 
# create_bus { \user_mgr_obi_rsp_o[r][rid][0] } user_mgr_obi_rsp_o_r_rid 
# create_bus { \user_mgr_obi_rsp_o[r][err] } user_mgr_obi_rsp_o_r_err
# create_bus { \user_mgr_obi_rsp_o[r][r_optional] } user_mgr_obi_rsp_o_r_r_optional
# create_bus { \user_mgr_obi_rsp_o[gnt] } user_mgr_obi_rsp_o_gnt
# create_bus { \user_mgr_obi_rsp_o[rvalid] } user_mgr_obi_rsp_o_rvalid
# 
# create_bus {    \user_sbr_obi_req_o[a][addr][31] \
#                 \user_sbr_obi_req_o[a][addr][30]  \user_sbr_obi_req_o[a][addr][29] \ 
#                 \user_sbr_obi_req_o[a][addr][28]  \user_sbr_obi_req_o[a][addr][27] \ 
#                 \user_sbr_obi_req_o[a][addr][26]  \user_sbr_obi_req_o[a][addr][25] \ 
#                 \user_sbr_obi_req_o[a][addr][24]  \user_sbr_obi_req_o[a][addr][23] \ 
#                 \user_sbr_obi_req_o[a][addr][22]  \user_sbr_obi_req_o[a][addr][21] \ 
#                 \user_sbr_obi_req_o[a][addr][20]  \user_sbr_obi_req_o[a][addr][19] \ 
#                 \user_sbr_obi_req_o[a][addr][18]  \user_sbr_obi_req_o[a][addr][17] \ 
#                 \user_sbr_obi_req_o[a][addr][16]  \user_sbr_obi_req_o[a][addr][15] \ 
#                 \user_sbr_obi_req_o[a][addr][14]  \user_sbr_obi_req_o[a][addr][13] \ 
#                 \user_sbr_obi_req_o[a][addr][12]  \user_sbr_obi_req_o[a][addr][11] \ 
#                 \user_sbr_obi_req_o[a][addr][10]  \user_sbr_obi_req_o[a][addr][9] \ 
#                 \user_sbr_obi_req_o[a][addr][8]  \user_sbr_obi_req_o[a][addr][7] \ 
#                 \user_sbr_obi_req_o[a][addr][6]  \user_sbr_obi_req_o[a][addr][5] \ 
#                 \user_sbr_obi_req_o[a][addr][4]  \user_sbr_obi_req_o[a][addr][3] \ 
#                 \user_sbr_obi_req_o[a][addr][2]  \user_sbr_obi_req_o[a][addr][1] \ 
#                 \user_sbr_obi_req_o[a][addr][0] } user_sbr_obi_req_o_a_addr
# 
# create_bus { \user_sbr_obi_req_o[a][we] } user_sbr_obi_req_o_a_we
# 
# create_bus {\user_sbr_obi_req_o[a][be][3]  \user_sbr_obi_req_o[a][be][2] \
# \user_sbr_obi_req_o[a][be][1] \user_sbr_obi_req_o[a][be][0] } user_sbr_obi_req_o_a_be
# 
# 
# create_bus { \
# \user_sbr_obi_req_o[a][wdata][31]  \user_sbr_obi_req_o[a][wdata][30] \ 
# \user_sbr_obi_req_o[a][wdata][29]  \user_sbr_obi_req_o[a][wdata][28] \ 
# \user_sbr_obi_req_o[a][wdata][27]  \user_sbr_obi_req_o[a][wdata][26] \ 
# \user_sbr_obi_req_o[a][wdata][25]  \user_sbr_obi_req_o[a][wdata][24] \ 
# \user_sbr_obi_req_o[a][wdata][23]  \user_sbr_obi_req_o[a][wdata][22] \ 
# \user_sbr_obi_req_o[a][wdata][21]  \user_sbr_obi_req_o[a][wdata][20] \ 
# \user_sbr_obi_req_o[a][wdata][19]  \user_sbr_obi_req_o[a][wdata][18] \ 
# \user_sbr_obi_req_o[a][wdata][17]  \user_sbr_obi_req_o[a][wdata][16] \ 
# \user_sbr_obi_req_o[a][wdata][15]  \user_sbr_obi_req_o[a][wdata][14] \ 
# \user_sbr_obi_req_o[a][wdata][13]  \user_sbr_obi_req_o[a][wdata][12] \ 
# \user_sbr_obi_req_o[a][wdata][11]  \user_sbr_obi_req_o[a][wdata][10] \ 
# \user_sbr_obi_req_o[a][wdata][9]  \user_sbr_obi_req_o[a][wdata][8] \ 
# \user_sbr_obi_req_o[a][wdata][7]  \user_sbr_obi_req_o[a][wdata][6] \ 
# \user_sbr_obi_req_o[a][wdata][5]  \user_sbr_obi_req_o[a][wdata][4] \ 
# \user_sbr_obi_req_o[a][wdata][3]  \user_sbr_obi_req_o[a][wdata][2] \ 
# \user_sbr_obi_req_o[a][wdata][1]  \user_sbr_obi_req_o[a][wdata][0] } user_sbr_obi_req_o_a_wdata
# 
# 
# create_bus { \user_sbr_obi_req_o[a][aid][2]  \user_sbr_obi_req_o[a][aid][1]  
#         \user_sbr_obi_req_o[a][aid][0] } user_sbr_obi_req_o_a_aid
# 
# create_bus { \user_sbr_obi_req_o[a][a_optional] } user_sbr_obi_req_o_a_a_optional
# 
# create_bus { \user_sbr_obi_req_o[req]  } user_sbr_obi_req_o_req
# 
# create_bus {\user_sbr_obi_rsp_i[r][rdata][31] \ 
#             \user_sbr_obi_rsp_i[r][rdata][30]  \user_sbr_obi_rsp_i[r][rdata][29] \ 
#             \user_sbr_obi_rsp_i[r][rdata][28]  \user_sbr_obi_rsp_i[r][rdata][27] \ 
#             \user_sbr_obi_rsp_i[r][rdata][26]  \user_sbr_obi_rsp_i[r][rdata][25] \ 
#             \user_sbr_obi_rsp_i[r][rdata][24]  \user_sbr_obi_rsp_i[r][rdata][23] \ 
#             \user_sbr_obi_rsp_i[r][rdata][22]  \user_sbr_obi_rsp_i[r][rdata][21] \ 
#             \user_sbr_obi_rsp_i[r][rdata][20]  \user_sbr_obi_rsp_i[r][rdata][19] \ 
#             \user_sbr_obi_rsp_i[r][rdata][18]  \user_sbr_obi_rsp_i[r][rdata][17] \ 
#             \user_sbr_obi_rsp_i[r][rdata][16]  \user_sbr_obi_rsp_i[r][rdata][15] \ 
#             \user_sbr_obi_rsp_i[r][rdata][14]  \user_sbr_obi_rsp_i[r][rdata][13] \ 
#             \user_sbr_obi_rsp_i[r][rdata][12]  \user_sbr_obi_rsp_i[r][rdata][11] \ 
#             \user_sbr_obi_rsp_i[r][rdata][10]  \user_sbr_obi_rsp_i[r][rdata][9] \ 
#             \user_sbr_obi_rsp_i[r][rdata][8]  \user_sbr_obi_rsp_i[r][rdata][7] \ 
#             \user_sbr_obi_rsp_i[r][rdata][6]  \user_sbr_obi_rsp_i[r][rdata][5] \ 
#             \user_sbr_obi_rsp_i[r][rdata][4]  \user_sbr_obi_rsp_i[r][rdata][3] \ 
#             \user_sbr_obi_rsp_i[r][rdata][2]  \user_sbr_obi_rsp_i[r][rdata][1] \
#             \user_sbr_obi_rsp_i[r][rdata][0] } user_sbr_obi_rsp_i_r_rdata
# 
# create_bus { \user_sbr_obi_rsp_i[r][rid][2] \ 
#         \user_sbr_obi_rsp_i[r][rid][1]  \user_sbr_obi_rsp_i[r][rid][0] } user_sbr_obi_rsp_i_r_rid
# create_bus { \user_sbr_obi_rsp_i[r][err] } user_sbr_obi_rsp_i_r_err
# create_bus {\user_sbr_obi_rsp_i[r][r_optional] } user_sbr_obi_rsp_i_r_r_optional
# create_bus {\user_sbr_obi_rsp_i[gnt] } user_sbr_obi_rsp_i_gnt
# create_bus {\user_sbr_obi_rsp_i[rvalid] } user_sbr_obi_rsp_i_rvalid

write -f verilog -hierarchy -output ${design_name}_synthesized.vg



##
write_sdc  ${design_name}.sdc
exit

