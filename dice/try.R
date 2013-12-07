
try <- function()
  {
    status <- rep(TRUE, 6)
    status2 <- rep(TRUE, 6)
    js=0L
    while(any(status) & any(status2))
      {
        status[sample(6L, size=1L, replace=TRUE)]=FALSE
        status2[sample(6L, size=1L, replace=TRUE)]=FALSE
        js=js+1
      }
    js
  }

print(try())
