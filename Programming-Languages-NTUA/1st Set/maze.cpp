          
#include <iostream>
#include <fstream>
#include <vector>
#include <stack>
#include <set>
using namespace std;

int n_lines, m_collums;

pair<int, int> UNKNOWN = make_pair(-1, -1);
pair<int, int> OUTSIDE = make_pair(-2, -2);
pair<int, int> TRAPPED = make_pair(-3, -3);

void printmaze(vector<vector<pair<int, int> > >& parent){
    for (int i = 0; i < n_lines; i++)    {
        for (int j = 0; j < m_collums; j++)        {
            if (parent[i][j] == make_pair(i - 1, j)) cout << "^";
            else if (parent[i][j] == make_pair(i + 1, j)) cout << "v";
            else if (parent[i][j] == make_pair(i, j - 1)) cout << "<";
            else if (parent[i][j] == make_pair(i, j + 1)) cout << ">";
            else if (parent[i][j] == OUTSIDE) cout << "o";
            else cout << "x";
        }
        cout << endl;
    }
    cout << "---------------" << endl;
}

void change_parent(vector<vector<pair<int, int> > >& parent, vector<pair<int, int> > &route,pair<int, int> father) {

    for (size_t i = 0; i < route.size(); i++) {
        parent[route[i].first][route[i].second] = father;
    }
    route.clear();
}



 void find_route (vector<vector<pair<int, int> > >& parent,pair<int,int> start) {
     vector<pair<int, int> > route;

     route.push_back(start);
     bool f = 1;
     pair<int, int> father,dadtemp,dad = parent[start.first][start.second];

     while (f)     {
         if (dad == OUTSIDE) {
             f = 0;
             father = OUTSIDE;
         } 
         else if (dad == TRAPPED) {
             f = 0;
             father = TRAPPED;
         }
         else {
             route.push_back(dad);
             dadtemp = dad;
             
             dad = parent[dad.first][dad.second];
             parent[dadtemp.first][dadtemp.second] = TRAPPED;
         }
     }
     change_parent(parent,route, father);
 }

 int cout_out(vector<vector<pair<int, int> > >& parent){
     int resault = 0;
     for (int i = 0; i < n_lines; i++) {
         for (int j = 0; j < m_collums; j++) {
             if (parent[i][j] != OUTSIDE) resault++;
         }
     }
     return resault;
 }

int main(int argc, char* argv[])
{
    //fast input
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    //open file
    ifstream inFile;    inFile.open(argv[1]);

    //vars i need

    inFile >> n_lines >> m_collums;
    string t;
    vector<vector<pair<int, int> > > parent(n_lines, vector<pair<int, int> >(m_collums, UNKNOWN));
    vector<string> mymaze;


    //take input
    for (int i = 0; i < n_lines; i++)   {
        inFile >> t;
        mymaze.push_back(t);
    }

    //1st order parents
    for (int i = 0; i < n_lines; i++)    {
        for (int j = 0; j < m_collums; j++)        {
            if (mymaze[i][j] == 'U')            {
                parent[i][j] = make_pair(i - 1, j);
                if (i - 1 < 0)
                    parent[i][j] = OUTSIDE;
            }
            else if (mymaze[i][j] == 'D')            {
                parent[i][j] = make_pair(i + 1, j);
                if (i + 1 >= n_lines)
                    parent[i][j] = OUTSIDE;
            }
            else if (mymaze[i][j] == 'L')            {
                parent[i][j] = make_pair(i, j - 1);
                if (j - 1 < 0)
                    parent[i][j] = OUTSIDE;
            }
            else if (mymaze[i][j] == 'R')            {
                parent[i][j] = make_pair(i, j + 1);
                if (j + 1 >= m_collums)
                    parent[i][j] = OUTSIDE;
            }
        }
    }


    for (int i = 0; i < n_lines; i++) {
        for (int j = 0; j < m_collums; j++) {
           if (parent[i][j]!=OUTSIDE &&parent[i][j]!=TRAPPED) find_route(parent, make_pair(i,j));
        }
    }

    cout << cout_out(parent) << endl;
    return 0;
}        