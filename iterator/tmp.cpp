//#include <Rcpp.h>
#include <iterator>
#include <cmath>
#include <iostream>
#include <algorithm>

class MySumIter : 
    public std::iterator<std::random_access_iterator_tag, long long>
{
   public:
   MySumIter():m_index(0),ifneedcmp(true)
   {}

   long long operator* ()
   {
     if(ifneedcmp)
     {
        long long n2=m_index*m_index;
        long long n3=n2*m_index;
        long long n4=n3*m_index;
        m_ret = (n4+2*n3+n2)/4;
        ifneedcmp=false;
     }
     return m_ret;
   }

   MySumIter& operator++ ()
   {
     ifneedcmp=true;
     m_index++;
     return *this;
   }

   MySumIter& operator++ (int)
   {
     ifneedcmp=true;
     m_index++;
     return *this;
   }

   bool operator!= (const MySumIter& me)
   {
     return m_index != me.m_index;
   }


   MySumIter& operator+= (long long ind)
   {
      ifneedcmp=true;
      m_index+=ind;
      return *this;
   }

   friend long long operator- (const MySumIter& me, const MySumIter& me2);
   friend MySumIter operator+ (const MySumIter& me, long long me2);
   
   inline long long get_index() const
   {
      return m_index;
   } 

   protected:
     long long m_index;
     long long m_ret;
     bool ifneedcmp;

};

long long operator- (const MySumIter& me, const MySumIter& me2)
{
  return me.m_index - me2.m_index;
}

MySumIter operator+ (const MySumIter& me, long long me2)
{
  MySumIter myiter;
  myiter.m_index = me.m_index + me2;
  return myiter;
}


// [[Rcpp::export]]
int mytest(long long t)
{
  using namespace std;
  MySumIter a;
  MySumIter ret = lower_bound(a, a+(long long)(pow(t,0.25)*4), t);

  return *ret == t ? ret.get_index() : -1;
}

int main()
{
   using namespace std;
   cout << mytest(15687562500ll) << endl;
   return 0;
}
