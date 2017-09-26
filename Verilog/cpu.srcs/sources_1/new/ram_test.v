`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/28 04:27:26
// Design Name:
// Module Name: ram_test
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


module ram_test(
    input [9:0] addr,
    input [31:0] din,
    input we,
    input rst,
    input clk,
    output [31:0] dout,
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
    output [31:0] mem15
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

    assign mem0 = mem[8'h0];
    assign mem1 = mem[8'h4];
    assign mem2 = mem[8'h8];
    assign mem3 = mem[8'hc];
    assign mem4 = mem[8'h10];
    assign mem5 = mem[8'h14];
    assign mem6 = mem[8'h18];
    assign mem7 = mem[8'h1c];
    assign mem8 = mem[8'h20];
    assign mem9 = mem[8'h24];
    assign mem10 = mem[8'h28];
    assign mem11 = mem[8'h2c];
    assign mem12 = mem[8'h30];
    assign mem13 = mem[8'h34];
    assign mem14 = mem[8'h38];
    assign mem15 = mem[8'h3c];

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
