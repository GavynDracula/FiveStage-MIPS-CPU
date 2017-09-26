`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/03/06 01:58:20
// Design Name: 
// Module Name: priencoder_tb
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


module priencoder_tb(
    );
    reg in0;
    reg in1;
    reg in2;
    reg in3;
    wire grpsel;
    wire enout;
    wire [1:0] res;
    
    priencoder DUT (in0, in1, in2, in3, grpsel, enout, res);
    
    initial
    begin
        in0 = 0;
        in1 = 0;
        in2 = 0;
        in3 = 0;
        #5 in0 = 1;
        #5 in1 = 1;
        #5 in2 = 1;
        #5 in3 = 1;
        #5 in2 = 0;
        #5 in3 = 0;
    end
endmodule
