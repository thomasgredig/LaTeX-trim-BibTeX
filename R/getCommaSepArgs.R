# comma separated string
getCommaSepArgs <- function(a1) {
  # Example:
  # s = "  ggsave(paste(SAMPLE.NAME,'-5K.png', sep=''), width=6, height=4, dpi=300)"
  # a1 = gsub('.*ggsave\\((.*)\\)','\\1',s)
  n=0
  n.first=1
  no.brackets=0
  n1=NULL
  for(stabe in strsplit(a1, "")[[1]] ) {
    n=n+1
    if ((stabe==',') & (no.brackets==0)) { 
      n1=c(n1, substr(a1,n.first,n-1))
      n.first = n+1
    }
    if (stabe=='(') { no.brackets = no.brackets + 1}
    if (stabe==')') { no.brackets = no.brackets - 1}
  }
  n1
}