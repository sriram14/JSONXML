This tool can be used to convert JSON to XML. 

Software needed:

1. Flex/lex
2. Yacc/bison
3. gcc

Steps:

Execute the following commands in your terminal.

1. lex xm.l
2. bison xm.y
3. gcc xm.tab.c
4. ./a.out < input_file.json > output_file.xml