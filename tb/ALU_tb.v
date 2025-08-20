module ALU_tb ();
  reg [7:0] A, B;
  reg [4:0] sel;
  reg clk, op_enable;
  reg fc, fz;
  reg [7:0] out;

  ALU test (
      .op_enable(op_enable),
      .clk(clk),
      .select(sel),
      .A(A),
      .B(B),
      .out(out),
      .flag_zero(fz),
      .flag_carry(fc)
  );

  initial begin
    A = 8'b11001011;
    B = 20;
    clk = 0;
    sel = 0;
    op_enable = 1;
    $dumpfile("AlU_tb.vcd");
    $dumpvars(0, test);
    #200;
    $finish;
  end

  always begin
    #5 clk = ~clk;
  end



  always @(posedge clk) begin

    A   = 8'b11001011;
    B   = 20;

    sel = sel + 1;

  end

endmodule
