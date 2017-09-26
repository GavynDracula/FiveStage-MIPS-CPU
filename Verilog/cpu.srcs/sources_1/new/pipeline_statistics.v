`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/03 16:43:25
// Design Name:
// Module Name: pipeline_statistics
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


module pipeline_statistics(
    input Clk,
    input WE,
    input Rst,
    input LoadUseSel,
    input BranchSel,
    output [31:0] LoadUseCount,
    output [31:0] BranchCount
    );

    wire [31:0] LwUseSrc, BrchSrc;

    assign LwUseSrc = (LoadUseSel == 1'h0) ? LoadUseCount + 32'h1 : 32'hz,
           LwUseSrc = (LoadUseSel == 1'h1) ? LoadUseCount : 32'hz;
    assign BrchSrc = (BranchSel == 1'h0) ? BranchCount : 32'hz,
           BrchSrc = (BranchSel == 1'h1) ? BranchCount + 32'h1 : 32'hz;
    register LwUse (.din(LwUseSrc), .we(WE), .rst(Rst), .clk(Clk), .dout(LoadUseCount));
    register Brch (.din(BrchSrc), .we(WE), .rst(Rst), .clk(Clk), .dout(BranchCount));
endmodule
