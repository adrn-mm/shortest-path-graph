% this file will generate a random graph
s = randi(10, 1, 100);
t = randi(10, 1, 100);
names = ["A", "B", "C", "D","E", "F", "G", "H", "I", "J"];
weight = randi(100, size(s));
title = 'My Random Graph';
save('myRandomGraph');


