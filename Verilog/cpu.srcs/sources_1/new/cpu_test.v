`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/28 01:33:21
// Design Name: 
// Module Name: cpu_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_test(
    input fq100m,
    input disp_key1, disp_key0, rst_key, memr_key3, memr_key2, memr_key1, memr_key0,
    output [6:0] seg,
    output [7:0] an
    );
    wire fq1;
    wire [3:0] ds_count;
    wire [31:0] a0value;
    wire [31:0] clkcount;
    wire [31:0] digital_tube;
    wire [31:0] memread;
    
    wire [31:0] mem0;
    wire [31:0] mem1;
    wire [31:0] mem2;
    wire [31:0] mem3;
    wire [31:0] mem4;
    wire [31:0] mem5;
    wire [31:0] mem6;
    wire [31:0] mem7;
    wire [31:0] mem8;
    wire [31:0] mem9;
    wire [31:0] mem10;
    wire [31:0] mem11;
    wire [31:0] mem12;
    wire [31:0] mem13;
    wire [31:0] mem14;
    wire [31:0] mem15;
    
    assign memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'h0) ? mem0 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'h1) ? mem1 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'h2) ? mem2 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'h3) ? mem3 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'h4) ? mem4 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'h5) ? mem5 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'h6) ? mem6 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'h7) ? mem7 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'h8) ? mem8 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'h9) ? mem9 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'ha) ? mem10 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'hb) ? mem11 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'hc) ? mem12 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'hd) ? mem13 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'he) ? mem14 : 32'hz,
           memread = ({{memr_key3, memr_key2}, {memr_key1, memr_key0}} == 4'hf) ? mem15 : 32'hz;    
    
    assign digital_tube = ({disp_key1, disp_key0} == 2'h0) ? a0value : 32'hz,
           digital_tube = ({disp_key1, disp_key0} == 2'h1) ? clkcount : 32'hz,
           digital_tube = ({disp_key1, disp_key0} == 2'h2) ? memread : 32'hz,
           digital_tube = ({disp_key1, disp_key0} == 2'h3) ? memread : 32'hz;
    
    generator GT (.fq100m(fq100m), .fq1(fq1), .ds_count(ds_count));
    //cpu CPU (.ComClk(fq1), .Rst(rst_key), .Digital_Tube(a0value), .ClkCount(clkcount));
    cpu CPU (.ComClk(fq1), .Rst(rst_key), .Digital_Tube(a0value), .ClkCount(clkcount), .mem0(mem0), .mem1(mem1), .mem2(mem2), .mem3(mem3), .mem4(mem4), .mem5(mem5), .mem6(mem6), .mem7(mem7), .mem8(mem8), .mem9(mem9), .mem10(mem10), .mem11(mem11), .mem12(mem12), .mem13(mem13), .mem14(mem14), .mem15(mem15));
    display DISP (.ds_count(ds_count), .data(digital_tube), .seg(seg), .an(an));
endmodule
