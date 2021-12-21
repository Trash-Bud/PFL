
perms ys =  [[x,y,z] |y <- ys, x <- ys, z <-ys, y/= x, y/=z, x /= z]