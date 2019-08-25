module PIC2WAVE();

localparam N = 20;
localparam W = 160;
localparam H = 120;
logic [0:H-1] rtl_wave;
logic [7:0] mem[W*H];
logic clk;
initial begin
    clk = 0;
    forever begin
        #1ns clk = !clk;
    end
end
task toggle(input logic clk,input int n,output logic out);
    repeat(n) begin
        @(posedge clk);
        out = !out;
    end
endtask
task stable0(input logic clk,input int n,output logic out);
    repeat(n) begin
        @(posedge clk);
        out = 0;
    end
endtask
initial begin
    //mem = new[120*80];

    $readmemh("../tools/img_out.txt",mem);
    rtl_wave = '0;
    for(int i = 0; i < H; i++) begin
        automatic int idx = i;
        fork 
        begin
        for(int j = 0; j < W; j++) begin
            //if((idx<40) & (j < 72)) begin
            if(1) begin
                $display("i is %d,j %d\n",idx,j);
                if(mem[idx*W+j] == 0) begin
                    $display("toggle_now\n");
                    //toggle(clk,N,rtl_wave[idx]);
//rtl_wave[idx] = 1;
                    repeat(N) begin
                        @(posedge clk);
                        rtl_wave[idx] = !rtl_wave[idx];
                    end
                end else if(mem[idx*W+j] ==3) begin
                    repeat(N/2) begin
                        @(posedge clk);
                        rtl_wave[idx] = 1'bx;
                        @(posedge clk);
                        rtl_wave[idx] = 1'b0;
                    end
                end else if(mem[idx*W+j] ==2) begin
                    repeat(N/2) begin
                        @(posedge clk);
                        rtl_wave[idx] = 1'bz;
                        @(posedge clk);
                        rtl_wave[idx] = 1'b0;
                    end

                end else begin
                    rtl_wave[idx] = 0;
                    repeat(N) @(posedge clk);
                    //stable0(clk,N,rtl_wave[idx]);
                end
            end
        end
        end
        join_none
    end
                
end
    

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0,PIC2WAVE);
    #(W*2*N);
    #200ns;
    $finish(0);
end


endmodule
