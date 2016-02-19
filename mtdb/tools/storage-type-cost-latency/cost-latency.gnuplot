# Tested with gnuplot 4.6 patchlevel 4

FN_IN = system("echo $FN_IN")
FN_OUT = system("echo $FN_OUT")

## Get min and max values
##   GPVAL_DATA_[X|Y]_[MIN|MAX]
#set terminal unknown
#plot \
#FN_IN u 6:2:($4-$6):(0) with vectors not

set terminal pdfcairo enhanced size 2in, 1.5in
set output FN_OUT

#set tmargin at screen 0.975
#set bmargin at screen 0.152
#set lmargin at screen 0.185
#set rmargin at screen 0.940

set xlabel "Storage cost ($/GB/Month)" #offset 1.6,0
set ylabel "Latency (ms)" offset 1,0

set border (1 + 2) back lc rgb "#808080"
set xtics nomirror scale 0.5,0 tc rgb "#808080" #rotate by -90
set ytics nomirror scale 0.5,0 tc rgb "#808080"

# TODO: legend
#set style arrow 8 heads back nofilled lc rgb "#FF0000" size screen 0.004,90.000,90.000


set logscale xy

# with yerrorbars
#   (x, y, ylow, yhigh)
plot \
FN_IN u 5:($2/1000):($3/1000):($4/1000) with yerrorbars pt 7 pointsize 0.2 not

#X_RANGE=GPVAL_DATA_X_MAX-GPVAL_DATA_X_MIN
#print X_RANGE
#plot \
#FN_IN u (($6-GPVAL_DATA_X_MIN)/X_RANGE):2:(($4-$6)/X_RANGE):(0) with vectors arrowstyle 8 not
