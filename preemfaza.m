function [ Syg_out ] = preemfaza( Syg_in )
%filtr preefazy

Syg_out = filter([1 -0.95],1,Syg_in);
end

