## Instructions
- a `ADD` - add value in buffer to mem[ptr] (buffer is unchanged)
- b `BACKWARDS` - decrement ptr
- c `CHAR` - output ascii value of mem[ptr]
    * calling **c** on a value > 255 will raise an error
- d `DOUBLE` - double the value in mem[ptr]
- e `ENDIF` - execution continues
- f `FORWARDS` - increment ptr
- g `GOTO` - set ptr to the value inside mem[ptr]
- h `HALF` - halve the value inside mem[ptr]
    * final value is floored
- i `IF` - execution continues forward if mem[ptr] is 0, else execution continues after matching **e**
- j `JUMP` - execution skips the next (mem[ptr] + 1) instructions
- k `KEY` - store value of current key pressed into mem[ptr]
- l `LOOP` - continue execution past the matching **u** if mem[ptr] is 0 (skip block), else execution continues forward
- m `MINUS` - substract 1 from mem[ptr]
- n `NUMBER` - output the number inside mem[ptr]
- o `ONE` - add 1 to mem[ptr]
- p `PUT` - put contents of buffer in mem[ptr]
- q `QUERY` - read one byte of input into mem[ptr]
- r `RANDOM` - mem[ptr] = random(0, buffer)
- s `SUBSTRACT` - remove value in buffer from mem[ptr] (buffer is unchanged)
- t `TIMES` - multiply mem[ptr] by buffer
- u `UNTIL` - execution continues forward if mem[ptr] is 0, else go back to matching **l**
- v `VIEW` - set mem[ptr] to the value of screen[buffer]
- w `WRAP` - set mem[ptr] to mem[ptr] % buffer
- x `PIXEL` - set screen[buffer] to the value of mem[ptr]
- y `YANK` - copy mem[ptr] into buffer
- z `ZERO` - set mem[ptr] to zero

## Specifications
### Cells
- number of cells is unbounded
- cell values are signed, unbounded

### Screen
- 64 * 64, 8 colors screen
- each pixel's value is unbounded, but rendered modulo 8

### Instructions
- calling <c> on a cell with value > 255 will output an error
- calling <x>, buffer value is taken modulo 4096 (wrap around)

## Other

### ASCII letters
```
97  98  99  100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122
a   b   c   d   e   f   g   h   i   j   k   l   m   n   o   p   q   r   s   t   u   v   w   x   y   z

65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90
A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R   S   T   U   V   W   X   Y   Z   
```

### Brainfuck transpilation
Gralphabet | Brainfuck 
:--------- | :---------
*o*        | *+*
*m*        | *-*
*f*        | *>*
*b*        | *<*
*c*        | *.*
*q*        | *,*
*l*        | *[*
*u*        | *]*


### "Hello world!" program:

direct transpilation from brainfuck:
```
++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.
```

to gralphabet:
```
oooooooolfoooolfoofooofooofobbbbmufofofmffolbubmuffcfmmmcoooooooccooocffcbmcbcooocmmmmmmcmmmmmmmmcffocfooc
```
