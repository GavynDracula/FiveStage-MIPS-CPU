`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/27 01:55:45
// Design Name:
// Module Name: ram
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


module ram(
    input [9:0] addr,
    input [31:0] din,
    input we,
    input rst,
    input clk,
    output [31:0] dout
    );
    reg [31:0] mem [0:1023];
    integer i;

    initial
    begin
        for (i = 0; i < 1024; i = i + 1)
        begin
            mem[i] <= 0;
        end
    end

    assign dout = mem[addr];

    always @ (posedge clk or posedge rst)
    begin
        if (rst)
        begin
            for (i = 0; i < 1024; i = i + 1)
            begin
                mem[i] <= 0;
            end
        end
        else if (we)
        begin
            mem[addr] <= din;
        end
    end
endmodule
