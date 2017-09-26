`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/27 08:18:17
// Design Name:
// Module Name: cpu
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


module cpu(
    input ComClk, Rst,

    output [31:0] mem0,
    output [31:0] mem1,
    output [31:0] mem2,
    output [31:0] mem3,
    output [31:0] mem4,
    output [31:0] mem5,
    output [31:0] mem6,
    output [31:0] mem7,
    output [31:0] mem8,
    output [31:0] mem9,
    output [31:0] mem10,
    output [31:0] mem11,
    output [31:0] mem12,
    output [31:0] mem13,
    output [31:0] mem14,
    output [31:0] mem15,

    output [31:0] Digital_Tube,
    output [31:0] ClkCount
    );

    wire Clk, PCEn, Halt, Disp, Equal, Judge, PCAddSrc, RFR1Src, RFWE, ALUYSrc2, DMWE;
    wire [31:0] PCDin, PCAdd, PC, Ins, V0Value, A0Value, ALUY, ALUY_Temp, ALUResult, RFDin, RFD1, RFD2, DMDout;
    wire [5:0] OP, Funct;
    wire [4:0] Rs, Rt, Rd, Shamt, RFR1, RFR2, RFRW;
    wire [15:0] IMM16;
    wire [25:0] IMM26;
    wire [1:0] PCSrc, RFRWSrc, RFDinSrc, ALUYSrc;
    wire [3:0] ALUOP;

    assign Clk = ~Halt & ComClk;

    assign PCAdd = (PCAddSrc == 1'h0) ? PC + 32'h1 : 32'hz,
           PCAdd = (PCAddSrc == 1'h1) ? PC + 32'h1 + {{16{IMM16[15]}}, IMM16} : 32'hz;

    assign PCDin = (PCSrc == 2'h0) ? RFD1 : 32'hz,
           PCDin = (PCSrc == 2'h1) ? PC + 32'h1 : 32'hz,
           PCDin = (PCSrc == 2'h2) ? PCAdd : 32'hz,
           PCDin = (PCSrc == 2'h3) ? {{6{1'h0}}, IMM26} : 32'hz;
    register REG_PC(.din(PCDin), .we(PCEn), .rst(Rst), .clk(Clk), .dout(PC));

    register REG_Disp(.din(A0Value), .we(1'h1), .rst(Rst), .clk(Disp), .dout(Digital_Tube));

    rom ROM_Ins(.addr(PC[9:0]), .dout(Ins));

    InsAnalyse IA(.ins(Ins), .op(OP), .rs(Rs), .rt(Rt), .rd(Rd), .shamt(Shamt), .funct(Funct), .immediate16(IMM16), .immediate26(IMM26));

    assign RFR1 = (RFR1Src == 1'h0) ? Rs : 32'hz,
           RFR1 = (RFR1Src == 1'h1) ? Rt : 32'hz;
    assign RFR2 = (RFR1Src == 1'h1) ? Rs : 32'hz,
           RFR2 = (RFR1Src == 1'h0) ? Rt : 32'hz;
    assign RFRW = (RFRWSrc == 2'h0) ? Rt : 32'hz,
           RFRW = (RFRWSrc == 2'h1) ? Rd : 32'hz,
           RFRW = (RFRWSrc == 2'h2) ? 32'h1f : 32'hz,
           RFRW = (RFRWSrc == 2'h3) ? 32'h0 : 32'hz;
    assign RFDin = (RFDinSrc == 2'h0) ? PCAdd : 32'hz,
           RFDin = (RFDinSrc == 2'h1) ? DMDout : 32'hz,
           RFDin = (RFDinSrc == 2'h2) ? ALUResult : 32'hz,
           RFDin = (RFDinSrc == 2'h3) ? {{16{DMDout[15]}}, DMDout[15:0]} : 32'hz;
    regfile RF(.read_reg1(RFR1), .read_reg2(RFR2), .write_reg(RFRW), .write_data(RFDin),
               .we(RFWE), .rst(Rst), .clk(Clk), .reg1(RFD1), .reg2(RFD2), .a0(A0Value), .v0(V0Value));

    Controller CTL(.op(OP), .funct(Funct), .v0(V0Value), .equal(Equal), .judge(Judge), .PCSrc(PCSrc),
                   .PCAddSrc(PCAddSrc), .PCEn(PCEn), .RFR1Src(RFR1Src), .RFRWSrc(RFRWSrc), .RFDinSrc(RFDinSrc),
                   .RFWE(RFWE), .ALUYSrc(ALUYSrc), .ALUYSrc2(ALUYSrc2), .ALUOP(ALUOP), .DMWE(DMWE), .Halt(Halt), .Disp(Disp));

    assign ALUY_Temp = (ALUYSrc == 2'h0) ? RFD2 : 32'hz,
           ALUY_Temp = (ALUYSrc == 2'h1) ? {{27{1'h0}}, Shamt} : 32'hz,
           ALUY_Temp = (ALUYSrc == 2'h2) ? {{16{IMM16[15]}}, IMM16} : 32'hz,
           ALUY_Temp = (ALUYSrc == 2'h3) ? {{16{1'h0}}, IMM16} : 32'hz;
    assign ALUY = (ALUYSrc2 == 1'h0) ? ALUY_Temp : 32'hz,
           ALUY = (ALUYSrc2 == 1'h1) ? 32'h0 : 32'hz;
    alu ALU(.x(RFD1), .y(ALUY), .op(ALUOP), .result(ALUResult), .equal(Equal));
    assign Judge = ALUResult[0];

    //ram DM(.addr(ALUResult[9:0]), .din(RFD2), .we(DMWE), .rst(Rst), .clk(Clk), .dout(DMDout));
    ram_test DM(.addr(ALUResult[9:0]), .din(RFD2), .we(DMWE), .rst(Rst), .clk(Clk), .dout(DMDout), .mem0(mem0), .mem1(mem1), .mem2(mem2), .mem3(mem3), .mem4(mem4), .mem5(mem5), .mem6(mem6), .mem7(mem7), .mem8(mem8), .mem9(mem9), .mem10(mem10), .mem11(mem11), .mem12(mem12), .mem13(mem13), .mem14(mem14), .mem15(mem15));

    counter ClkCounter(.clk(Clk), .rst(Rst), .count(ClkCount));

    endmodule
