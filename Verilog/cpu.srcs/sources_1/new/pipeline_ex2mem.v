`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/03 03:52:52
// Design Name:
// Module Name: pipeline_ex2mem
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


module pipeline_ex2mem(
    input WE,
    input Rst,
    input Clk,
    input Asyn_Rst,

    input [31:0] CP01_Din,
    input [31:0] CP00_Din,
    input [6:0] INTCtl_Din,
    input [31:0] a0_Din,
    input Disp_Din,
    input Halt_Din,
    input [31:0] PC_Din,
    input [31:0] IR_Din,
    input DMWE_Din,
    input RFWE_Din,
    input [1:0] RFDinSrc_Din,
    input [31:0] ALU_Din,
    input [31:0] RFD2_Din,
    input [31:0] PCAdd_Din,
    input [4:0] WReg_Din,

    output [31:0] CP01_Dout,
    output [31:0] CP00_Dout,
    output [6:0] INTCtl_Dout,
    output [31:0] a0_Dout,
    output Disp_Dout,
    output Halt_Dout,
    output [31:0] PC_Dout,
    output [31:0] IR_Dout,
    output DMWE_Dout,
    output RFWE_Dout,
    output [1:0] RFDinSrc_Dout,
    output [31:0] ALU_Dout,
    output [31:0] RFD2_Dout,
    output [31:0] PCAdd_Dout,
    output [4:0] WReg_Dout
    );

    pipeline_register #(32) CP01(.din(CP01_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(CP01_Dout));
    pipeline_register #(32) CP00(.din(CP00_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(CP00_Dout));
    pipeline_register #(7) INTCtl(.din(INTCtl_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(INTCtl_Dout));
    pipeline_register #(32) a0(.din(a0_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(a0_Dout));
    pipeline_register #(1) Disp(.din(Disp_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(Disp_Dout));
    pipeline_register #(1) Halt(.din(Halt_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(Halt_Dout));
    pipeline_register #(32) PC(.din(PC_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(PC_Dout));
    pipeline_register #(32) IR(.din(IR_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(IR_Dout));
    pipeline_register #(1) DMWE(.din(DMWE_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(DMWE_Dout));
    pipeline_register #(1) RFWE(.din(RFWE_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(RFWE_Dout));
    pipeline_register #(2) RFDinSrc(.din(RFDinSrc_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(RFDinSrc_Dout));
    pipeline_register #(32) ALU (.din(ALU_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(ALU_Dout));
    pipeline_register #(32) RFD2(.din(RFD2_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(RFD2_Dout));
    pipeline_register #(32) PCAdd(.din(PCAdd_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(PCAdd_Dout));
    pipeline_register #(5) WReg(.din(WReg_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(WReg_Dout));

endmodule
