`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/07 12:50:26
// Design Name:
// Module Name: pipeline_bht
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


module pipeline_bht(
    input clk,
    input rst,
    input [2:0] write_address,
    input write_valid,
    input [31:0] write_pc,
    input [31:0] write_branch,
    input [1:0] write_predict,
    input we_valid,
    input we_pc,
    input we_branch,
    input we_predict,
    input we_lru,
    input [31:0] cur_pc,

    output Hit,
    output [2:0] HitNum,
    output [31:0] BranchAddr,
    output [2:0] InsertNum,
    output [1:0] Predict
    );

    reg valids [0:7];
    reg [31:0] pcs [0:7];
    reg [31:0] branchs [0:7];
    reg [1:0] predicts [0:7];
    reg [13:0] lrus [0:7];

    wire [12:0] lru01, lru23, lru45, lru67, lru0123, lru4567;
    wire [2:0] InsertNumTemp1, InsertNumTemp2;

    integer i;

    initial
    begin
        for (i = 0; i < 8; i = i + 1)
        begin
            valids[i] = 1'h0;
            pcs[i] = 32'h0;
            branchs[i] = 32'h0;
            predicts[i] = 2'h0;
            lrus[i] = 13'h0;
        end
    end

    always @ (posedge clk)
    begin
        if (rst)
        begin
            for (i = 0; i < 8; i = i + 1)
            begin
                valids[i] = 1'h0;
                pcs[i] = 32'h0;
                branchs[i] = 32'h0;
                predicts[i] = 2'h0;
                lrus[i] = 13'h0;
            end
        end
        else
        begin
            lrus[0] <= lrus[0] + 1;
            lrus[1] <= lrus[1] + 1;
            lrus[2] <= lrus[2] + 1;
            lrus[3] <= lrus[3] + 1;
            lrus[4] <= lrus[4] + 1;
            lrus[5] <= lrus[5] + 1;
            lrus[6] <= lrus[6] + 1;
            lrus[7] <= lrus[7] + 1;
            if (we_valid)
            begin
                valids[write_address] <= write_valid;
            end
            if (we_pc)
            begin
                pcs[write_address] <= write_pc;
            end
            if (we_branch)
            begin
                branchs[write_address] <= write_branch;
            end
            if (we_predict)
            begin
                predicts[write_address] <= write_predict;
            end
            if (we_lru)
            begin
                lrus[write_address] <= 13'h0;
            end
        end
    end

    priencoder8to3 Pri (.in0((pcs[0] == cur_pc) & valids[0]), .in1((pcs[1] == cur_pc) & valids[1]),
                        .in2((pcs[2] == cur_pc) & valids[2]), .in3((pcs[3] == cur_pc) & valids[3]),
                        .in4((pcs[4] == cur_pc) & valids[4]), .in5((pcs[5] == cur_pc) & valids[5]),
                        .in6((pcs[6] == cur_pc) & valids[6]), .in7((pcs[7] == cur_pc) & valids[7]),
                        .grpsel(Hit), .res(HitNum));

    assign Predict = (HitNum == 3'h0) ? predicts[0] : 2'hz,
           Predict = (HitNum == 3'h1) ? predicts[1] : 2'hz,
           Predict = (HitNum == 3'h2) ? predicts[2] : 2'hz,
           Predict = (HitNum == 3'h3) ? predicts[3] : 2'hz,
           Predict = (HitNum == 3'h4) ? predicts[4] : 2'hz,
           Predict = (HitNum == 3'h5) ? predicts[5] : 2'hz,
           Predict = (HitNum == 3'h6) ? predicts[6] : 2'hz,
           Predict = (HitNum == 3'h7) ? predicts[7] : 2'hz;

    assign BranchAddr = (HitNum == 3'h0) ? branchs[0] : 32'hz,
           BranchAddr = (HitNum == 3'h1) ? branchs[1] : 32'hz,
           BranchAddr = (HitNum == 3'h2) ? branchs[2] : 32'hz,
           BranchAddr = (HitNum == 3'h3) ? branchs[3] : 32'hz,
           BranchAddr = (HitNum == 3'h4) ? branchs[4] : 32'hz,
           BranchAddr = (HitNum == 3'h5) ? branchs[5] : 32'hz,
           BranchAddr = (HitNum == 3'h6) ? branchs[6] : 32'hz,
           BranchAddr = (HitNum == 3'h7) ? branchs[7] : 32'hz;

    assign lru01 = (lrus[0] < lrus[1]) ? lrus[1] : lrus[0];
    assign lru23 = (lrus[2] < lrus[3]) ? lrus[3] : lrus[2];
    assign lru45 = (lrus[4] < lrus[5]) ? lrus[5] : lrus[4];
    assign lru67 = (lrus[6] < lrus[7]) ? lrus[7] : lrus[6];
    assign lru0123 = (lru01 < lru23) ? lru23 : lru01;
    assign lru4567 = (lru45 < lru67) ? lru67 : lru45;

    assign InsertNum[2] = (lru0123 < lru4567);
    assign InsertNum[1] = InsertNum[2] ? (lru45 < lru67) : (lru01 < lru23);
    assign InsertNumTemp1 = (lru45 < lru67) ? (lrus[6] < lrus[7]) : (lrus[4] < lrus[5]);
    assign InsertNumTemp2 = (lru01 < lru23) ? (lrus[2] < lrus[3]) : (lrus[0] < lrus[1]);
    assign InsertNum[0] = InsertNum[2] ? InsertNumTemp1 : InsertNumTemp2;

endmodule
