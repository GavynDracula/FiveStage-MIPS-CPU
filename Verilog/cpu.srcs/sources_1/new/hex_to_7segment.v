`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/27 14:37:34
// Design Name: 
// Module Name: hex_to_7segment
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


module hex_to_7segment(
    input [3:0] hex_in,
    output reg [6:0] seg_out
    );
    always @(hex_in)
    begin
        case(hex_in)
            4'b0000: seg_out = 7'b0000001;          //display '0'
            4'b0001: seg_out = 7'b1001111;          //display '1'
            4'b0010: seg_out = 7'b0010010;          //display '2'
            4'b0011: seg_out = 7'b0000110;          //display '3'
            4'b0100: seg_out = 7'b1001100;          //display '4'
            4'b0101: seg_out = 7'b0100100;          //display '5'
            4'b0110: seg_out = 7'b0100000;          //display '6'
            4'b0111: seg_out = 7'b0001111;          //display '7'
            4'b1000: seg_out = 7'b0000000;          //display '8'
            4'b1001: seg_out = 7'b0000100;          //display '9'
            4'b1010: seg_out = 7'b0001000;          //display 'A'
            4'b1011: seg_out = 7'b1100000;          //display 'b'
            4'b1100: seg_out = 7'b0110001;          //display 'C'
            4'b1101: seg_out = 7'b1000010;          //display 'd'
            4'b1110: seg_out = 7'b0110000;          //display 'E'
            4'b1111: seg_out = 7'b0111000;          //display 'F'
        endcase
    end
endmodule
