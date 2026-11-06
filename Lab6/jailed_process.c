#include <stdio.h>
#include <dirent.h> 

#define GREEN "\x1B[32m"
#define RESET "\x1B[0m"

void ls(){
  printf("%sCurrent files and directories in /%s\n",GREEN,RESET);
  DIR *d;
  struct dirent *dir;
  d = opendir("/");
  if (d) {
    while ((dir = readdir(d)) != NULL) {
      printf("%s\n", dir->d_name);
    }
    closedir(d);
  }
}

void escape_sandbox(){
  /* TODO: Complete me! */ 
  
}

int main(){
  escape_sandbox();
  ls();
  return 0;
}

