`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/28 02:51:28
// Design Name:
// Module Name: counter
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


module counter (
        input clk,
        input rst,
        output reg [31:0] count
    );

    always @ (posedge clk or posedge rst)
    begin
        if (rst == 1)
            count <= 0;
        else
            count <= count + 1;
    end

endmodule
