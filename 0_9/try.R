library(compiler)
enableJIT(3);
myfun <- function(){
  myend=10L;
  while(TRUE)
    {
      myend=sample(myend-1L, size=1L);
      if(myend==2L || myend==1L)
        break;
    }
  return(myend-1);
}

total=1000000;
print(sum(replicate(total, myfun()))/total);
