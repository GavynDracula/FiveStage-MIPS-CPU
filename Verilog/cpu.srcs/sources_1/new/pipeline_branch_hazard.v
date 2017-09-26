`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/03 01:03:16
// Design Name:
// Module Name: pipeline_branch_hazard
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


module pipeline_branch_hazard(
    input equal,
    input judge,
    input intr,
    input [6:0] BrIns,
    input PredictYes,
    input [8:0] BHTItem,
    output PCSrc,
    output PostClr,
    output [1:0] BrPCSrc2,
    output [1:0] BrPCSrc,
    output [10:0] ToBHT
    );

    wire ins_beq, ins_bne, ins_bgez, ins_j, ins_jal, ins_jr, ins_eret;
    wire NotHitButBr, HitAndYes, HitButWrong;
    wire Hit;
    wire [1:0] PredictIn, HitYesPredict, HitWrongPredict;
    wire [2:0] HitNum, InsertNum;

    assign {ins_beq, ins_bne, ins_bgez, ins_j, ins_jal, ins_jr, ins_eret} = BrIns;

    assign {InsertNum, HitNum, PredictIn, Hit} = BHTItem;

    assign HitButWrong = Hit & ~PredictYes;
    assign HitAndYes = Hit & PredictYes;

    assign ToBHT[10:8] = (Hit == 1'h0) ? InsertNum : 3'hz,
           ToBHT[10:8] = (Hit == 1'h1) ? HitNum : 3'hz;

    assign PostClr = intr;
    assign BrPCSrc2 = {intr, ins_eret};
    assign BrPCSrc = {(equal & ins_beq) | (~equal & ins_bne) | ins_j | ins_jal | (ins_bgez & ~judge), ~((ins_bgez & ~judge) | (equal & ins_beq) | (~equal & ins_bne) | ins_jr)};
    assign NotHitButBr = ((ins_beq & equal) | (ins_bne & ~equal) | (ins_bgez & ~judge) | ins_j | ins_jal | ins_jr | ins_eret | intr) & ~Hit;
    assign PCSrc = NotHitButBr | HitButWrong;

    assign ToBHT[7] = NotHitButBr;
    assign ToBHT[6] = NotHitButBr;
    assign ToBHT[3] = NotHitButBr | HitAndYes | HitButWrong;
    assign ToBHT[2] = NotHitButBr | HitAndYes;
    assign ToBHT[1] = NotHitButBr;
    assign ToBHT[0] = NotHitButBr;

    assign HitWrongPredict = (PredictIn == 2'h0) ? 2'h0 : 2'hz,
           HitWrongPredict = (PredictIn == 2'h1) ? 2'h0 : 2'hz,
           HitWrongPredict = (PredictIn == 2'h2) ? 2'h1 : 2'hz,
           HitWrongPredict = (PredictIn == 2'h3) ? 2'h2 : 2'hz;
    assign HitYesPredict = (PredictIn == 2'h0) ? 2'h1 : 2'hz,
           HitYesPredict = (PredictIn == 2'h1) ? 2'h2 : 2'hz,
           HitYesPredict = (PredictIn == 2'h2) ? 2'h3 : 2'hz,
           HitYesPredict = (PredictIn == 2'h3) ? 2'h3 : 2'hz;
    assign ToBHT[5:4] = (Hit == 1'h0) ? 2'h2 : 2'hz,
           ToBHT[5:4] = (Hit == 1'h1) ? (PredictYes ? HitYesPredict : HitWrongPredict) : 2'hz;
endmodule
