set terminal pngcairo font "arial,12" fontscale 1.5 size 1280, 720
set output 'NDD_plot.png'
set title "Newton's divided difference"
set xlabel 'X'
set ylabel 'Y'
set grid
set zeroaxis
plot 'Output_NDD.dat' using 1:2 title "Polynomial" w l ls 6 lc 1
