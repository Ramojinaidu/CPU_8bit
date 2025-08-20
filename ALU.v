`include "mcodes.v"
module ALU (
    input wire op_enable,
    input wire clk,
    input wire [4:0] select,
    input wire [DATA_SIZE-1:0] A,
    input wire [DATA_SIZE-1:0] B,
    output wire [DATA_SIZE-1:0] out,
    output reg flag_zero,
    output reg flag_carry
);
  parameter int DATA_SIZE = 8;

  reg [DATA_SIZE-1:0] buff;

  initial begin
    flag_carry = 0;
    flag_zero = 0;
    buff = 8'b0;
  end



  always @(posedge clk) begin
    case (select)
      `ALU_ADD: {flag_carry, buff} = A + B;
      `ALU_SUB: {flag_carry, buff} = A - B;
      /* verilator lint_off WIDTHEXPAND */
      `ALU_ADC: {flag_carry, buff} = A + B + flag_carry;
      `ALU_LS:  {flag_carry, buff} = A << 1;
      `ALU_RS:  {flag_carry, buff} = A >> 1;
      `ALU_AND: buff = A & B;
      `ALU_OR:  buff = A | B;
      `ALU_XOR: buff = A ^ B;
      default:  buff = A;
    endcase

    flag_zero = (buff == 0) ? 1 : 0;



  end

  assign out = op_enable ? buff : 8'bzzzzzzzz;
endmodule
