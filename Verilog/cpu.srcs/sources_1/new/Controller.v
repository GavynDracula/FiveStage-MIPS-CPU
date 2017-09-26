`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/02/27 08:31:55
// Design Name:
// Module Name: Controller
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


module Controller(
    input [5:0] op,
    input [5:0] funct,
    input [31:0] v0,
    input equal,
    input judge,
    output [1:0] PCSrc,
    output PCAddSrc,
    output PCEn,
    output RFR1Src,
    output [1:0] RFRWSrc,
    output [1:0] RFDinSrc,
    output RFWE,
    output [1:0] ALUYSrc,
    output ALUYSrc2,
    output [3:0] ALUOP,
    output DMWE,
    output Halt,
    output Disp
    );
    wire ins_ori, ins_andi, ins_slti, ins_addiu, ins_addi, ins_bne, ins_beq, ins_jal, ins_j, ins_bgez, ins_lh, ins_lw, ins_sw;
    wire ins_syscall, ins_jr, ins_srlv, ins_sllv, ins_sra, ins_srl, ins_sll, ins_add, ins_addu, ins_sub, ins_and, ins_or, ins_nor, ins_slt, ins_sltu;

    assign ins_ori = (op == 6'hd) ? 1 : 0;
    assign ins_andi = (op == 6'hc) ? 1 : 0;
    assign ins_slti = (op == 6'ha) ? 1 : 0;
    assign ins_addiu = (op == 6'h9) ? 1 : 0;
    assign ins_addi = (op == 6'h8) ? 1 : 0;
    assign ins_bne = (op == 6'h5) ? 1 : 0;
    assign ins_beq = (op == 6'h4) ? 1 : 0;
    assign ins_jal = (op == 6'h3) ? 1 : 0;
    assign ins_j = (op == 6'h2) ? 1 : 0;
    assign ins_bgez = (op == 6'h1) ? 1 : 0;
    assign ins_lh = (op == 6'h21) ? 1 : 0;
    assign ins_lw = (op == 6'h23) ? 1 : 0;
    assign ins_sw = (op == 6'h2b) ? 1 : 0;

    assign ins_syscall = (op == 6'h0 && funct == 6'hc) ? 1 : 0;
    assign ins_jr = (op == 6'h0 && funct == 6'h8) ? 1 : 0;
    assign ins_srlv = (op == 6'h0 && funct == 6'h6) ? 1 : 0;
    assign ins_sllv = (op == 6'h0 && funct == 6'h4) ? 1 : 0;
    assign ins_sra = (op == 6'h0 && funct == 6'h3) ? 1 : 0;
    assign ins_srl = (op == 6'h0 && funct == 6'h2) ? 1 : 0;
    assign ins_sll = (op == 6'h0 && funct == 6'h0) ? 1 : 0;
    assign ins_add = (op == 6'h0 && funct == 6'h20) ? 1 : 0;
    assign ins_addu = (op == 6'h0 && funct == 6'h21) ? 1 : 0;
    assign ins_sub = (op == 6'h0 && funct == 6'h22) ? 1 : 0;
    assign ins_and = (op == 6'h0 && funct == 6'h24) ? 1 : 0;
    assign ins_or = (op == 6'h0 && funct == 6'h25) ? 1 : 0;
    assign ins_nor = (op == 6'h0 && funct == 6'h27) ? 1 : 0;
    assign ins_slt = (op == 6'h0 && funct == 6'h2a) ? 1 : 0;
    assign ins_sltu = (op == 6'h0 && funct == 6'h2b) ? 1 : 0;

    assign PCSrc = {(equal & ins_beq) | (~equal & ins_bne) | ins_j | ins_jal | (ins_bgez & ~judge), ~((ins_bgez & ~judge) | (equal & ins_beq) | (~equal & ins_bne) | ins_jr)};
    assign PCAddSrc = ins_beq | ins_bne | ins_bgez;
    assign PCEn = 1;
    assign RFR1Src = ins_sll | ins_sra | ins_srl | ins_sllv | ins_srlv;
    assign RFRWSrc = {ins_jal, ins_add | ins_addu | ins_and | ins_sll | ins_sra | ins_srl | ins_sub | ins_or | ins_nor | ins_slt | ins_sltu | ins_sllv | ins_srlv};
    assign RFDinSrc = {~(ins_lw | ins_jal), (ins_lw | ins_lh)};
    assign RFWE = ~(ins_sw | ins_beq | ins_bne | ins_j | ins_jr | ins_syscall | ins_bgez);
    assign ALUYSrc = {ins_addi | ins_addiu | ins_andi | ins_ori | ins_lw | ins_sw | ins_slti | ins_lh, ins_andi | ins_sll | ins_sra | ins_srl | ins_ori};
    assign ALUYSrc2 = ins_bgez;
    assign ALUOP[3] = ins_or | ins_ori | ins_nor | ins_slt | ins_slti | ins_sltu | ins_bgez;
    assign ALUOP[2] = ins_add | ins_addi | ins_addiu | ins_addu | ins_and | ins_andi | ins_sub | ins_lw | ins_sw | ins_beq | ins_bne | ins_sltu | ins_lh;
    assign ALUOP[1] = ins_and | ins_andi | ins_srl | ins_sub | ins_nor | ins_beq | ins_bne | ins_slt | ins_slti | ins_srlv | ins_bgez;
    assign ALUOP[0] = ins_add | ins_addi | ins_addiu | ins_addu | ins_and | ins_andi | ins_sra | ins_lw | ins_sw | ins_slt | ins_slti | ins_lh | ins_bgez;
    assign DMWE = ins_sw;
    assign Halt = ins_syscall & (v0 == 32'ha);
    assign Disp = ins_syscall & (v0 != 32'ha);
endmodule
