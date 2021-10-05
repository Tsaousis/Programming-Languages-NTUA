// EMPNEUSI APO link :https://www.geeksforgeeks.org/longest-subarray-having-average-greater-than-or-equal-to-x/

// Arketes metatropes kai DEN exoume xrhsimopoihsei ton idio algorthmo sthn ML, o algorithmos mas einai O(nlogn)edw kai O(n) sthn MOD_CLKA

// Euxaristoume!







#include <iostream>
#include <utility>
#include <iostream>
#include <algorithm>  
#include <vector>
#include <fstream>

using namespace std;

int megistoindex(int arr[], int n)
{
    int maxdiafora;
    int i, j;

    int lminimum[n], rmegisto[n];


















    lminimum[0] = arr[0];
    for (i = 1; i < n; ++i)
        lminimum[i] = min(arr[i], lminimum[i - 1]);












    
    rmegisto[n - 1] = arr[n - 1];
    for (j = n - 2; j >= 0; --j)
        rmegisto[j] = max(arr[j], rmegisto[j + 1]);


    i = 0, j = 0, maxdiafora = -1;
    while (j < n && i < n) {
        if (lminimum[i] < rmegisto[j]) {
            maxdiafora = max(maxdiafora, j - i);
            j = j + 1;
        }
        else
            i = i + 1;
    }

    return maxdiafora + 1;
}


void vrestoprefix(int arr[], int n)
{
    int s = 0;
    for (int i = 0; i < n; i++) {
        s += arr[i];
        arr[i] = s;
    }
}


int longestsubarray(int arr[], int n, int x)
{
    for (int i = 0; i < n; i++)
        arr[i] = arr[i] - x;
    vrestoprefix(arr, n);

    return megistoindex(arr, n);
}




bool basicCompare(const pair<int, int>& a, const pair<int, int>& b)
{
    if (a.first == b.first)
        return a.second < b.second;

    return a.first < b.first;
}

int findInd(vector<pair<int, int> >& presumpair, int n, int val)
{


    int starts = 0;
    int ends = n - 1;
    int mesi;

    int ans = -1;


    while (starts <= ends) {
        mesi = (starts + ends) / 2;
        if (presumpair[mesi].first <= val) {
            ans = mesi;
            starts = mesi + 1;
        }
        else
            ends = mesi - 1;
    }

    return ans;
}


int megalytero(vector<int> arr, int n, int x)
{
    int i;

    for (i = 0; i < n; i++)
        arr[i] -= x;

    int tomaximum = 0;


    vector<pair<int, int> > presumpair;
    int sum = 0;

    int minimumIndex[n];


    for (i = 0; i < n; i++) {
        sum = sum + arr[i];
        presumpair.push_back({ sum, i });
    }

    sort(presumpair.begin(), presumpair.end(), basicCompare);


    minimumIndex[0] = presumpair[0].second;

    for (i = 1; i < n; i++) {
        minimumIndex[i] = min(minimumIndex[i - 1], presumpair[i].second);
    }

    sum = 0;
    for (i = 0; i < n; i++) {
        sum = sum + arr[i];

        // If sum is greater than or equal to 0,
        // then answer is i+1.
        if (sum >= 0)
            tomaximum = i + 1;

        else {
            int ind = findInd(presumpair, n, sum);
            if (ind != -1 && minimumIndex[ind] < i)
                tomaximum = max(tomaximum, i - minimumIndex[ind]);
        }
    }

    return tomaximum;
}
// #include <string>

// using namespace std;

// const int SIZE = 22;
// int grades[SIZE];

// void readData() {


//     string inFileName = "grades.txt";
//     ifstream inFile;
//     inFile.open(inFileName.c_str());

//     if (inFile.is_open())
//     {
//         for (int i = 0; i < SIZE; i++)
//         {
//             inFile >> grades[i];
//             cout << grades[i] << " ";
//         }

//         inFile.close(); // CLose input file
//     }
//     else { //Error message
//         cerr << "Can't find input file " << inFileName << endl;
//     }
// }



// int main()
// {
//     readData();
//     return 0;
// }  
// Driver code.
int main(int argc, char* argv[])
{

    //fast input
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    //open file
    ifstream inFile;    inFile.open(argv[1]);
    int n, t, M;
    inFile >> M;
    inFile >> n;
    vector<int> arr;


    //take input
    for (int i = 0; i < M; i++) {
        inFile >> t;
        arr.push_back(t);
    }
    
    for (int i = 0; i < M; i++)
            arr[i] = -arr[i];


    cout << megalytero(arr, M, n) << endl;
    return 0;
    

}
        

      