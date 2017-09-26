`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/27 14:10:40
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb(
    );
    reg ComClk, Rst;
    wire [31:0] Digital_Tube;
    wire [31:0] ClkCount;
    integer i;  
    
    cpu DUT (.ComClk(ComClk), .Rst(Rst), .Digital_Tube(Digital_Tube), .ClkCount(ClkCount));
    
    initial
    begin
        ComClk = 0;
        for (i = 0; i < 10000; i = i + 1)
        begin
            #5 ComClk = 1;
            #5 ComClk = 0;
        end
    end
    
    initial
    begin
        Rst = 1;
        #10 Rst = 0;
    end
endmodule
