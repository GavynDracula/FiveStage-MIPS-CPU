`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/03/06 08:54:45
// Design Name: 
// Module Name: pipeline_intr_tb
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


module pipeline_intr_tb(
    );
    reg Clk;
    reg Rst;
    reg IEW_Init;
    reg INMW;
    reg [3:0] IRSrc;
    reg [31:0] IR;
    reg [31:0] PC;
    reg [31:0] RegIn;
    wire INT;
    wire Res;
    wire [3:0] IRWT;
    wire [31:0] IRNum;
    wire [31:0] RegOut;
    
    integer k;
    
    pipeline_intr DUT (Clk, Rst, IEW_Init, INMW, IRSrc, IR, PC, RegIn, INT, Res, IRWT, IRNum, RegOut);
    
    initial
    begin
        Clk = 0;
        for (k = 0; k < 100000; k = k + 1)
        begin
            #5 Clk = 1;
            #5 Clk = 0;
        end  
    end
    
    initial
    begin
        Rst = 1;
        #3 Rst = 0;
    end
    
    initial
    begin
        IEW_Init = 0;
        INMW = 0;
        RegIn = 32'h1;
        PC = 32'h1;
        IR = 32'h0;
        #10 IEW_Init = 1;
        #10 IEW_Init = 0;
        RegIn = 32'h0;
        #150 IEW_Init = 1;
        RegIn = 32'h1;
        #10 IEW_Init = 0;
    end
    
    initial
    begin
        IRSrc = 0;
        #100 IRSrc[0] = 1;
        #10 IRSrc[0] = 0;
        #90 IRSrc[3] = 1;
        #10 IRSrc[3] = 0;
    end
endmodule
