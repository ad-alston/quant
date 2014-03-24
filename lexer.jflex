/**
 * Lexical analyzer definition for Quant
 * using JFlex (--Aubrey)
 */

import java_cup.runtime.*;

%%

/* OPTION %cupsym 'name' to name the generated CUP class
 */

/* OPTION %cupdebug to get symbol names printed with line, column
 * and matched text for input files
 */

%cup
%char               /* turn on character counting now, for debugging */
%line
%column
%unicode
%debug              /* turn on debugging for now */
%class QuantLexer
%{

/*
 Methods to return symbols, along with position (line, column)
 and value (where appropriate). (--Aubrey)
 */

 /**
  * Return a vanilla symbol (token ID only).
  */
 Symbol getSymbol(int tokenID){
     return new Symbol(tokenID, yyline, yycolumn);
 }
 Symbol getSymbol(int tokenID, Object value){
     return new Symbol(tokenID, yyline, yycolumn, value);
 }

%}

/**
 * Pattern definitions (--Aubrey)
 */
letter        = [A-Za-z]
digit         = [0-9]
alphanumeric  = {letter}|{digit}
identifier    = {letter}+
integer       = {digit}+
period        = \.
plus          = plus | \+
minus         = minus | \-
times         = times | \*
divide        = over | \/
print         = print | Print
whitespace    = [ \n\t]

%%
/**
 * Lexical rules (--Aubrey)
 */

is              { return getSymbol(sym.IS); }
{print}         { return getSymbol(sym.PRINT); }
{period}        { return getSymbol(sym.PERIOD); }
{plus}          { return getSymbol(sym.PLUS); }
{minus}         { return getSymbol(sym.MINUS); }
{times}         { return getSymbol(sym.TIMES); }
{divide}        { return getSymbol(sym.OVER); }
{integer}       { return getSymbol(sym.INTEGER, new Integer(Integer.parseInt(yytext()))); }
{identifier}    { return getSymbol(sym.VARIABLE, yytext()); }
{whitespace}    { /* Ignore. */ }
.               { return getSymbol(sym.INVALID); }
