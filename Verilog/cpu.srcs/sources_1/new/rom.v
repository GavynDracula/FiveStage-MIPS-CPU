`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/27 06:43:29
// Design Name: 
// Module Name: rom
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


module rom(
    input [9:0] addr,
    output [31:0] dout
    );
    
    reg [31:0] mem [0:1023];
    assign dout = mem[addr];
    
    initial
    begin
        $readmemh("D:/Documents/verilog/cpu/testfile/benchmark-ir-pipeline.hex", mem, 0, 517);
    end
endmodule
