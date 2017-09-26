`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/06 00:52:25
// Design Name:
// Module Name: pipeline_intr
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


module pipeline_intr(
    input Clk,
    input Rst,
    input IEW_Init,
    input INMW,
    input [3:0] IRSrc,
    input [31:0] IR,
    input [31:0] PC,
    input [31:0] RegIn,
    output INT,
    output Res,
    output [3:0] IRWT,
    output [31:0] IRNum,
    output [31:0] RegOut
    );

    wire IR0Clr, IR1Clr, IR2Clr, IR3Clr;
    wire Cache1IR0, Cache1IR1, Cache1IR2, Cache1IR3, Cache2IR0, Cache2IR1, Cache2IR2, Cache2IR3;
    wire IEW, IR0, IR1, IR2, IR3, IRWT3, IRWT2, IRWT1, IRWT0;
    wire INM3, INM2, INM1, INM0, IE, INM3Out, INM2Out, INM1Out, INM0Out, IEOut;
    wire grpsel, enout;
    wire [1:0] IRNumber;
    wire [3:0] ClrTemp;

    assign IEW = (INT & Res) | IEW_Init;
    assign {IR3, IR2, IR1, IR0} = IRSrc;
    assign IRWT = {IRWT3, IRWT2, IRWT1, IRWT0};
    assign Res = ~(IR == 32'h0 & PC == 32'h0);
    assign IRNum = {{30{1'h0}}, IRNumber};
    assign {INM3, INM2, INM1, INM0, IE} = ((Res & INT) == 1'h0) ? RegIn[4:0] : 5'hz,
           {INM3, INM2, INM1, INM0, IE} = ((Res & INT) == 1'h1) ? 5'h1e : 5'hz;
    assign RegOut = {{27{1'h0}}, INM3Out, INM2Out, INM1Out, INM0Out, IEOut};

    pipeline_register #(1) IR0Cache1 (.din(1'h1), .we(~IR0Clr), .rst(IR0Clr), .asyn_rst(Rst | IR0Clr), .clk(IR0), .dout(Cache1IR0));
    //DLatch IR0Cache1 (.clk(IR0), .din(1'h1), .rst(CacheIR0Clr | Rst), .q(Cache1IR0));
    //DLatch IR0ClrCache (.clk(Clk), .din(IR0Clr), .rst(Rst), .q(CacheIR0Clr));
    assign IRWT0 = Cache1IR0 | IR0Clr;
    register #(1) IR0Cache2 (.din(Cache1IR0 & ~Rst), .we(1'h1), .rst(Rst), .clk(Clk), .dout(Cache2IR0));
    register #(1) INM0Reg (.din(INM0), .we(INMW), .rst(Rst), .clk(Clk), .dout(INM0Out));

    pipeline_register #(1) IR1Cache1 (.din(1'h1), .we(~IR1Clr), .rst(IR1Clr), .asyn_rst(Rst | IR1Clr), .clk(IR1), .dout(Cache1IR1));
    //DLatch IR1Cache1 (.clk(IR1), .din(1'h1), .rst(IR1Clr | Rst), .q(Cache1IR1));
    assign IRWT1 = Cache1IR1 | IR1Clr;
    register #(1) IR1Cache2 (.din(Cache1IR1 & ~Rst), .we(1'h1), .rst(Rst), .clk(Clk), .dout(Cache2IR1));
    register #(1) INM1Reg (.din(INM1), .we(INMW), .rst(Rst), .clk(Clk), .dout(INM1Out));

    pipeline_register #(1) IR2Cache1 (.din(1'h1), .we(~IR2Clr), .rst(IR2Clr), .asyn_rst(Rst | IR2Clr), .clk(IR2), .dout(Cache1IR2));
    //DLatch IR2Cache1 (.clk(IR2), .din(1'h1), .rst(IR2Clr | Rst), .q(Cache1IR2));
    assign IRWT2 = Cache1IR2 | IR2Clr;
    register #(1) IR2Cache2 (.din(Cache1IR2 & ~Rst), .we(1'h1), .rst(Rst), .clk(Clk), .dout(Cache2IR2));
    register #(1) INM2Reg (.din(INM2), .we(INMW), .rst(Rst), .clk(Clk), .dout(INM2Out));

    pipeline_register #(1) IR3Cache1 (.din(1'h1), .we(~IR3Clr), .rst(IR3Clr), .asyn_rst(Rst | IR3Clr), .clk(IR3), .dout(Cache1IR3));
    //DLatch IR3Cache1 (.clk(IR3), .din(1'h1), .rst(IR3Clr | Rst), .q(Cache1IR3));
    assign IRWT3 = Cache1IR3 | IR3Clr;
    register #(1) IR3Cache2 (.din(Cache1IR3 & ~Rst), .we(1'h1), .rst(Rst), .clk(Clk), .dout(Cache2IR3));
    register #(1) INM3Reg (.din(INM3), .we(INMW), .rst(Rst), .clk(Clk), .dout(INM3Out));

    register #(1) IEReg (.din(IE), .we(IEW), .rst(Rst), .clk(Clk), .dout(IEOut));

    priencoder Pri (.in0(Cache2IR0 & ~INM0Out), .in1(Cache2IR1 & ~INM1Out), .in2(Cache2IR2 & ~INM2Out), .in3(Cache2IR3 & ~INM3Out), .grpsel(grpsel), .enout(enout), .res(IRNumber));
    assign INT = grpsel & IEOut;

    assign ClrTemp = (IRNumber == 2'h0) ? 4'h8 : 4'hz,
           ClrTemp = (IRNumber == 2'h1) ? 4'h4 : 4'hz,
           ClrTemp = (IRNumber == 2'h2) ? 4'h2 : 4'hz,
           ClrTemp = (IRNumber == 2'h3) ? 4'h1 : 4'hz;
    assign {IR0Clr, IR1Clr, IR2Clr, IR3Clr} = ((~enout & IEOut & Res) == 1'h1) ? ClrTemp : 4'hz,
           {IR0Clr, IR1Clr, IR2Clr, IR3Clr} = ((~enout & IEOut & Res) == 1'h0) ? 4'h0 : 4'hz;
endmodule
