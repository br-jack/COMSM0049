gcc -g -z execstack -fno-stack-protector stack.c -o stack
cp stack stack-root
sudo chown root stack-root
sudo chmod 4755 stack-root
