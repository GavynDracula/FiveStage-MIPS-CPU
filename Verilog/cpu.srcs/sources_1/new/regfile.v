`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/26 15:44:01
// Design Name:
// Module Name: regfile
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


module regfile(
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input we,
    input rst,
    input clk,
    output [31:0] reg1,
    output [31:0] reg2,
    output [31:0] a0,
    output [31:0] v0
    );


    reg [31:0] regs [0:31];
    integer i;

    initial
    begin
        for (i = 0; i < 32; i = i + 1)
        begin
            regs[i] = 0;
        end
    end

    assign reg1 = regs[read_reg1];
    assign reg2 = regs[read_reg2];
    assign v0 = regs[2];
    assign a0 = regs[4];

    always @ (posedge clk or posedge rst)
    begin
        if (rst)
        begin
            for (i = 0; i < 32; i = i + 1)
            begin
                regs[i] = 0;
            end
        end
        else if (we && write_reg != 0)
        begin
            regs[write_reg] <= write_data;
        end
    end
endmodule
