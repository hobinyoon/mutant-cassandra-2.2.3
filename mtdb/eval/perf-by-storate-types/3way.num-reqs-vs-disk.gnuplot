# Tested with gnuplot 4.6 patchlevel 6

set print "-"
FN_IN = system("echo $FN_IN")
COL_IDX_0 = system("echo $COL_IDX_0")
COL_IDX_1 = system("echo $COL_IDX_1")
FN_OUT = system("echo $FN_OUT")
TITLE = system("echo $TITLE")
LEGEND_LABELS = system("echo $LEGEND_LABELS")
LABEL_Y_0 = system("echo $LABEL_Y_0")
LABEL_Y_1 = system("echo $LABEL_Y_1")
Y_MAX = system("echo $Y_MAX")
Y_TICS_INTERVAL = system("echo $Y_TICS_INTERVAL")

#print (sprintf("c_lat: %s", c_lat))
# Convert string to int
#   http://stackoverflow.com/questions/9739315/how-to-convert-string-to-number-in-gnuplot
#c_lat=c_lat+0

c_x       = 0               # column(c_x)/1000.0, when c_x=5 is throughput
COL_IDX_0 = COL_IDX_0 + 0	# Convert string to int
COL_IDX_1 = COL_IDX_1 + 0	# Convert string to int
c_sat     = 12              # Saturated (overloaded)

# Get min and max values
#set terminal unknown
#X_MIN=GPVAL_DATA_X_MIN

terminal_size_x=3.5
terminal_size_y=0.5 * terminal_size_x
set terminal pdfcairo enhanced size (terminal_size_x)in, (terminal_size_y)in
set output FN_OUT

set multiplot layout 1,2 title TITLE offset 0,-0.15

#set tmargin at screen 0.60
set bmargin at screen 0.240
#set lmargin at screen 0.2290
#set rmargin at screen 0.990

set xlabel "Req rate" offset 10.7,0
set ylabel LABEL_Y_0 offset 1,0

set border (1 + 2) back lc rgb "#808080"
set xtics nomirror scale 0.5,0 tc rgb "#808080" autofreq 0,2
set ytics nomirror scale 0.5,0 tc rgb "#808080" autofreq 0,Y_TICS_INTERVAL

colors="#0000FF #FF0000 brown"

set xrange [0:12]
set yrange [0:Y_MAX]

# Legend
y1=Y_MAX*1.25
y1p=Y_MAX*0.01
y2=y1+12*y1p

x0=14
x2=10
legend_label_x(i) = \
(i==1 ? x0-x2 : \
(i==2 ? x0 : \
x0+x2 \
))

legend_arrow_len_half = 1.5
legend_arrow_dot_height_half = 0.5*y1p

legend_label2(w) = \
(w eq "ES" ? "EBS SSD only" : \
(w eq "EM" ? "EBS Magnetic only" : \
(w eq "LS" ? "Local SSD only" : \
(w eq "LSES" ? "LS + ES" : \
(w eq "LSEM" ? "LS + EM" : \
"unexpected" \
)))))
legend_label1(i) = legend_label2(word(LEGEND_LABELS, i))

do for [i=1:3] {
set label legend_label1(i) at legend_label_x(i), y1 center font ",10" tc rgb word(colors, i)
set arrow from legend_label_x(i)-legend_arrow_len_half,y2 to legend_label_x(i)+legend_arrow_len_half,y2 nohead lc rgb word(colors, i) lw 1.5
# This doesn't work. Because it is out of the plot range?
#set obj circle at legend_label_x(i),y2 size 4 fc rgb word(colors, i) fs solid 1.0 front;
set arrow from legend_label_x(i),y2+legend_arrow_dot_height_half to legend_label_x(i),y2-legend_arrow_dot_height_half nohead lw 3 lc rgb word(colors, i)
}

lw1=2

plot \
for [i=1:words(FN_IN)] word(FN_IN, i) u (column(c_x)):(column(c_sat) <= 1 ? column(COL_IDX_0) : 1/0) w lp pt 7 ps 0.15 lc rgb word(colors, i) not, \
for [i=1:words(FN_IN)] word(FN_IN, i) u (column(c_x)):(column(c_sat) >= 1 ? column(COL_IDX_0) : 1/0) w l lc rgb word(colors, i) lt 0 lw lw1 not, \
for [i=1:words(FN_IN)] word(FN_IN, i) u (column(c_x)):(column(c_sat) >= 1 ? column(COL_IDX_0) : 1/0) w p pt 6 ps 0.2 lc rgb word(colors, i) not

unset label
unset arrow
unset obj
set ylabel LABEL_Y_1 offset 1,0

plot \
for [i=1:words(FN_IN)] word(FN_IN, i) u (column(c_x)):(column(c_sat) <= 1 ? column(COL_IDX_1) : 1/0) w lp pt 7 ps 0.15 lc rgb word(colors, i) not, \
for [i=1:words(FN_IN)] word(FN_IN, i) u (column(c_x)):(column(c_sat) >= 1 ? column(COL_IDX_1) : 1/0) w l lc rgb word(colors, i) lt 0 lw lw1 not, \
for [i=1:words(FN_IN)] word(FN_IN, i) u (column(c_x)):(column(c_sat) >= 1 ? column(COL_IDX_1) : 1/0) w p pt 6 ps 0.2 lc rgb word(colors, i) not
