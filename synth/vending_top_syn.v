/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : X-2025.06-SP2
// Date      : Wed Jul 29 14:55:44 2026
/////////////////////////////////////////////////////////////


module vending_top ( clk, rst, coin_in, sel_item, confirm, cancel, dispense, 
        change_out, error, display, state_out );
  input [1:0] coin_in;
  input [1:0] sel_item;
  output [7:0] change_out;
  output [7:0] display;
  output [2:0] state_out;
  input clk, rst, confirm, cancel;
  output dispense, error;
  wire   read_valid, mem_write, \u_control_unit/N49 , \u_control_unit/N47 ,
         \u_credit_reg/N65 , \u_credit_reg/N64 , \u_credit_reg/N48 ,
         \u_credit_reg/N47 , \u_credit_reg/N46 , \u_credit_reg/N45 ,
         \u_credit_reg/N44 , \u_credit_reg/N43 , \u_credit_reg/N42 ,
         \u_credit_reg/coin_pending , \u_memory/N61 , \u_memory/mem[0][4] ,
         \u_memory/mem[0][3] , \u_memory/mem[0][2] , \u_memory/mem[0][1] ,
         \u_memory/mem[0][0] , \u_memory/mem[1][4] , \u_memory/mem[1][3] ,
         \u_memory/mem[1][2] , \u_memory/mem[1][1] , \u_memory/mem[1][0] ,
         \u_memory/mem[2][4] , \u_memory/mem[2][3] , \u_memory/mem[2][2] ,
         \u_memory/mem[2][1] , \u_memory/mem[2][0] , \u_memory/mem[3][4] ,
         \u_memory/mem[3][3] , \u_memory/mem[3][2] , \u_memory/mem[3][1] ,
         \u_memory/mem[3][0] , n84, n85, n86, n87, n88, n89, n90, n91, n92,
         n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n104, n105, n106,
         n107, n111, n112, n113, n114, n115, n119, n120, n121, n122, n123,
         n127, n128, n129, n130, n131, n135, n136, n137, n138, n139, n143,
         n144, n145, n146, n147, n148, n149, n150, n151, n152, n153, n154,
         \C1/Z_6 , \C1/Z_5 , \C1/Z_4 , \C1/Z_3 , \C1/Z_2 , \C1/Z_1 , \C1/Z_0 ,
         \DP_OP_22J1_122_2962/n8 , \DP_OP_22J1_122_2962/n7 ,
         \DP_OP_22J1_122_2962/n6 , \DP_OP_22J1_122_2962/n5 ,
         \DP_OP_22J1_122_2962/n4 , \DP_OP_22J1_122_2962/n3 ,
         \DP_OP_22J1_122_2962/n2 , \intadd_0/CI , \intadd_0/SUM[4] ,
         \intadd_0/SUM[3] , \intadd_0/SUM[2] , \intadd_0/SUM[1] ,
         \intadd_0/SUM[0] , \intadd_0/n5 , \intadd_0/n4 , \intadd_0/n3 ,
         \intadd_0/n2 , \intadd_0/n1 , n164, n165, n166, n167, n168, n169,
         n170, n171, n172, n173, n174, n175, n176, n177, n178, n179, n180,
         n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191,
         n192, n193, n194, n195, n196, n197, n198, n199, n200, n201, n202,
         n203, n204, n205, n206, n207, n208, n209, n210, n211, n212, n213,
         n214, n215, n216, n217, n218, n219, n220, n221, n222, n223, n224,
         n225, n226, n227, n228, n229, n230, n231, n232, n233, n234, n235,
         n236, n237, n238, n239, n240, n241, n242, n243, n244, n245, n246,
         n247, n248, n249, n250, n251, n252, n253, n254, n255, n256, n257,
         n258, n259, n260, n262, n263, n264, n265, n266, n267, n268, n269,
         n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, n280,
         n281;
  wire   [7:0] price;
  wire   [7:0] stock;
  wire   [7:0] \u_credit_reg/pending_coin_value ;
  wire   [1:0] \u_credit_reg/coin_in_q ;
  assign dispense = mem_write;

  DFFX1_RVT \u_memory/read_valid_reg  ( .D(\u_memory/N61 ), .CLK(clk), .Q(
        read_valid) );
  DFFX1_RVT \u_control_unit/state_q_reg[2]  ( .D(\u_control_unit/N49 ), .CLK(
        clk), .Q(state_out[2]), .QN(n262) );
  DFFX1_RVT \u_control_unit/state_q_reg[0]  ( .D(\u_control_unit/N47 ), .CLK(
        clk), .Q(state_out[0]), .QN(n274) );
  DFFX1_RVT \u_memory/price_reg[0]  ( .D(n154), .CLK(clk), .Q(price[0]), .QN(
        n266) );
  DFFX1_RVT \u_memory/price_reg[1]  ( .D(n153), .CLK(clk), .Q(price[1]), .QN(
        n267) );
  DFFX1_RVT \u_memory/price_reg[2]  ( .D(n152), .CLK(clk), .Q(price[2]), .QN(
        n268) );
  DFFX1_RVT \u_memory/price_reg[3]  ( .D(n151), .CLK(clk), .Q(price[3]), .QN(
        n270) );
  DFFX1_RVT \u_memory/price_reg[4]  ( .D(n150), .CLK(clk), .Q(price[4]), .QN(
        n271) );
  DFFX1_RVT \u_memory/price_reg[5]  ( .D(n149), .CLK(clk), .Q(price[5]), .QN(
        n272) );
  DFFX1_RVT \u_memory/price_reg[6]  ( .D(n148), .CLK(clk), .Q(price[6]), .QN(
        n275) );
  DFFX1_RVT \u_credit_reg/coin_in_q_reg[0]  ( .D(\u_credit_reg/N64 ), .CLK(clk), .Q(\u_credit_reg/coin_in_q [0]) );
  DFFX1_RVT \u_credit_reg/coin_in_q_reg[1]  ( .D(\u_credit_reg/N65 ), .CLK(clk), .Q(\u_credit_reg/coin_in_q [1]) );
  DFFX1_RVT \u_credit_reg/pending_coin_value_reg[0]  ( .D(n107), .CLK(clk), 
        .Q(\u_credit_reg/pending_coin_value [0]) );
  DFFX1_RVT \u_credit_reg/pending_coin_value_reg[3]  ( .D(n104), .CLK(clk), 
        .Q(\u_credit_reg/pending_coin_value [3]) );
  DFFX1_RVT \u_credit_reg/pending_coin_value_reg[5]  ( .D(n102), .CLK(clk), 
        .Q(\u_credit_reg/pending_coin_value [5]), .QN(n276) );
  DFFX1_RVT \u_credit_reg/pending_coin_value_reg[1]  ( .D(n106), .CLK(clk), 
        .Q(\u_credit_reg/pending_coin_value [1]), .QN(n269) );
  DFFX1_RVT \u_credit_reg/pending_coin_value_reg[2]  ( .D(n105), .CLK(clk), 
        .Q(\u_credit_reg/pending_coin_value [2]), .QN(n277) );
  DFFX1_RVT \u_credit_reg/pending_coin_value_reg[6]  ( .D(n101), .CLK(clk), 
        .Q(\u_credit_reg/pending_coin_value [6]) );
  DFFX1_RVT \u_credit_reg/coin_pending_reg  ( .D(n100), .CLK(clk), .Q(
        \u_credit_reg/coin_pending ), .QN(n264) );
  DFFX1_RVT \u_credit_reg/credit_reg[0]  ( .D(n99), .CLK(clk), .Q(display[0])
         );
  DFFX1_RVT \u_credit_reg/credit_reg[7]  ( .D(n98), .CLK(clk), .Q(display[7])
         );
  DFFX1_RVT \u_credit_reg/credit_reg[6]  ( .D(n97), .CLK(clk), .Q(display[6])
         );
  DFFX1_RVT \u_credit_reg/credit_reg[5]  ( .D(n96), .CLK(clk), .Q(display[5])
         );
  DFFX1_RVT \u_credit_reg/credit_reg[4]  ( .D(n95), .CLK(clk), .Q(display[4])
         );
  DFFX1_RVT \u_credit_reg/credit_reg[3]  ( .D(n94), .CLK(clk), .Q(display[3])
         );
  DFFX1_RVT \u_credit_reg/credit_reg[2]  ( .D(n93), .CLK(clk), .Q(display[2])
         );
  DFFX1_RVT \u_credit_reg/credit_reg[1]  ( .D(n92), .CLK(clk), .Q(display[1])
         );
  DFFX1_RVT \u_memory/mem_reg[3][1]  ( .D(n138), .CLK(clk), .Q(
        \u_memory/mem[3][1] ) );
  DFFX1_RVT \u_memory/mem_reg[3][0]  ( .D(n139), .CLK(clk), .Q(
        \u_memory/mem[3][0] ) );
  DFFX1_RVT \u_memory/mem_reg[3][2]  ( .D(n137), .CLK(clk), .Q(
        \u_memory/mem[3][2] ) );
  DFFX1_RVT \u_memory/mem_reg[3][3]  ( .D(n136), .CLK(clk), .Q(
        \u_memory/mem[3][3] ) );
  DFFX1_RVT \u_memory/mem_reg[3][4]  ( .D(n135), .CLK(clk), .Q(
        \u_memory/mem[3][4] ) );
  DFFX1_RVT \u_memory/mem_reg[2][0]  ( .D(n131), .CLK(clk), .Q(
        \u_memory/mem[2][0] ) );
  DFFX1_RVT \u_memory/mem_reg[2][1]  ( .D(n130), .CLK(clk), .Q(
        \u_memory/mem[2][1] ) );
  DFFX1_RVT \u_memory/mem_reg[2][2]  ( .D(n129), .CLK(clk), .Q(
        \u_memory/mem[2][2] ) );
  DFFX1_RVT \u_memory/mem_reg[2][3]  ( .D(n128), .CLK(clk), .Q(
        \u_memory/mem[2][3] ) );
  DFFX1_RVT \u_memory/mem_reg[2][4]  ( .D(n127), .CLK(clk), .Q(
        \u_memory/mem[2][4] ) );
  DFFX1_RVT \u_memory/mem_reg[1][0]  ( .D(n123), .CLK(clk), .Q(
        \u_memory/mem[1][0] ) );
  DFFX1_RVT \u_memory/mem_reg[1][2]  ( .D(n121), .CLK(clk), .Q(
        \u_memory/mem[1][2] ) );
  DFFX1_RVT \u_memory/mem_reg[1][1]  ( .D(n122), .CLK(clk), .Q(
        \u_memory/mem[1][1] ) );
  DFFX1_RVT \u_memory/mem_reg[1][3]  ( .D(n120), .CLK(clk), .Q(
        \u_memory/mem[1][3] ) );
  DFFX1_RVT \u_memory/mem_reg[1][4]  ( .D(n119), .CLK(clk), .Q(
        \u_memory/mem[1][4] ) );
  DFFX1_RVT \u_memory/mem_reg[0][0]  ( .D(n115), .CLK(clk), .Q(
        \u_memory/mem[0][0] ) );
  DFFX1_RVT \u_memory/stock_reg[0]  ( .D(n147), .CLK(clk), .Q(stock[0]) );
  DFFX1_RVT \u_memory/mem_reg[0][2]  ( .D(n113), .CLK(clk), .Q(
        \u_memory/mem[0][2] ) );
  DFFX1_RVT \u_memory/stock_reg[2]  ( .D(n145), .CLK(clk), .Q(stock[2]) );
  DFFX1_RVT \u_memory/mem_reg[0][1]  ( .D(n114), .CLK(clk), .Q(
        \u_memory/mem[0][1] ) );
  DFFX1_RVT \u_memory/stock_reg[1]  ( .D(n146), .CLK(clk), .Q(stock[1]) );
  DFFX1_RVT \u_memory/mem_reg[0][3]  ( .D(n112), .CLK(clk), .Q(
        \u_memory/mem[0][3] ) );
  DFFX1_RVT \u_memory/stock_reg[3]  ( .D(n144), .CLK(clk), .Q(stock[3]) );
  DFFX1_RVT \u_memory/mem_reg[0][4]  ( .D(n111), .CLK(clk), .Q(
        \u_memory/mem[0][4] ) );
  DFFX1_RVT \u_memory/stock_reg[4]  ( .D(n143), .CLK(clk), .Q(stock[4]), .QN(
        n265) );
  DFFX1_RVT \change_out_reg[0]  ( .D(n91), .CLK(clk), .Q(change_out[0]) );
  DFFX1_RVT \change_out_reg[1]  ( .D(n90), .CLK(clk), .Q(change_out[1]) );
  DFFX1_RVT \change_out_reg[2]  ( .D(n89), .CLK(clk), .Q(change_out[2]) );
  DFFX1_RVT \change_out_reg[3]  ( .D(n88), .CLK(clk), .Q(change_out[3]) );
  DFFX1_RVT \change_out_reg[4]  ( .D(n87), .CLK(clk), .Q(change_out[4]) );
  DFFX1_RVT \change_out_reg[5]  ( .D(n86), .CLK(clk), .Q(change_out[5]) );
  DFFX1_RVT \change_out_reg[6]  ( .D(n85), .CLK(clk), .Q(change_out[6]) );
  DFFX1_RVT \change_out_reg[7]  ( .D(n84), .CLK(clk), .Q(change_out[7]) );
  HADDX1_RVT \DP_OP_22J1_122_2962/U9  ( .A0(\C1/Z_0 ), .B0(display[0]), .C1(
        \DP_OP_22J1_122_2962/n8 ), .SO(\u_credit_reg/N42 ) );
  FADDX1_RVT \DP_OP_22J1_122_2962/U8  ( .A(\C1/Z_1 ), .B(display[1]), .CI(
        \DP_OP_22J1_122_2962/n8 ), .CO(\DP_OP_22J1_122_2962/n7 ), .S(
        \u_credit_reg/N43 ) );
  FADDX1_RVT \DP_OP_22J1_122_2962/U7  ( .A(\C1/Z_2 ), .B(display[2]), .CI(
        \DP_OP_22J1_122_2962/n7 ), .CO(\DP_OP_22J1_122_2962/n6 ), .S(
        \u_credit_reg/N44 ) );
  FADDX1_RVT \DP_OP_22J1_122_2962/U6  ( .A(\C1/Z_3 ), .B(display[3]), .CI(
        \DP_OP_22J1_122_2962/n6 ), .CO(\DP_OP_22J1_122_2962/n5 ), .S(
        \u_credit_reg/N45 ) );
  FADDX1_RVT \DP_OP_22J1_122_2962/U5  ( .A(\C1/Z_4 ), .B(display[4]), .CI(
        \DP_OP_22J1_122_2962/n5 ), .CO(\DP_OP_22J1_122_2962/n4 ), .S(
        \u_credit_reg/N46 ) );
  FADDX1_RVT \DP_OP_22J1_122_2962/U4  ( .A(\C1/Z_5 ), .B(display[5]), .CI(
        \DP_OP_22J1_122_2962/n4 ), .CO(\DP_OP_22J1_122_2962/n3 ), .S(
        \u_credit_reg/N47 ) );
  FADDX1_RVT \DP_OP_22J1_122_2962/U3  ( .A(\C1/Z_6 ), .B(display[6]), .CI(
        \DP_OP_22J1_122_2962/n3 ), .CO(\DP_OP_22J1_122_2962/n2 ), .S(
        \u_credit_reg/N48 ) );
  FADDX1_RVT \intadd_0/U6  ( .A(display[2]), .B(n268), .CI(\intadd_0/CI ), 
        .CO(\intadd_0/n5 ), .S(\intadd_0/SUM[0] ) );
  FADDX1_RVT \intadd_0/U5  ( .A(display[3]), .B(n270), .CI(\intadd_0/n5 ), 
        .CO(\intadd_0/n4 ), .S(\intadd_0/SUM[1] ) );
  FADDX1_RVT \intadd_0/U4  ( .A(display[4]), .B(n271), .CI(\intadd_0/n4 ), 
        .CO(\intadd_0/n3 ), .S(\intadd_0/SUM[2] ) );
  FADDX1_RVT \intadd_0/U3  ( .A(display[5]), .B(n272), .CI(\intadd_0/n3 ), 
        .CO(\intadd_0/n2 ), .S(\intadd_0/SUM[3] ) );
  FADDX1_RVT \intadd_0/U2  ( .A(display[6]), .B(n275), .CI(\intadd_0/n2 ), 
        .CO(\intadd_0/n1 ), .S(\intadd_0/SUM[4] ) );
  DFFSSRX1_RVT \u_credit_reg/pending_coin_value_reg[4]  ( .D(n279), .SETB(n164), .RSTB(n278), .CLK(clk), .Q(n273) );
  DFFSSRX1_RVT \u_control_unit/state_q_reg[1]  ( .D(n281), .SETB(1'b1), .RSTB(
        n280), .CLK(clk), .Q(state_out[1]), .QN(n263) );
  NOR2X0_RVT U179 ( .A1(n178), .A2(n182), .Y(n164) );
  INVX0_RVT U180 ( .A(n183), .Y(n172) );
  OR2X1_RVT U181 ( .A1(\u_credit_reg/coin_pending ), .A2(n176), .Y(n183) );
  OR2X1_RVT U182 ( .A1(n266), .A2(display[0]), .Y(n249) );
  OR2X1_RVT U183 ( .A1(n171), .A2(n174), .Y(\C1/Z_2 ) );
  INVX0_RVT U184 ( .A(confirm), .Y(n203) );
  INVX0_RVT U185 ( .A(n249), .Y(n251) );
  INVX0_RVT U186 ( .A(n247), .Y(n242) );
  OA21X1_RVT U187 ( .A1(n210), .A2(n238), .A3(n255), .Y(n226) );
  XOR2X1_RVT U188 ( .A1(\DP_OP_22J1_122_2962/n2 ), .A2(display[7]), .Y(n177)
         );
  AND2X1_RVT U189 ( .A1(n255), .A2(n206), .Y(n209) );
  NOR2X0_RVT U190 ( .A1(rst), .A2(cancel), .Y(n281) );
  OAI21X1_RVT U191 ( .A1(n277), .A2(n185), .A3(n169), .Y(n105) );
  AND2X1_RVT U192 ( .A1(n199), .A2(n255), .Y(\u_memory/N61 ) );
  INVX1_RVT U193 ( .A(n248), .Y(mem_write) );
  NAND3X0_RVT U195 ( .A1(n274), .A2(state_out[2]), .A3(n263), .Y(n165) );
  NAND2X0_RVT U196 ( .A1(n281), .A2(n165), .Y(n178) );
  INVX0_RVT U197 ( .A(coin_in[0]), .Y(n187) );
  AND2X1_RVT U198 ( .A1(n187), .A2(coin_in[1]), .Y(n166) );
  NOR2X0_RVT U199 ( .A1(coin_in[1]), .A2(n187), .Y(n184) );
  NOR2X0_RVT U200 ( .A1(n166), .A2(n184), .Y(n182) );
  NAND3X0_RVT U201 ( .A1(state_out[0]), .A2(state_out[1]), .A3(n262), .Y(n248)
         );
  NAND3X0_RVT U202 ( .A1(state_out[1]), .A2(n262), .A3(n274), .Y(n206) );
  INVX0_RVT U203 ( .A(n206), .Y(n199) );
  INVX0_RVT U204 ( .A(rst), .Y(n255) );
  INVX0_RVT U205 ( .A(coin_in[1]), .Y(n170) );
  NAND2X0_RVT U206 ( .A1(n170), .A2(n187), .Y(n197) );
  INVX0_RVT U207 ( .A(n197), .Y(n167) );
  OR3X1_RVT U208 ( .A1(\u_credit_reg/coin_in_q [1]), .A2(n167), .A3(
        \u_credit_reg/coin_in_q [0]), .Y(n176) );
  NAND3X0_RVT U209 ( .A1(state_out[0]), .A2(n262), .A3(n263), .Y(n202) );
  INVX0_RVT U210 ( .A(n202), .Y(n179) );
  NOR2X0_RVT U211 ( .A1(n176), .A2(n179), .Y(n168) );
  OR2X1_RVT U212 ( .A1(n168), .A2(n178), .Y(n185) );
  INVX0_RVT U213 ( .A(n185), .Y(n279) );
  INVX0_RVT U214 ( .A(n178), .Y(n196) );
  AND2X1_RVT U215 ( .A1(coin_in[1]), .A2(n196), .Y(\u_credit_reg/N65 ) );
  AND2X1_RVT U216 ( .A1(\u_credit_reg/N65 ), .A2(n185), .Y(n188) );
  AND2X1_RVT U217 ( .A1(n188), .A2(coin_in[0]), .Y(n181) );
  INVX0_RVT U218 ( .A(n181), .Y(n169) );
  AND2X1_RVT U219 ( .A1(\u_credit_reg/coin_pending ), .A2(
        \u_credit_reg/pending_coin_value [2]), .Y(n171) );
  OR2X1_RVT U220 ( .A1(n170), .A2(n183), .Y(n189) );
  NOR2X0_RVT U221 ( .A1(n189), .A2(n187), .Y(n174) );
  AND2X1_RVT U222 ( .A1(\u_credit_reg/coin_pending ), .A2(
        \u_credit_reg/pending_coin_value [3]), .Y(n173) );
  AND2X1_RVT U223 ( .A1(n184), .A2(n172), .Y(n192) );
  OR2X1_RVT U224 ( .A1(n173), .A2(n192), .Y(\C1/Z_3 ) );
  OAI21X1_RVT U225 ( .A1(n264), .A2(n276), .A3(n189), .Y(\C1/Z_5 ) );
  AND2X1_RVT U226 ( .A1(\u_credit_reg/coin_pending ), .A2(
        \u_credit_reg/pending_coin_value [6]), .Y(n175) );
  OR2X1_RVT U227 ( .A1(n175), .A2(n174), .Y(\C1/Z_6 ) );
  AND2X1_RVT U228 ( .A1(n176), .A2(n264), .Y(n180) );
  OA21X1_RVT U229 ( .A1(n202), .A2(n180), .A3(n196), .Y(n195) );
  NOR2X0_RVT U230 ( .A1(n178), .A2(n195), .Y(n194) );
  AO22X1_RVT U231 ( .A1(n195), .A2(display[7]), .A3(n177), .A4(n194), .Y(n98)
         );
  AO22X1_RVT U232 ( .A1(n195), .A2(display[5]), .A3(\u_credit_reg/N47 ), .A4(
        n194), .Y(n96) );
  AO22X1_RVT U233 ( .A1(n195), .A2(display[4]), .A3(\u_credit_reg/N46 ), .A4(
        n194), .Y(n95) );
  AO22X1_RVT U234 ( .A1(n195), .A2(display[3]), .A3(\u_credit_reg/N45 ), .A4(
        n194), .Y(n94) );
  AO22X1_RVT U235 ( .A1(n195), .A2(display[2]), .A3(\u_credit_reg/N44 ), .A4(
        n194), .Y(n93) );
  AO22X1_RVT U236 ( .A1(n195), .A2(display[1]), .A3(\u_credit_reg/N43 ), .A4(
        n194), .Y(n92) );
  AO22X1_RVT U237 ( .A1(n195), .A2(display[0]), .A3(\u_credit_reg/N42 ), .A4(
        n194), .Y(n99) );
  NOR3X0_RVT U238 ( .A1(n180), .A2(n179), .A3(n178), .Y(n100) );
  AO21X1_RVT U239 ( .A1(\u_credit_reg/pending_coin_value [6]), .A2(n279), .A3(
        n181), .Y(n101) );
  AO21X1_RVT U240 ( .A1(n279), .A2(\u_credit_reg/pending_coin_value [5]), .A3(
        n188), .Y(n102) );
  OR2X1_RVT U241 ( .A1(n273), .A2(n185), .Y(n278) );
  OAI22X1_RVT U242 ( .A1(n264), .A2(n273), .A3(n183), .A4(n182), .Y(\C1/Z_4 )
         );
  AND2X1_RVT U243 ( .A1(n279), .A2(\u_credit_reg/pending_coin_value [3]), .Y(
        n186) );
  AND3X1_RVT U244 ( .A1(n185), .A2(n196), .A3(n184), .Y(n190) );
  OR2X1_RVT U245 ( .A1(n186), .A2(n190), .Y(n104) );
  AO22X1_RVT U246 ( .A1(n188), .A2(n187), .A3(n279), .A4(
        \u_credit_reg/pending_coin_value [1]), .Y(n106) );
  OAI22X1_RVT U247 ( .A1(n269), .A2(n264), .A3(coin_in[0]), .A4(n189), .Y(
        \C1/Z_1 ) );
  AND2X1_RVT U248 ( .A1(n279), .A2(\u_credit_reg/pending_coin_value [0]), .Y(
        n191) );
  OR2X1_RVT U249 ( .A1(n191), .A2(n190), .Y(n107) );
  AND2X1_RVT U250 ( .A1(\u_credit_reg/coin_pending ), .A2(
        \u_credit_reg/pending_coin_value [0]), .Y(n193) );
  OR2X1_RVT U251 ( .A1(n193), .A2(n192), .Y(\C1/Z_0 ) );
  AO22X1_RVT U252 ( .A1(n195), .A2(display[6]), .A3(\u_credit_reg/N48 ), .A4(
        n194), .Y(n97) );
  AND2X1_RVT U253 ( .A1(coin_in[0]), .A2(n196), .Y(\u_credit_reg/N64 ) );
  AND3X1_RVT U254 ( .A1(state_out[0]), .A2(state_out[2]), .A3(n263), .Y(error)
         );
  OA222X1_RVT U255 ( .A1(state_out[0]), .A2(n262), .A3(state_out[0]), .A4(n197), .A5(n203), .A6(n274), .Y(n198) );
  AO22X1_RVT U256 ( .A1(n199), .A2(read_valid), .A3(n198), .A4(n263), .Y(n200)
         );
  OA21X1_RVT U257 ( .A1(error), .A2(n200), .A3(n281), .Y(\u_control_unit/N47 )
         );
  AO222X1_RVT U258 ( .A1(display[1]), .A2(n249), .A3(display[1]), .A4(n267), 
        .A5(n249), .A6(n267), .Y(\intadd_0/CI ) );
  NOR2X0_RVT U259 ( .A1(\intadd_0/n1 ), .A2(display[7]), .Y(n257) );
  NOR4X1_RVT U260 ( .A1(stock[3]), .A2(stock[2]), .A3(stock[1]), .A4(stock[0]), 
        .Y(n201) );
  OA221X1_RVT U261 ( .A1(n257), .A2(n201), .A3(n257), .A4(n265), .A5(
        read_valid), .Y(n204) );
  OAI22X1_RVT U262 ( .A1(n203), .A2(n202), .A3(n206), .A4(n204), .Y(n280) );
  AND3X1_RVT U263 ( .A1(state_out[1]), .A2(n204), .A3(n262), .Y(n205) );
  AND2X1_RVT U264 ( .A1(mem_write), .A2(n281), .Y(n258) );
  AO221X1_RVT U265 ( .A1(n281), .A2(n205), .A3(n281), .A4(error), .A5(n258), 
        .Y(\u_control_unit/N49 ) );
  INVX0_RVT U266 ( .A(sel_item[0]), .Y(n237) );
  AO22X1_RVT U267 ( .A1(n209), .A2(price[0]), .A3(\u_memory/N61 ), .A4(n237), 
        .Y(n154) );
  NAND2X0_RVT U268 ( .A1(n237), .A2(sel_item[1]), .Y(n227) );
  INVX0_RVT U269 ( .A(sel_item[1]), .Y(n236) );
  NAND2X0_RVT U270 ( .A1(sel_item[0]), .A2(n236), .Y(n232) );
  NAND2X0_RVT U271 ( .A1(n227), .A2(n232), .Y(n207) );
  AO22X1_RVT U272 ( .A1(\u_memory/N61 ), .A2(n207), .A3(n209), .A4(price[1]), 
        .Y(n153) );
  NAND2X0_RVT U273 ( .A1(sel_item[0]), .A2(sel_item[1]), .Y(n210) );
  INVX0_RVT U274 ( .A(n210), .Y(n208) );
  AO22X1_RVT U275 ( .A1(n208), .A2(\u_memory/N61 ), .A3(n209), .A4(price[2]), 
        .Y(n152) );
  AO22X1_RVT U276 ( .A1(price[3]), .A2(n209), .A3(\u_memory/N61 ), .A4(n237), 
        .Y(n151) );
  AO22X1_RVT U277 ( .A1(price[4]), .A2(n209), .A3(\u_memory/N61 ), .A4(n236), 
        .Y(n150) );
  AO22X1_RVT U278 ( .A1(sel_item[0]), .A2(\u_memory/N61 ), .A3(n209), .A4(
        price[5]), .Y(n149) );
  AO22X1_RVT U279 ( .A1(sel_item[1]), .A2(\u_memory/N61 ), .A3(n209), .A4(
        price[6]), .Y(n148) );
  MUX41X1_RVT U280 ( .A1(\u_memory/mem[0][0] ), .A3(\u_memory/mem[1][0] ), 
        .A2(\u_memory/mem[2][0] ), .A4(\u_memory/mem[3][0] ), .S0(sel_item[0]), 
        .S1(sel_item[1]), .Y(n228) );
  AO22X1_RVT U281 ( .A1(n209), .A2(stock[0]), .A3(\u_memory/N61 ), .A4(n228), 
        .Y(n147) );
  MUX41X1_RVT U282 ( .A1(\u_memory/mem[0][1] ), .A3(\u_memory/mem[1][1] ), 
        .A2(\u_memory/mem[2][1] ), .A4(\u_memory/mem[3][1] ), .S0(sel_item[0]), 
        .S1(sel_item[1]), .Y(n213) );
  AO22X1_RVT U283 ( .A1(n209), .A2(stock[1]), .A3(\u_memory/N61 ), .A4(n213), 
        .Y(n146) );
  MUX41X1_RVT U284 ( .A1(\u_memory/mem[0][2] ), .A3(\u_memory/mem[1][2] ), 
        .A2(\u_memory/mem[2][2] ), .A4(\u_memory/mem[3][2] ), .S0(sel_item[0]), 
        .S1(sel_item[1]), .Y(n216) );
  AO22X1_RVT U285 ( .A1(n209), .A2(stock[2]), .A3(\u_memory/N61 ), .A4(n216), 
        .Y(n145) );
  MUX41X1_RVT U286 ( .A1(\u_memory/mem[0][3] ), .A3(\u_memory/mem[1][3] ), 
        .A2(\u_memory/mem[2][3] ), .A4(\u_memory/mem[3][3] ), .S0(sel_item[0]), 
        .S1(sel_item[1]), .Y(n219) );
  AO22X1_RVT U287 ( .A1(n209), .A2(stock[3]), .A3(\u_memory/N61 ), .A4(n219), 
        .Y(n144) );
  MUX41X1_RVT U288 ( .A1(\u_memory/mem[0][4] ), .A3(\u_memory/mem[1][4] ), 
        .A2(\u_memory/mem[2][4] ), .A4(\u_memory/mem[3][4] ), .S0(sel_item[0]), 
        .S1(sel_item[1]), .Y(n222) );
  AO22X1_RVT U289 ( .A1(n209), .A2(stock[4]), .A3(\u_memory/N61 ), .A4(n222), 
        .Y(n143) );
  OR2X1_RVT U290 ( .A1(n228), .A2(n213), .Y(n217) );
  OR2X1_RVT U291 ( .A1(n217), .A2(n216), .Y(n220) );
  OR2X1_RVT U292 ( .A1(n220), .A2(n219), .Y(n223) );
  OR2X1_RVT U293 ( .A1(n223), .A2(n222), .Y(n224) );
  NAND2X0_RVT U294 ( .A1(n224), .A2(mem_write), .Y(n238) );
  INVX0_RVT U295 ( .A(n228), .Y(n211) );
  INVX0_RVT U296 ( .A(n226), .Y(n214) );
  AND2X1_RVT U297 ( .A1(n255), .A2(n214), .Y(n225) );
  AO22X1_RVT U298 ( .A1(\u_memory/mem[3][0] ), .A2(n226), .A3(n211), .A4(n225), 
        .Y(n139) );
  INVX0_RVT U299 ( .A(n217), .Y(n212) );
  AO21X1_RVT U300 ( .A1(n228), .A2(n213), .A3(n212), .Y(n241) );
  AO221X1_RVT U301 ( .A1(n241), .A2(n214), .A3(n226), .A4(\u_memory/mem[3][1] ), .A5(rst), .Y(n138) );
  INVX0_RVT U302 ( .A(n220), .Y(n215) );
  AO21X1_RVT U303 ( .A1(n217), .A2(n216), .A3(n215), .Y(n243) );
  AO22X1_RVT U304 ( .A1(\u_memory/mem[3][2] ), .A2(n226), .A3(n225), .A4(n243), 
        .Y(n137) );
  INVX0_RVT U305 ( .A(n223), .Y(n218) );
  AO21X1_RVT U306 ( .A1(n220), .A2(n219), .A3(n218), .Y(n244) );
  AO22X1_RVT U307 ( .A1(\u_memory/mem[3][3] ), .A2(n226), .A3(n225), .A4(n244), 
        .Y(n136) );
  INVX0_RVT U308 ( .A(n224), .Y(n221) );
  AO21X1_RVT U309 ( .A1(n223), .A2(n222), .A3(n221), .Y(n245) );
  AO22X1_RVT U310 ( .A1(\u_memory/mem[3][4] ), .A2(n226), .A3(n225), .A4(n245), 
        .Y(n135) );
  OA21X1_RVT U311 ( .A1(n227), .A2(n238), .A3(n255), .Y(n231) );
  INVX0_RVT U312 ( .A(n231), .Y(n229) );
  NAND2X0_RVT U313 ( .A1(n228), .A2(n255), .Y(n240) );
  AO22X1_RVT U314 ( .A1(n231), .A2(\u_memory/mem[2][0] ), .A3(n229), .A4(n240), 
        .Y(n131) );
  AO221X1_RVT U315 ( .A1(n241), .A2(n229), .A3(n231), .A4(\u_memory/mem[2][1] ), .A5(rst), .Y(n130) );
  AND2X1_RVT U316 ( .A1(n255), .A2(n229), .Y(n230) );
  AO22X1_RVT U317 ( .A1(\u_memory/mem[2][2] ), .A2(n231), .A3(n230), .A4(n243), 
        .Y(n129) );
  AO22X1_RVT U318 ( .A1(\u_memory/mem[2][3] ), .A2(n231), .A3(n230), .A4(n244), 
        .Y(n128) );
  AO22X1_RVT U319 ( .A1(\u_memory/mem[2][4] ), .A2(n231), .A3(n230), .A4(n245), 
        .Y(n127) );
  OA21X1_RVT U320 ( .A1(n232), .A2(n238), .A3(n255), .Y(n235) );
  INVX0_RVT U321 ( .A(n235), .Y(n233) );
  AO22X1_RVT U322 ( .A1(n235), .A2(\u_memory/mem[1][0] ), .A3(n233), .A4(n240), 
        .Y(n123) );
  AND2X1_RVT U323 ( .A1(n255), .A2(n233), .Y(n234) );
  AO22X1_RVT U324 ( .A1(\u_memory/mem[1][1] ), .A2(n235), .A3(n234), .A4(n241), 
        .Y(n122) );
  AO221X1_RVT U325 ( .A1(n243), .A2(n233), .A3(n235), .A4(\u_memory/mem[1][2] ), .A5(rst), .Y(n121) );
  AO22X1_RVT U326 ( .A1(\u_memory/mem[1][3] ), .A2(n235), .A3(n234), .A4(n244), 
        .Y(n120) );
  AO22X1_RVT U327 ( .A1(\u_memory/mem[1][4] ), .A2(n235), .A3(n234), .A4(n245), 
        .Y(n119) );
  NAND2X0_RVT U328 ( .A1(n237), .A2(n236), .Y(n239) );
  OA21X1_RVT U329 ( .A1(n239), .A2(n238), .A3(n255), .Y(n247) );
  AO22X1_RVT U330 ( .A1(n247), .A2(\u_memory/mem[0][0] ), .A3(n242), .A4(n240), 
        .Y(n115) );
  AND2X1_RVT U331 ( .A1(n255), .A2(n242), .Y(n246) );
  AO22X1_RVT U332 ( .A1(\u_memory/mem[0][1] ), .A2(n247), .A3(n246), .A4(n241), 
        .Y(n114) );
  AO221X1_RVT U333 ( .A1(n243), .A2(n242), .A3(n247), .A4(\u_memory/mem[0][2] ), .A5(rst), .Y(n113) );
  AO22X1_RVT U334 ( .A1(\u_memory/mem[0][3] ), .A2(n247), .A3(n246), .A4(n244), 
        .Y(n112) );
  AO22X1_RVT U335 ( .A1(\u_memory/mem[0][4] ), .A2(n247), .A3(n246), .A4(n245), 
        .Y(n111) );
  AO22X1_RVT U336 ( .A1(n258), .A2(n266), .A3(cancel), .A4(n255), .Y(n250) );
  AND2X1_RVT U337 ( .A1(n281), .A2(n248), .Y(n256) );
  AO222X1_RVT U338 ( .A1(n250), .A2(display[0]), .A3(n256), .A4(change_out[0]), 
        .A5(n258), .A6(n251), .Y(n91) );
  FADDX1_RVT U339 ( .A(display[1]), .B(n251), .CI(price[1]), .S(n253) );
  AND2X1_RVT U340 ( .A1(cancel), .A2(n255), .Y(n254) );
  AO22X1_RVT U341 ( .A1(display[1]), .A2(n254), .A3(n256), .A4(change_out[1]), 
        .Y(n252) );
  AO21X1_RVT U342 ( .A1(n258), .A2(n253), .A3(n252), .Y(n90) );
  AO222X1_RVT U343 ( .A1(n258), .A2(\intadd_0/SUM[0] ), .A3(n254), .A4(
        display[2]), .A5(n256), .A6(change_out[2]), .Y(n89) );
  AO222X1_RVT U344 ( .A1(n258), .A2(\intadd_0/SUM[1] ), .A3(n254), .A4(
        display[3]), .A5(n256), .A6(change_out[3]), .Y(n88) );
  AO222X1_RVT U345 ( .A1(n258), .A2(\intadd_0/SUM[2] ), .A3(n254), .A4(
        display[4]), .A5(n256), .A6(change_out[4]), .Y(n87) );
  AO222X1_RVT U346 ( .A1(n258), .A2(\intadd_0/SUM[3] ), .A3(n254), .A4(
        display[5]), .A5(n256), .A6(change_out[5]), .Y(n86) );
  AO222X1_RVT U347 ( .A1(n258), .A2(\intadd_0/SUM[4] ), .A3(n254), .A4(
        display[6]), .A5(n256), .A6(change_out[6]), .Y(n85) );
  AO22X1_RVT U348 ( .A1(\intadd_0/n1 ), .A2(n258), .A3(cancel), .A4(n255), .Y(
        n260) );
  AO22X1_RVT U349 ( .A1(n258), .A2(n257), .A3(n256), .A4(change_out[7]), .Y(
        n259) );
  AO21X1_RVT U350 ( .A1(display[7]), .A2(n260), .A3(n259), .Y(n84) );
endmodule

