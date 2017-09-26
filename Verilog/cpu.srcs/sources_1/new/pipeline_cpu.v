`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/03/03 00:13:17
// Design Name:
// Module Name: pipeline_cpu
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


module pipeline_cpu(
    input ComClk, Rst,
    input [3:0] IRSrc,

    output [31:0] mem0,
    output [31:0] mem1,
    output [31:0] mem2,
    output [31:0] mem3,
    output [31:0] mem4,
    output [31:0] mem5,
    output [31:0] mem6,
    output [31:0] mem7,
    output [31:0] mem8,
    output [31:0] mem9,
    output [31:0] mem10,
    output [31:0] mem11,
    output [31:0] mem12,
    output [31:0] mem13,
    output [31:0] mem14,
    output [31:0] mem15,

    output [3:0] IRWT,
    output [31:0] DigitalTube,
    output [31:0] ClkCount,
    output [31:0] LoadUseCount,
    output [31:0] BranchCount
    );

    wire Clk, Stop, PCSrc, WB_Halt, ID_PCAddSrc, RFR1Src, ID_RFWE, ID_ALUYSrc2, ID_DMWE, ID_Syscall, ID_Load, Nop, ID2EX_Rst;
    wire EX_Load, EX_Syscall, EX_RFWE, EX_ALUYSrc2, EX_DMWE, EX_PCAddSrc, PostClr, SIGINT, INT, Res;
    wire Equal, Judge, EX_Halt, EX_Disp, MEM_Halt, MEM_Disp, MEM_RFWE, MEM_DMWE, WB_RFWE, WB_Disp;
    wire [31:0] ClkCountTemp, PCDin, BrPC, BrPCTemp, IF_PC, IF_PC_Plus_1, IF_IR, ID_PC_Plus_1, ID_PC, ID_IR, AllIns, ID_RFD1, ID_RFD2, ID_a0, ID_v0, ID_Ext5to32, ID_SExt16to32, ID_Ext16to32, ID_Ext26to32, ID_CP00, ID_CP01;
    wire [31:0] EX_a0, EX_v0, EX_PC_Plus_1, EX_PC, EX_IR, EX_RFD1, EX_RFD2, EX_Ext5to32, EX_SExt16to32, EX_Ext16to32, EX_Ext26to32, EX_CP00, EX_CP01, INTRRegIn, IRNum, EPCRegIn;
    wire [31:0] RDTv0, RDTa0, RDTRFD1, RDTRFD2, ALUY_Temp, ALUY, EX_ALU, EX_PCAdd, MEM_RFDin, MEM_a0, MEM_PC, MEM_IR, MEM_ALU, MEM_RFD2, MEM_PCAdd, MEM_DM, MEM_CP00, MEM_CP01;
    wire [31:0] WB_INTRFDin, WB_RFDinTemp, WB_RFDin, WB_a0, WB_PC, WB_IR, WB_ALU, WB_DM, MEM_SExt16to32, WB_SExt16to32, WB_PCAdd, WB_CP00, WB_CP01;
    wire [5:0] OP, Funct;
    wire [6:0] ID_INTCtl, ID_BrIns, EX_INTCtl, EX_BrIns, MEM_INTCtl, WB_INTCtl;
    wire [4:0] Rs, Rt, Rd, Shamt, RFR1, RFR2, ID_WReg, EX_WReg, MEM_WReg, WB_WReg;
    wire [15:0] IMM16;
    wire [25:0] IMM26;
    wire [1:0] RFRWSrc, ID_RFDinSrc, ID_ALUYSrc, ID_RDTR1Src, ID_RDTR2Src, EX_RDTR1Src, EX_RDTR2Src, EX_ALUYSrc, EX_RFDinSrc, BrPCSrc, BrPCSrc2, MEM_RFDinSrc, WB_RFDinSrc;
    wire [3:0] ID_ALUOP, EX_ALUOP;

    wire Hit;
    wire [1:0] Predict;
    wire [31:0] BHT_BranchAddr, PCDinTemp;
    wire [10:0] ToBHT;
    wire [8:0] IF_BHTItem, ID_BHTItem, EX_BHTItem;
    wire [2:0] HitNum, InsertNum;

    assign Clk = ~WB_Halt & ComClk;
    assign WE = 1'h1;

    counter ClkCounter(.clk(Clk), .rst(Rst), .count(ClkCountTemp));
    assign ClkCount = (WB_Halt == 1'h0) ? ClkCountTemp : 32'hz,
           ClkCount = (WB_Halt == 1'h1) ? ClkCountTemp + 1 : 32'hz;

    pipeline_statistics LUBrCounter (.Clk(Clk), .WE(WE), .Rst(Rst), .LoadUseSel(Stop), .BranchSel(PCSrc),
                                     .LoadUseCount(LoadUseCount), .BranchCount(BranchCount));

    assign IF_PC_Plus_1 = IF_PC + 32'h1;
    assign PCDinTemp = ((Hit & Predict[1]) == 1'h0) ? IF_PC_Plus_1 : 32'hz,
           PCDinTemp = ((Hit & Predict[1]) == 1'h1) ? BHT_BranchAddr : 32'hz;
    assign PCDin = (PCSrc == 1'h0) ? PCDinTemp : 32'hz,
           PCDin = (PCSrc == 1'h1) ? BrPC : 32'hz;
    register REG_PC (.din(PCDin), .we(Stop), .rst(Rst), .clk(Clk), .dout(IF_PC));

    rom ROM_Ins (.addr(IF_PC[9:0]), .dout(IF_IR));

    pipeline_bht BHT (.clk(Clk), .rst(Rst), .cur_pc(IF_PC), .write_pc(EX_PC), .write_branch(BrPC),
                      .write_address(ToBHT[10:8]), .write_valid(ToBHT[7]), .write_predict(ToBHT[5:4]),
                      .we_valid(ToBHT[6]), .we_pc(ToBHT[1]), .we_branch(ToBHT[0]), .we_predict(ToBHT[3]), .we_lru(ToBHT[2]),
                      .Hit(Hit), .HitNum(HitNum), .BranchAddr(BHT_BranchAddr), .InsertNum(InsertNum), .Predict(Predict));
    assign IF_BHTItem = {InsertNum, HitNum, Predict, Hit};
    //assign IF_BHTItem = 9'h0;

    pipeline_if2id IF2ID (.WE(Stop), .Rst(PCSrc), .Clk(Clk), .Asyn_Rst(Rst),
                          .BHTItem_Din(IF_BHTItem), .PC_PLUS_1_Din(IF_PC_Plus_1), .PC_Din(IF_PC), .IR_Din(IF_IR),
                          .BHTItem_Dout(ID_BHTItem), .PC_PLUS_1_Dout(ID_PC_Plus_1), .PC_Dout(ID_PC), .IR_Dout(ID_IR));

    InsAnalyse IA (.ins(ID_IR), .op(OP), .rs(Rs), .rt(Rt), .rd(Rd), .shamt(Shamt),
                  .funct(Funct), .immediate16(IMM16), .immediate26(IMM26));

    pipeline_controller CTL (.op(OP), .funct(Funct), .Rs(Rs), .Rd(Rd),
                             .PCAddSrc(ID_PCAddSrc), .RFR1Src(RFR1Src),
                             .RFRWSrc(RFRWSrc), .RFDinSrc(ID_RFDinSrc), .RFWE(ID_RFWE),
                             .ALUYSrc(ID_ALUYSrc), .ALUYSrc2(ID_ALUYSrc2), .ALUOP(ID_ALUOP),
                             .DMWE(ID_DMWE), .Syscall(ID_Syscall), .Load(ID_Load),
                             .INTCtl(ID_INTCtl), .BrIns(ID_BrIns), .AllIns(AllIns));

    assign RFR1 = (RFR1Src == 1'h0) ? Rs : 32'hz,
           RFR1 = (RFR1Src == 1'h1) ? Rt : 32'hz;
    assign RFR2 = (RFR1Src == 1'h1) ? Rs : 32'hz,
           RFR2 = (RFR1Src == 1'h0) ? Rt : 32'hz;
    assign ID_WReg = (RFRWSrc == 2'h0) ? Rt : 32'hz,
           ID_WReg = (RFRWSrc == 2'h1) ? Rd : 32'hz,
           ID_WReg = (RFRWSrc == 2'h2) ? 32'h1f : 32'hz,
           ID_WReg = (RFRWSrc == 2'h3) ? 32'h0 : 32'hz;
    pipeline_regfile RF(.read_reg1(RFR1), .read_reg2(RFR2), .write_reg(WB_WReg), .write_data(WB_RFDin),
                        .we(WB_RFWE), .rst(Rst), .clk(Clk),
                        .reg1(ID_RFD1), .reg2(ID_RFD2), .a0(ID_a0), .v0(ID_v0));

    pipeline_data_hazard DataHzd (.EX_WReg_Init(EX_WReg), .MEM_WReg_Init(MEM_WReg),
                                  .EX_WE(EX_RFWE), .MEM_WE(MEM_RFWE), .Load(EX_Load),
                                  .Rs_Init(Rs), .Rt_Init(Rt), .AllIns(AllIns), .Nop(Nop), .Stop(Stop),
                                  .RDTR1Src(ID_RDTR1Src), .RDTR2Src(ID_RDTR2Src));

    assign ID_Ext5to32 = {{27{1'h0}}, Shamt};
    assign ID_SExt16to32 = {{16{IMM16[15]}}, IMM16};
    assign ID_Ext16to32 = {{16{1'h0}}, IMM16};
    assign ID_Ext26to32 = {{6{1'h0}}, IMM26};

    assign ID2EX_Rst = Nop | PCSrc;
    pipeline_id2ex ID2EX (.WE(WE), .Rst(ID2EX_Rst), .Clk(Clk), .Asyn_Rst(Rst),
                          .BHTItem_Din(ID_BHTItem), .CP01_Din(ID_CP01), .CP00_Din(ID_CP00), .INTCtl_Din(ID_INTCtl),
                          .BHTItem_Dout(EX_BHTItem), .CP01_Dout(EX_CP01), .CP00_Dout(EX_CP00), .INTCtl_Dout(EX_INTCtl),
                          .Load_Din(ID_Load), .RDTR1Src_Din(ID_RDTR1Src), .RDTR2Src_Din(ID_RDTR2Src),
                          .Load_Dout(EX_Load), .RDTR1Src_Dout(EX_RDTR1Src), .RDTR2Src_Dout(EX_RDTR2Src),
                          .a0_Din(ID_a0), .v0_Din(ID_v0), .Syscall_Din(ID_Syscall), .PC_PLUS_1_Din(ID_PC_Plus_1),
                          .a0_Dout(EX_a0), .v0_Dout(EX_v0), .Syscall_Dout(EX_Syscall), .PC_PLUS_1_Dout(EX_PC_Plus_1),
                          .PC_Din(ID_PC), .IR_Din(ID_IR), .ALUOP_Din(ID_ALUOP), .ALUYSrc_Din(ID_ALUYSrc), .ALUYSrc2_Din(ID_ALUYSrc2),
                          .PC_Dout(EX_PC), .IR_Dout(EX_IR), .ALUOP_Dout(EX_ALUOP), .ALUYSrc_Dout(EX_ALUYSrc), .ALUYSrc2_Dout(EX_ALUYSrc2),
                          .RFD1_Din(ID_RFD1), .RFD2_Din(ID_RFD2), .Ext5to32_Din(ID_Ext5to32), .SExt16to32_Din(ID_SExt16to32),
                          .RFD1_Dout(EX_RFD1), .RFD2_Dout(EX_RFD2), .Ext5to32_Dout(EX_Ext5to32), .SExt16to32_Dout(EX_SExt16to32),
                          .Ext16to32_Din(ID_Ext16to32), .Ext26to32_Din(ID_Ext26to32), .DMWE_Din(ID_DMWE), .PCAddSrc_Din(ID_PCAddSrc),
                          .Ext16to32_Dout(EX_Ext16to32), .Ext26to32_Dout(EX_Ext26to32), .DMWE_Dout(EX_DMWE), .PCAddSrc_Dout(EX_PCAddSrc),
                          .RFWE_Din(ID_RFWE), .RFDinSrc_Din(ID_RFDinSrc), .BrIns_Din(ID_BrIns), .WReg_Din(ID_WReg),
                          .RFWE_Dout(EX_RFWE), .RFDinSrc_Dout(EX_RFDinSrc), .BrIns_Dout(EX_BrIns), .WReg_Dout(EX_WReg));

    assign INTRRegIn = (WB_INTCtl[2] == 1'h0) ? 32'h1 : 32'hz,
           INTRRegIn = (WB_INTCtl[2] == 1'h1) ? WB_RFDin : 32'hz;
    pipeline_intr INTR (.Clk(Clk), .Rst(Rst), .IEW_Init(WB_INTCtl[4]), .INMW(WB_INTCtl[3]), .IRSrc(IRSrc), .IR(EX_IR), .PC(EX_PC), .RegIn(INTRRegIn),
                        .INT(INT), .Res(Res), .IRWT(IRWT), .IRNum(IRNum), .RegOut(ID_CP00));
    assign SIGINT = INT & Res;

    assign EPCRegIn = (WB_INTCtl[0] == 1'h0) ? EX_PC : 32'hz,
           EPCRegIn = (WB_INTCtl[0] == 1'h1) ? WB_RFDin : 32'hz;
    register REG_EPC (.din(EPCRegIn), .we(SIGINT | WB_INTCtl[1]), .rst(Rst), .clk(Clk), .dout(ID_CP01));

    assign RDTv0 = (EX_RDTR1Src == 2'h0) ? EX_v0 : 32'hz,
           RDTv0 = (EX_RDTR1Src == 2'h1) ? WB_RFDin : 32'hz,
           RDTv0 = (EX_RDTR1Src == 2'h2) ? MEM_RFDin : 32'hz,
           RDTv0 = (EX_RDTR1Src == 2'h3) ? MEM_RFDin : 32'hz;
    assign RDTa0 = (EX_RDTR2Src == 2'h0) ? EX_a0 : 32'hz,
           RDTa0 = (EX_RDTR2Src == 2'h1) ? WB_RFDin : 32'hz,
           RDTa0 = (EX_RDTR2Src == 2'h2) ? MEM_RFDin : 32'hz,
           RDTa0 = (EX_RDTR2Src == 2'h3) ? MEM_RFDin : 32'hz;
    assign EX_Halt = EX_Syscall & (RDTv0 == 32'ha);
    assign EX_Disp = EX_Syscall & (RDTv0 != 32'ha);
    assign RDTRFD1 = (EX_RDTR1Src == 2'h0) ? EX_RFD1 : 32'hz,
           RDTRFD1 = (EX_RDTR1Src == 2'h1) ? WB_RFDin : 32'hz,
           RDTRFD1 = (EX_RDTR1Src == 2'h2) ? MEM_RFDin : 32'hz,
           RDTRFD1 = (EX_RDTR1Src == 2'h3) ? MEM_RFDin : 32'hz;
    assign RDTRFD2 = (EX_RDTR2Src == 2'h0) ? EX_RFD2 : 32'hz,
           RDTRFD2 = (EX_RDTR2Src == 2'h1) ? WB_RFDin : 32'hz,
           RDTRFD2 = (EX_RDTR2Src == 2'h2) ? MEM_RFDin : 32'hz,
           RDTRFD2 = (EX_RDTR2Src == 2'h3) ? MEM_RFDin : 32'hz;
    assign ALUY_Temp = (EX_ALUYSrc == 2'h0) ? RDTRFD2 : 32'hz,
           ALUY_Temp = (EX_ALUYSrc == 2'h1) ? EX_Ext5to32 : 32'hz,
           ALUY_Temp = (EX_ALUYSrc == 2'h2) ? EX_SExt16to32 : 32'hz,
           ALUY_Temp = (EX_ALUYSrc == 2'h3) ? EX_Ext16to32 : 32'hz;
    assign ALUY = (EX_ALUYSrc2 == 1'h0) ? ALUY_Temp : 32'hz,
           ALUY = (EX_ALUYSrc2 == 1'h1) ? 32'h0 : 32'hz;
    alu ALU(.x(RDTRFD1), .y(ALUY), .op(EX_ALUOP), .result(EX_ALU), .equal(Equal));
    assign Judge = EX_ALU[0];

    pipeline_branch_hazard BrchHzd (.equal(Equal), .judge(Judge), .intr(SIGINT), .BrIns(EX_BrIns),
                                    .PredictYes(BrPC == ID_PC), .BHTItem(EX_BHTItem), .ToBHT(ToBHT),
                                    .PCSrc(PCSrc), .BrPCSrc(BrPCSrc), .BrPCSrc2(BrPCSrc2), .PostClr(PostClr));

    assign EX_PCAdd = (EX_PCAddSrc == 1'h0) ? EX_PC_Plus_1 : 32'hz,
           EX_PCAdd = (EX_PCAddSrc == 1'h1) ? (EX_PC_Plus_1 + EX_SExt16to32) : 32'hz;
    assign BrPCTemp = (BrPCSrc == 2'h0) ? RDTRFD1 : 32'hz,
           BrPCTemp = (BrPCSrc == 2'h1) ? EX_PC_Plus_1 : 32'hz,
           BrPCTemp = (BrPCSrc == 2'h2) ? EX_PCAdd : 32'hz,
           BrPCTemp = (BrPCSrc == 2'h3) ? EX_Ext16to32 : 32'hz;
    assign BrPC = (BrPCSrc2 == 2'h0) ? BrPCTemp : 32'hz,
           BrPC = (BrPCSrc2 == 2'h1) ? EX_CP01 : 32'hz,
           BrPC = (BrPCSrc2 == 2'h2) ? IRNum + 32'h1 : 32'hz,
           BrPC = (BrPCSrc2 == 2'h3) ? IRNum + 32'h1 : 32'hz;

    pipeline_ex2mem EX2MEm (.WE(WE), .Rst(PostClr), .Clk(Clk), .Asyn_Rst(Rst),
                            .CP01_Din(EX_CP01), .CP00_Din(EX_CP00), .INTCtl_Din(EX_INTCtl),
                            .CP01_Dout(MEM_CP01), .CP00_Dout(MEM_CP00), .INTCtl_Dout(MEM_INTCtl),
                            .a0_Din(RDTa0), .Disp_Din(EX_Disp), .Halt_Din(EX_Halt), .PC_Din(EX_PC), .IR_Din(EX_IR),
                            .a0_Dout(MEM_a0), .Disp_Dout(MEM_Disp), .Halt_Dout(MEM_Halt), .PC_Dout(MEM_PC), .IR_Dout(MEM_IR),
                            .DMWE_Din(EX_DMWE), .RFWE_Din(EX_RFWE), .RFDinSrc_Din(EX_RFDinSrc), .ALU_Din(EX_ALU),
                            .DMWE_Dout(MEM_DMWE), .RFWE_Dout(MEM_RFWE), .RFDinSrc_Dout(MEM_RFDinSrc), .ALU_Dout(MEM_ALU),
                            .RFD2_Din(RDTRFD2), .PCAdd_Din(EX_PCAdd), .WReg_Din(EX_WReg),
                            .RFD2_Dout(MEM_RFD2), .PCAdd_Dout(MEM_PCAdd), .WReg_Dout(MEM_WReg));

    //ram DM(.addr(MEM_ALU[9:0]), .din(MEM_RFD2), .we(MEM_DMWE), .rst(Rst), .clk(Clk), .dout(MEM_DM));
    ram_test DM(.addr(MEM_ALU[9:0]), .din(MEM_RFD2), .we(MEM_DMWE), .rst(Rst), .clk(Clk), .dout(MEM_DM),
                .mem0(mem0), .mem1(mem1), .mem2(mem2), .mem3(mem3), .mem4(mem4), .mem5(mem5),
                .mem6(mem6), .mem7(mem7), .mem8(mem8), .mem9(mem9), .mem10(mem10), .mem11(mem11),
                .mem12(mem12), .mem13(mem13), .mem14(mem14), .mem15(mem15));

    assign MEM_RFDin = (MEM_RFDinSrc == 2'h0) ? MEM_PCAdd : 32'hz,
           MEM_RFDin = (MEM_RFDinSrc == 2'h1) ? 32'h0 : 32'hz,
           MEM_RFDin = (MEM_RFDinSrc == 2'h2) ? MEM_ALU : 32'hz,
           MEM_RFDin = (MEM_RFDinSrc == 2'h3) ? 32'h0 : 32'hz;

    assign MEM_SExt16to32 = {{16{MEM_DM[15]}}, MEM_DM[15:0]};
    pipeline_mem2wb MEM2WB (.WE(WE), .Rst(Rst), .Clk(Clk), .Asyn_Rst(Rst),
                            .CP01_Din(MEM_CP01), .CP00_Din(MEM_CP00), .INTCtl_Din(MEM_INTCtl),
                            .CP01_Dout(WB_CP01), .CP00_Dout(WB_CP00), .INTCtl_Dout(WB_INTCtl),
                            .a0_Din(MEM_a0), .Disp_Din(MEM_Disp), .Halt_Din(MEM_Halt), .PC_Din(MEM_PC), .IR_Din(MEM_IR),
                            .a0_Dout(WB_a0), .Disp_Dout(WB_Disp), .Halt_Dout(WB_Halt), .PC_Dout(WB_PC), .IR_Dout(WB_IR),
                            .RFWE_Din(MEM_RFWE), .RFDinSrc_Din(MEM_RFDinSrc), .ALU_Din(MEM_ALU), .DM_Din(MEM_DM),
                            .RFWE_Dout(WB_RFWE), .RFDinSrc_Dout(WB_RFDinSrc), .ALU_Dout(WB_ALU), .DM_Dout(WB_DM),
                            .SExt16to32_Din(MEM_SExt16to32), .PCAdd_Din(MEM_PCAdd), .WReg_Din(MEM_WReg),
                            .SExt16to32_Dout(WB_SExt16to32), .PCAdd_Dout(WB_PCAdd), .WReg_Dout(WB_WReg));

    assign WB_INTRFDin = (WB_INTCtl[6] == 1'h0) ? WB_CP00 : 32'hz,
           WB_INTRFDin = (WB_INTCtl[6] == 1'h1) ? WB_CP01 : 32'hz;
    assign WB_RFDinTemp = (WB_RFDinSrc == 2'h0) ? WB_PCAdd : 32'hz,
           WB_RFDinTemp = (WB_RFDinSrc == 2'h1) ? WB_DM : 32'hz,
           WB_RFDinTemp = (WB_RFDinSrc == 2'h2) ? WB_ALU : 32'hz,
           WB_RFDinTemp = (WB_RFDinSrc == 2'h3) ? WB_SExt16to32 : 32'hz;
    assign WB_RFDin = (WB_INTCtl[5] == 1'h0) ? WB_RFDinTemp : 32'hz,
           WB_RFDin = (WB_INTCtl[5] == 1'h1) ? WB_INTRFDin : 32'hz;
    register #(32) REG_Disp (.din(WB_a0), .we(WE), .rst(Rst), .clk(WB_Disp), .dout(DigitalTube));
endmodule
