`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/03 02:38:41
// Design Name:
// Module Name: pipeline_id2ex
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


module pipeline_id2ex(
    input WE,
    input Rst,
    input Clk,
    input Asyn_Rst,

    input [8:0] BHTItem_Din,
    input [31:0] CP01_Din,
    input [31:0] CP00_Din,
    input [6:0] INTCtl_Din,
    input Load_Din,
    input [1:0] RDTR1Src_Din,
    input [1:0] RDTR2Src_Din,
    input [31:0] a0_Din,
    input [31:0] v0_Din,
    input Syscall_Din,
    input [31:0] PC_PLUS_1_Din,
    input [31:0] PC_Din,
    input [31:0] IR_Din,
    input [3:0] ALUOP_Din,
    input [1:0] ALUYSrc_Din,
    input ALUYSrc2_Din,
    input [31:0] RFD1_Din,
    input [31:0] RFD2_Din,
    input [31:0] Ext5to32_Din,
    input [31:0] SExt16to32_Din,
    input [31:0] Ext16to32_Din,
    input [31:0] Ext26to32_Din,
    input DMWE_Din,
    input PCAddSrc_Din,
    input RFWE_Din,
    input [1:0] RFDinSrc_Din,
    input [6:0] BrIns_Din,
    input [4:0] WReg_Din,

    output [8:0] BHTItem_Dout,
    output [31:0] CP01_Dout,
    output [31:0] CP00_Dout,
    output [6:0] INTCtl_Dout,
    output Load_Dout,
    output [1:0] RDTR1Src_Dout,
    output [1:0] RDTR2Src_Dout,
    output [31:0] a0_Dout,
    output [31:0] v0_Dout,
    output Syscall_Dout,
    output [31:0] PC_PLUS_1_Dout,
    output [31:0] PC_Dout,
    output [31:0] IR_Dout,
    output [3:0] ALUOP_Dout,
    output [1:0] ALUYSrc_Dout,
    output ALUYSrc2_Dout,
    output [31:0] RFD1_Dout,
    output [31:0] RFD2_Dout,
    output [31:0] Ext5to32_Dout,
    output [31:0] SExt16to32_Dout,
    output [31:0] Ext16to32_Dout,
    output [31:0] Ext26to32_Dout,
    output DMWE_Dout,
    output PCAddSrc_Dout,
    output RFWE_Dout,
    output [1:0] RFDinSrc_Dout,
    output [6:0] BrIns_Dout,
    output [4:0] WReg_Dout
    );

    pipeline_register #(9) BHTItem(.din(BHTItem_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(BHTItem_Dout));
    pipeline_register #(32) CP01(.din(CP01_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(CP01_Dout));
    pipeline_register #(32) CP00(.din(CP00_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(CP00_Dout));
    pipeline_register #(7) INTCtl(.din(INTCtl_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(INTCtl_Dout));
    pipeline_register #(1) Load(.din(Load_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(Load_Dout));
    pipeline_register #(2) RDTR1Src(.din(RDTR1Src_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(RDTR1Src_Dout));
    pipeline_register #(2) RDTR2Src(.din(RDTR2Src_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(RDTR2Src_Dout));
    pipeline_register #(32) a0(.din(a0_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(a0_Dout));
    pipeline_register #(32) v0(.din(v0_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(v0_Dout));
    pipeline_register #(1) Syscall(.din(Syscall_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(Syscall_Dout));
    pipeline_register #(32) PC_PLUS_1(.din(PC_PLUS_1_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(PC_PLUS_1_Dout));
    pipeline_register #(32) PC(.din(PC_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(PC_Dout));
    pipeline_register #(32) IR(.din(IR_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(IR_Dout));
    pipeline_register #(4) ALUOP(.din(ALUOP_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(ALUOP_Dout));
    pipeline_register #(2) ALUYSrc(.din(ALUYSrc_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(ALUYSrc_Dout));
    pipeline_register #(1) ALUYSrc2(.din(ALUYSrc2_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(ALUYSrc2_Dout));
    pipeline_register #(32) RFD1(.din(RFD1_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(RFD1_Dout));
    pipeline_register #(32) RFD2(.din(RFD2_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(RFD2_Dout));
    pipeline_register #(32) Ext5to32(.din(Ext5to32_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(Ext5to32_Dout));
    pipeline_register #(32) SExt16to32(.din(SExt16to32_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(SExt16to32_Dout));
    pipeline_register #(32) Ext16to32(.din(Ext16to32_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(Ext16to32_Dout));
    pipeline_register #(32) Ext26to32(.din(Ext26to32_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(Ext26to32_Dout));
    pipeline_register #(1) DMWE(.din(DMWE_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(DMWE_Dout));
    pipeline_register #(1) PCAddSrc(.din(PCAddSrc_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(PCAddSrc_Dout));
    pipeline_register #(1) RFWE(.din(RFWE_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(RFWE_Dout));
    pipeline_register #(2) RFDinSrc(.din(RFDinSrc_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(RFDinSrc_Dout));
    pipeline_register #(7) BrIns(.din(BrIns_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(BrIns_Dout));
    pipeline_register #(5) WReg(.din(WReg_Din), .we(WE), .rst(Rst), .asyn_rst(Asyn_Rst), .clk(Clk), .dout(WReg_Dout));

endmodule
