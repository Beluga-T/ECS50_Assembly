#include <iostream>

using namespace std;

std::string mantissa_to_binary(unsigned int mantissa)
{
    std::string binary;
    for (int i = 22; i >= 0; --i)
    {
        if (mantissa & (1 << i))
        {
            binary += '1';
        }
        else
        {
            binary += '0';
        }
    }
    return binary;
}
int main(int argc, char *argv[])
{
    float f;
    cout << "Please enter a float: ";
    cin >> ws >> f;
    // cout << a << endl;
    unsigned int float_int = *((unsigned int *)&f); // cast float to int
    // cout << float_int << endl;

    // exponent
    unsigned int exponent = (float_int >> 23) - 127;
    // cout << "exponent: " << exponent << endl;

    // sign
    unsigned int sign = float_int >> 31;
    // cout << "sign: " << sign << endl;

    // mantissa
    unsigned int mantissa = float_int & 0x7fffff; // 0b11111111111111111111111
    // cout << "mantissa: " << mantissa << endl;

    std::string binary_mantissa = mantissa_to_binary(mantissa);
    cout << "binary_mantissa: " << binary_mantissa << endl;
    // wipe out ending zeros
    int i = binary_mantissa.size() - 1;
    while (binary_mantissa[i] == '0') // while the last character is a zero
    {
        binary_mantissa.pop_back(); // erase the last character
        i--;
    }

    std::string binary = "1." + binary_mantissa;

    std::cout << binary << "E" << exponent << std::endl;
    return 0;
}
