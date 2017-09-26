`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/03 00:41:30
// Design Name:
// Module Name: pipeline_register
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


module pipeline_register
    #(parameter WIDTH = 32)
    (
    input [WIDTH-1:0] din,
    input we,
    input rst,
    input clk,
    input asyn_rst,
    output reg [WIDTH-1:0] dout
    );
    always @ (posedge clk or posedge asyn_rst)
    begin
        if (asyn_rst | rst)
        begin
            dout <= 0;
        end
        else if (we)
        begin
            dout <= din;
        end
    end
endmodule
