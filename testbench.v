`timescale 1ns/1ps

module ripple_carry_adder_4bit_tb;

reg  [3:0] A;
reg  [3:0] B;
reg        Cin;

wire [3:0] Sum;
wire       Cout;

integer errors;
reg [4:0] expected;   // {Cout, Sum[3:0]}

ripple_carry_adder_4bit uut(
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
);

task check;
    begin
        expected = A + B + Cin;
        #1; // allow combinational logic to settle before sampling
        if ({Cout, Sum} !== expected) begin
            errors = errors + 1;
            $display("FAIL: A=%b B=%b Cin=%b | got Sum=%b Cout=%b | expected Sum=%b Cout=%b",
                      A, B, Cin, Sum, Cout, expected[3:0], expected[4]);
        end else begin
            $display("PASS: A=%b B=%b Cin=%b | Sum=%b Cout=%b", A, B, Cin, Sum, Cout);
        end
    end
endtask

initial begin
    errors = 0;
    $display("Time\tA\tB\tCin\tSum\tCout");
    $monitor("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, Cin, Sum, Cout);

    A = 4'b0000; B = 4'b0000; Cin = 0; #9; check;
    A = 4'b0001; B = 4'b0001; Cin = 0; #9; check;
    A = 4'b0010; B = 4'b0011; Cin = 0; #9; check;
    A = 4'b0101; B = 4'b0011; Cin = 0; #9; check;
    A = 4'b1111; B = 4'b0001; Cin = 0; #9; check;
    A = 4'b1010; B = 4'b0101; Cin = 1; #9; check;
    A = 4'b1111; B = 4'b1111; Cin = 0; #9; check;

    if (errors == 0)
        $display("ALL TESTS PASSED");
    else
        $display("%0d TEST(S) FAILED", errors);

    $finish;
end

endmodule
