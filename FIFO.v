module FIFO(clk, rst, buf_in, buf_out, wr_en, rd_en, buf_empty, buf_full, fifo_counter);

input clk, rst, wr_en, rd_en;
input[7:0] buf_in;
output[7:0] buf_out;
output buf_empty, buf_full;
output[7:0] fifo_counter;

reg[7:0] buf_out;
reg buf_empty, buf_full;
reg[6:0] fifo_counter;
reg[3:0] rd_ptr, wr_ptr;
reg[7:0] buf_mem[63:0];

always@(fifo_counter)
    begin
      buf_empty=(fifo_counter==0);
      buf_full=(fifo_counter==64);
    end

always@(posedge clk or posedge rst)//manages counter
    begin
      if(rst)
        fifo_counter=0;
      else if(!buf_full && wr_en)&&(!buf_empty && rd_en)
        fifo_counter<=fifo_counter;
      else if(!buf_full && wr_en)
        fifo_counter=fifo_counter+1;
      else if(!buf_empty && rd_en)
        fifo_counter=fifo_counter-1;
      else
        fifo_counter=fifo_counter;
    end

always@(posedge clk or posedge rst)//manages read
    begin
        if(rst)
            buf_out<=0;
        else if(rd_en && !buf_empty)
            buf_out<=buf_mem[rd_ptr];
        else
            buf_out=buf_out;
    end
always@(posedge clk or posedge rst)// manages write
    begin
        if(rst)
            buf_in<=0;
        else if(wr_en && !buff_full)
            buf_mem[wr_ptr]<=buf_in;
        else
            buf_mem[wr_ptr]<=buf_mem[wr_ptr];
    end

always@(posedge clk or posedge rst)
    begin
        if(rst)
            begin
                wr_ptr<=0;
                rd_ptr<=0;
            end
        else
             if(rd_en && !buf_empty)
                rd_ptr<=rd_ptr+1;
             else
                rd_ptr=rd_ptr;
        else
            if(wr_en && !buf_full)
                wd_ptr<=wd_ptr+1;
            else
                wd_ptr=wd_ptr;
            
    end
endmodule
