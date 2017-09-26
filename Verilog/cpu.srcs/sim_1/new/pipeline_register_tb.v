`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/03/03 14:42:25
// Design Name: 
// Module Name: pipeline_register_tb
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


module pipeline_register_tb(
    );
    reg [32-1:0] din;
    reg we;
    reg rst;
    reg clk;
    wire  [32-1:0] dout;
    
    
    pipeline_register DUT (din, we, rst, clk, dout);
    
    initial
    begin
        we = 1;
        rst = 1;
        #10 rst = 0;
    end
    
    initial
    begin
        clk = 0;
        #5 clk = 1;
        #5 clk = 0;
        #5 clk = 1;
    end
endmodule
