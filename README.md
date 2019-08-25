# pic2wave
using verilog/systemverilog simulation result(a vcd wave) to display some image. the image will be clustered(using color quant) to no more than 4 color(wave only support 0/1/x/z) 
## run
to run the project , you should privide a image file,
and use the tools/py_kmeans.py tool to translate the file.
>cd run
>sh run.sh
if you just want to run the verilog file with a default img_out(./tools/img_out.txt)
>cd run
>sh run2.sh
