`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/03 02:26:43
// Design Name:
// Module Name: pipeline_if2id
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


module pipeline_if2id(
    input WE,
    input Rst,
    input Clk,
    input Asyn_Rst,
    input [8:0] BHTItem_Din,
    input [31:0] PC_PLUS_1_Din,
    input [31:0] PC_Din,
    input [31:0] IR_Din,
    output [8:0] BHTItem_Dout,
    output [31:0] PC_PLUS_1_Dout,
    output [31:0] PC_Dout,
    output [31:0] IR_Dout
    );
    pipeline_register #(9) BHTItem(.din(BHTItem_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(BHTItem_Dout));
    pipeline_register #(32) PC_PLUS_1(.din(PC_PLUS_1_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(PC_PLUS_1_Dout));
    pipeline_register #(32) PC(.din(PC_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(PC_Dout));
    pipeline_register #(32) IR(.din(IR_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(IR_Dout));
endmodule
