#!/bin/sh

B='#3c3836ff'  # background
D='#1d2021ff'  # default
T='#ebdbb2ff'  # text
W='#cc241dff'  # wrong
Y='#d78821ff'  # typing
V='#689d6aff'  # verifying

i3lock                  \
--insidevercolor=$B     \
--ringvercolor=$V       \
\
--insidewrongcolor=$B   \
--ringwrongcolor=$W     \
\
--insidecolor=$B        \
--ringcolor=$D          \
--linecolor=$B          \
--separatorcolor=$D     \
\
--verifcolor=$T         \
--wrongcolor=$T         \
--timecolor=$T          \
--datecolor=$T          \
--layoutcolor=$T        \
--keyhlcolor=$Y         \
--bshlcolor=$Y          \
\
--screen 1              \
--blur 6                \
--clock                 \
--indicator             \
--timestr="%H:%M:%S"    \
--datestr="%A, %m %Y"   \
--keylayout 2           \
--veriftext="Verifying" \
--wrongtext="X"         \
# --textsize=20           \
# --timefont=comic-sans
# --datefont=monofur
# etc
