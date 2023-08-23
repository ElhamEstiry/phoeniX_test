/*
    Address Generator:
    There are 3 types of addresses generated in this module:
    1. Branch Address
    2. Jump and Link Address
    3. Load/Store Address
    Immediate values are determined in Immediate_Generator module.
    So no determination (Mux) will be needed here.(I-J-B immediate)
*/

`ifndef OPCODES
    `include "Opcodes.v"
`endif 

module Address_Generator
(
    input [6 : 0] opcode, 
    input [31 : 0] rs1,            // to be connected to bus_rs1
    input [31 : 0] PC,
    input [31 : 0] immediate,

    output [31 : 0] address
);
    reg  [31 : 0] value;
    always @(*) 
    begin
        // Address Type evaluation (for Address Generator module)
        case (opcode)
            STORE   : value = rs1;    //  Store  -> bus_rs1 + immediate
            LOAD    : value = rs1;    //  Load   -> bus_rs1 + immediate
            JAL     : value = PC;     //  JAL    ->    PC   + immediate
            JALR    : value = PC;     //  JALR   ->    PC   + immediate
            BRANCH  : value = PC;     //  Branch ->    PC   + immediate
            default: value = 1'bz;
        endcase 
    end

    assign address = value + immediate;
    
endmodule