`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2016/08/30 07:59:40
// Design Name:
// Module Name: generator
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
    This moudle is used to divide the signal of 100MHz to get 1Hz signal and
    counter for dynamic scan.
Parameter Introduction
input:
    fq100m: the signal of 100MHz which the board provides through "E3" port
output:
    fq1: the signal of 1Hz
    ds_count: the counter used for dynamic scan
*********************************************************************************/

module generator(
    input fq100m,
    output reg fq100,
    output reg [3:0] ds_count
    );

    reg [32:0] count;

    always @ (posedge fq100m)
    begin
        count = count + 1'b1;
        if (count == 500000)  // 100M / 2 = 50000000
        begin
            count = 0;
            fq100 = ~fq100;         // Get 1Hz
        end
        if (count % 10000 == 0)
        begin                   // Get dynamic scan counter
            ds_count = ds_count + 1;
        end
        if (ds_count == 8)
        begin
            ds_count = 0;
        end
    end

    initial
    begin
        count = 0;
        ds_count = 0;
    end

endmodule
