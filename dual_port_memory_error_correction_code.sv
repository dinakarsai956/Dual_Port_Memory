/////////////////////////////////////////////////////////////////////////////////////////////////
//  Implementing a error correction code feature in a dual port memory by
//  implementing a hamming encoder in during write time and hamming decoder
//  during read time . It is where we insert a data to a hamming encoder and
//  it produces an output along with combination of parity bits and input data 
//  and produced output is taken as input to hamming decoder where as this
//  hamming decoder detect the error and corrected here we are taking syndrome
//  whether if syndrome is 0 there is no error if the syndrome is non_zero then there
//  is error based on syndrome output it will detects the error bit and flip
//  and correct the bit .
// 
///////////////////////////////////////////////////////////////////////////////////////////////
