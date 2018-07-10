#!/bin/bash
end="100"

#tmpfs, mkfifo
yes "xwd -root -silent -out \$meow.xwd; ((meow++))" | bash

