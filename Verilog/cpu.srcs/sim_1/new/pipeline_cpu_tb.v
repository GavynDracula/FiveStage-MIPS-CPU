`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/03/03 09:10:50
// Design Name: 
// Module Name: pipeline_cpu_tb
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


module pipeline_cpu_tb(
    );
    reg ComClk, Rst;
    reg [3:0] IRSrc;
    wire [31:0] DigitalTube, ClkCount, LoadUseCount, BranchCount;
    wire [3:0] IRWT;
    integer i;  
    
    pipeline_cpu DUT (.ComClk(ComClk), .Rst(Rst), .DigitalTube(DigitalTube), .ClkCount(ClkCount), .LoadUseCount(LoadUseCount), .BranchCount(BranchCount), .IRSrc(IRSrc), .IRWT(IRWT));
    
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
        IRSrc = 0;
        Rst = 1;
        #10 Rst = 0;
        #500 IRSrc[0] = 1;
        #10 IRSrc[0] = 0;
        #100 IRSrc[2] = 1;
        #10 IRSrc[2] = 0;
    end
endmodule
