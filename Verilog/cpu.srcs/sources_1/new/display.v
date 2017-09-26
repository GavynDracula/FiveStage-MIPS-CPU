`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/08/30 08:27:24
// Design Name: 
// Module Name: display
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

/*********************************************************************************
    This moudle is used to display the clock.
Parameter Introduction
input:
    ds_count: dynamic scan signal(0~5)
    second_unit: the unit number of second(0~9£©
    second_digit: the digit number of second(0~5)
    minute_unit: the unit number of minute(0~9£©
    minute_digit: the digit number of minute(0~5)
    hour_unit: the unit number of hour(0~9£©
    hour_digit: the digit number of hour(0~5)
output:    
    seg: 7 segment of the digital tube
    an: control signal of the 8-digital-tube
*********************************************************************************/

module display(
    input [3:0] ds_count,
    input [31:0] data,
    output reg [6:0] seg,
    output reg [7:0] an
    );

    wire [6:0] digital_tube7_seg, digital_tube6_seg, digital_tube5_seg, digital_tube4_seg, digital_tube3_seg, digital_tube2_seg, digital_tube1_seg, digital_tube0_seg;

    hex_to_7segment digital_tube7 (data[31:28], digital_tube7_seg);
    hex_to_7segment digital_tube6 (data[27:24], digital_tube6_seg);
    hex_to_7segment digital_tube5 (data[23:20], digital_tube5_seg);
    hex_to_7segment digital_tube4 (data[19:16], digital_tube4_seg);
    hex_to_7segment digital_tube3 (data[15:12], digital_tube3_seg);
    hex_to_7segment digital_tube2 (data[11:8], digital_tube2_seg);
    hex_to_7segment digital_tube1 (data[7:4], digital_tube1_seg);
    hex_to_7segment digital_tube0 (data[3:0], digital_tube0_seg);

    always @ (ds_count)
    begin
        case (ds_count)
        4'h0: seg = digital_tube0_seg;
        4'h1: seg = digital_tube1_seg;
        4'h2: seg = digital_tube2_seg;
        4'h3: seg = digital_tube3_seg;
        4'h4: seg = digital_tube4_seg;
        4'h5: seg = digital_tube5_seg;
        4'h6: seg = digital_tube6_seg;
        4'h7: seg = digital_tube7_seg;
        endcase;
    end
    
    always @ (ds_count)
    begin
        case (ds_count)
        4'h0: an = 8'b11111110;
        4'h1: an = 8'b11111101;
        4'h2: an = 8'b11111011;
        4'h3: an = 8'b11110111;
        4'h4: an = 8'b11101111;
        4'h5: an = 8'b11011111;
        4'h6: an = 8'b10111111;
        4'h7: an = 8'b01111111;
        endcase;
    end

endmodule
