load data1

a = unidrnd(2, 480, 640) - 1;

b = a.*frame(1).XYZ(:,:,1)