#include <stdio.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <math.h>
using namespace std;

void checkFileExist(const string &fileName);
int getIdx(int row, int col, int size)
{
    return (row * (2 * size - row + 1)) / 2 + col - row; // get index of upper triangular matrix
}
int main(int argc, char **argv)
{
    ifstream f_mat1(argv[1]);
    ifstream f_mat2(argv[2]);

    if (argc < 3)
    {
        cerr << "Missing <matrixA file> and <matrixB file>" << endl;
        exit(1);
    }

    int size1;
    f_mat1 >> size1;
    // cout << "Matrix A size is: " << size1 << endl;

    int sizeA = (size1 * (size1 + 1)) / 2;

    // cout << "Matrix A is: " << endl;
    vector<int> matrixA(sizeA);
    for (int i = 0; i < sizeA; i++)
    {
        f_mat1 >> matrixA[i]; // read in matrixA
        // cout << matrixA[i] << " ";
    }
    // cout << endl;

    int size2;
    f_mat2 >> size2;
    // cout << "Matrix B size is: " << size2 << endl;
    int sizeB = (size2 * (size2 + 1)) / 2;
    // cout << "Matrix B is: " << endl;
    vector<int> matrixB(sizeB);
    for (int i = 0; i < sizeB; i++)
    {
        f_mat2 >> matrixB[i]; // read in matrixB
        // cout << matrixB[i] << " ";
    }
    // cout << endl;

    vector<int> matrixC(sizeB);
    // mutiply upper matrixA and upper matrixB
    for (int i = 0; i < size1; i++)
    {
        for (int j = i; j < size1; j++)
        {
            for (int k = i; k <= j; k++)
            {
                matrixC[getIdx(i, j, size1)] += matrixA[getIdx(i, k, size1)] * matrixB[getIdx(k, j, size1)];
            }
        }
    }
    // print matrix c
    //  cout << "Matrix C is: " << endl;
    for (int i = 0; i < sizeA; i++)
    {
        cout << matrixC[i] << " ";
    }
    return 0;
}

void checkFileExist(const string &fileName)
{
    ifstream file(fileName);
    if (!file)
    {
        cerr << "Error: cannot open file " << fileName << endl;
        exit(1);
    }
}
