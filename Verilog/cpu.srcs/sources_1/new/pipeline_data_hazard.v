`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/03 01:11:54
// Design Name:
// Module Name: pipeline_data_hazard
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


module pipeline_data_hazard(
    input [4:0] EX_WReg_Init,
    input  [4:0] MEM_WReg_Init,
    input EX_WE,
    input MEM_WE,
    input Load,
    input [4:0] Rs_Init,
    input [4:0] Rt_Init,
    input [31:0] AllIns,
    output Nop,
    output Stop,
    output [1:0] RDTR1Src,
    output [1:0] RDTR2Src
    );

    wire [4:0] EX_WReg, MEM_WReg, Rs, Rt;
    wire RsZero, RtZero, EX_RsEqu, EX_RtEqu, MEM_RsEqu, MEM_RtEqu, EX_R1Equ, EX_R2Equ, MEM_R1Equ, MEM_R2Equ;
    wire ins_ori, ins_andi, ins_slti, ins_addiu, ins_addi, ins_bne, ins_beq, ins_jal, ins_j, ins_bgez, ins_lh, ins_lw, ins_sw;
    wire ins_syscall, ins_jr, ins_srlv, ins_sllv, ins_sra, ins_srl, ins_sll, ins_add, ins_addu, ins_sub, ins_and, ins_or, ins_nor, ins_slt, ins_sltu;

    assign {ins_ori, ins_andi, ins_slti, ins_addiu, ins_addi, ins_bne, ins_beq, ins_jal, ins_j, ins_bgez, ins_lh, ins_lw, ins_sw,
            ins_syscall, ins_jr, ins_srlv, ins_sllv, ins_sra, ins_srl, ins_sll, ins_add, ins_addu, ins_sub, ins_and, ins_or, ins_nor, ins_slt, ins_sltu} = AllIns[27:0];
    assign EX_WReg = (EX_WE == 1'h0) ? 5'h0 : 5'hz,
           EX_WReg = (EX_WE == 1'h1) ? EX_WReg_Init : 5'hz;
    assign MEM_WReg = (MEM_WE == 1'h0) ? 5'h0 : 5'hz,
           MEM_WReg = (MEM_WE == 1'h1) ? MEM_WReg_Init : 5'hz;
    assign Rs = (ins_syscall == 1'h0) ? Rs_Init : 5'hz,
           Rs = (ins_syscall == 1'h1) ? 5'h2 : 5'hz;
    assign Rt = (ins_syscall == 1'h0) ? Rt_Init : 5'hz,
           Rt = (ins_syscall == 1'h1) ? 5'h4 : 5'hz;
    assign RsZero = Rs[4] | Rs[3] | Rs[2] | Rs[1] | Rs[0];
    assign RtZero = Rt[4] | Rt[3] | Rt[2] | Rt[1] | Rt[0];
    assign EX_RsEqu = RsZero & (EX_WReg == Rs);
    assign EX_RtEqu = RtZero & (EX_WReg == Rt);
    assign MEM_RsEqu = RsZero & (MEM_WReg == Rs);
    assign MEM_RtEqu = RtZero & (MEM_WReg == Rt);

    assign Nop = (((ins_srlv | ins_sllv | ins_add | ins_addu | ins_sub | ins_and | ins_or | ins_nor | ins_slt | ins_sltu | ins_syscall) & (EX_RsEqu | EX_RtEqu))
               | ((ins_bne | ins_beq | ins_sw) & (EX_RsEqu | EX_RtEqu)) | ((ins_sra | ins_srl | ins_sll) & EX_RtEqu)
               | ((ins_ori | ins_andi | ins_slti | ins_addiu | ins_addi | ins_jr | ins_bgez | ins_lh | ins_lw) & EX_RsEqu)) & Load;
    assign Stop = ~Nop;

    assign EX_R1Equ = ((ins_sra | ins_srl | ins_sll) & EX_RtEqu) | ((ins_srlv | ins_sllv) & EX_RtEqu) | ((ins_bne | ins_beq | ins_sw) & EX_RsEqu)
                    | ((ins_ori | ins_andi | ins_slti | ins_addiu | ins_addi | ins_jr | ins_bgez | ins_lh | ins_lw) & EX_RsEqu)
                    | ((ins_add | ins_addu | ins_sub | ins_and | ins_or | ins_nor | ins_slt | ins_sltu | ins_syscall) & EX_RsEqu);
    assign MEM_R1Equ = ((ins_sra | ins_srl | ins_sll) & MEM_RtEqu) | ((ins_srlv | ins_sllv) & MEM_RtEqu) | ((ins_bne | ins_beq | ins_sw) & MEM_RsEqu)
                    | ((ins_ori | ins_andi | ins_slti | ins_addiu | ins_addi | ins_jr | ins_bgez | ins_lh | ins_lw) & MEM_RsEqu)
                    | ((ins_add | ins_addu | ins_sub | ins_and | ins_or | ins_nor | ins_slt | ins_sltu | ins_syscall) & MEM_RsEqu);
    assign RDTR1Src = {EX_R1Equ, MEM_R1Equ};

    assign EX_R2Equ = ((ins_srlv | ins_sllv) & EX_RsEqu) | ((ins_bne | ins_beq | ins_sw) & EX_RtEqu)
                    | ((ins_add | ins_addu | ins_sub | ins_and | ins_or | ins_nor | ins_slt | ins_sltu | ins_syscall) & EX_RtEqu);
    assign MEM_R2Equ = ((ins_srlv | ins_sllv) & MEM_RsEqu) | ((ins_bne | ins_beq | ins_sw) & MEM_RtEqu)
                    | ((ins_add | ins_addu | ins_sub | ins_and | ins_or | ins_nor | ins_slt | ins_sltu | ins_syscall) & MEM_RtEqu);
    assign RDTR2Src = {EX_R2Equ, MEM_R2Equ};
endmodule
