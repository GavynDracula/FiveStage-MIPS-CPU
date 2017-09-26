`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/03 00:43:51
// Design Name:
// Module Name: pipeline_controller
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


module pipeline_controller(
    input [5:0] op,
    input [5:0] funct,
    input [4:0] Rs,
    input [4:0] Rd,
    output PCAddSrc,
    output RFR1Src,
    output [1:0] RFRWSrc,
    output [1:0] RFDinSrc,
    output RFWE,
    output [1:0] ALUYSrc,
    output ALUYSrc2,
    output [3:0] ALUOP,
    output DMWE,
    output Syscall,
    output Load,
    output [6:0] INTCtl,
    output [6:0] BrIns,
    output [31:0] AllIns
    );
    wire ins_ori, ins_andi, ins_slti, ins_addiu, ins_addi, ins_bne, ins_beq, ins_jal, ins_j, ins_bgez, ins_lh, ins_lw, ins_sw;
    wire ins_syscall, ins_jr, ins_srlv, ins_sllv, ins_sra, ins_srl, ins_sll, ins_add, ins_addu, ins_sub, ins_and, ins_or, ins_nor, ins_slt, ins_sltu;
    wire ins_eret, ins_mfc0, ins_mtc0, ins_mtc00, ins_mtc01;

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

    assign ins_eret = (op == 6'h10 && funct[4] == 1'h1) ? 1 : 0;
    assign ins_mfc0 = (op == 6'h10 && funct[4] == 1'h0 && Rs[2] == 1'h0) ? 1 : 0;
    assign ins_mtc0 = (op == 6'h10 && funct[4] == 1'h0 && Rs[2] == 1'h1) ? 1 : 0;
    assign ins_mtc00 = (op == 6'h10 && funct[4] == 1'h0 && Rs[2] == 1'h1 && Rd[0] == 0) ? 1 : 0;
    assign ins_mtc01 = (op == 6'h10 && funct[4] == 1'h0 && Rs[2] == 1'h1 && Rd[0] == 1) ? 1 : 0;

    assign INTCtl = {Rd[0], ins_mfc0, ins_mtc00 | ins_eret, ins_mtc00, ins_mtc00, ins_mtc01, ins_mtc01};

    assign BrIns = {ins_beq, ins_bne, ins_bgez, ins_j, ins_jal, ins_jr, ins_eret};
    assign Load = ins_lw | ins_lh;
    assign AllIns = {{4{1'h0}}, ins_ori, ins_andi, ins_slti, ins_addiu, ins_addi, ins_bne, ins_beq, ins_jal, ins_j, ins_bgez, ins_lh, ins_lw, ins_sw,
                                ins_syscall, ins_jr, ins_srlv, ins_sllv, ins_sra, ins_srl, ins_sll, ins_add, ins_addu, ins_sub, ins_and, ins_or, ins_nor, ins_slt, ins_sltu};
    assign PCAddSrc = ins_beq | ins_bne | ins_bgez;
    assign RFR1Src = ins_sll | ins_sra | ins_srl | ins_sllv | ins_srlv | ins_mtc0;
    assign RFRWSrc = {ins_jal, ins_add | ins_addu | ins_and | ins_sll | ins_sra | ins_srl | ins_sub | ins_or | ins_nor | ins_slt | ins_sltu | ins_sllv | ins_srlv};
    assign RFDinSrc = {~(ins_lw | ins_jal), (ins_lw | ins_lh)};
    assign RFWE = ~(ins_sw | ins_beq | ins_bne | ins_j | ins_jr | ins_syscall | ins_bgez | ins_mtc0 | ins_eret);
    assign ALUYSrc = {ins_addi | ins_addiu | ins_andi | ins_ori | ins_lw | ins_sw | ins_slti | ins_lh, ins_andi | ins_sll | ins_sra | ins_srl | ins_ori};
    assign ALUYSrc2 = ins_bgez | ins_mtc0;
    assign ALUOP[3] = ins_or | ins_ori | ins_nor | ins_slt | ins_slti | ins_sltu | ins_bgez;
    assign ALUOP[2] = ins_add | ins_addi | ins_addiu | ins_addu | ins_and | ins_andi | ins_sub | ins_lw | ins_sw | ins_beq | ins_bne | ins_sltu | ins_lh;
    assign ALUOP[1] = ins_and | ins_andi | ins_srl | ins_sub | ins_nor | ins_beq | ins_bne | ins_slt | ins_slti | ins_srlv | ins_bgez;
    assign ALUOP[0] = ins_add | ins_addi | ins_addiu | ins_addu | ins_and | ins_andi | ins_sra | ins_lw | ins_sw | ins_slt | ins_slti | ins_lh | ins_bgez;
    assign DMWE = ins_sw;
    assign Syscall = ins_syscall;
endmodule
