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
%line
%column
%unicode              /* turn on debugging for now */
%class QuantLexer
%{

/*
 Methods to return symbols, along with position (line, column)
 and value (where appropriate). (--Aubrey)
 */

 /**
  * Return a vanilla symbol (token ID only).
  */
 public Symbol getSymbol(int tokenID){
     return new Symbol(tokenID, yyline, yycolumn);
 }
 public Symbol getSymbol(int tokenID, Object value){
     return new Symbol(tokenID, yyline, yycolumn, value);
 }

%}

/**
 * Pattern definitions (--Aubrey)
 */

string		= \"[^\"]*\"
integer		= ( [\-])?[0-9]+
rat_num		= ( [\-])?[0-9]+\.[0-9]+

plus		= (\+|Plus|plus)
minus		= (\-|Minus|minus)
times		= (\*|Times|times)
divide		= (\\|divided by|over)
and		= (\&\&|and)
or		= (\|\||or)

connector	= (\,|now)
semicolon	= (\;)
colon		= (\:)
period		= \.
lparen		= \(
rparen		= \)
apo_s		=\'s

a		= (a)
is_a		= (is a )
is		= (is |are )
if		= (if |If )
then		= (then|Then)
else		= (else|Else)
while		= (while|While)
print		= (print |Print )
set		= (Set |set )
to		= ( to )
than		= (than)
less_than	= (\<|less )
greater_than	= (\>|greater|more )
equal_to	= (\=|equals |equal )
nequal_to	= (\!\=)
not		= (not)
there		= (there|There)
in		= (in)
for		= (for)
every 		= (every)
has		= (has)
having		= (having)
with		= (with)

whitespace	= [ \n\t]

identifier	= [A-Za-z]+

%%
/**
 * Lexical rules (--Aubrey)
 */
{integer}	{ return getSymbol(sym.INTEGER_LITERAL, new Integer(yytext())); }
{rat_num}	{ return getSymbol(sym.RATIONAL_LITERAL, new Double(yytext())); }
{plus}		{ return getSymbol(sym.PLUS); }
{minus}		{ return getSymbol(sym.MINUS); }
{times}		{ return getSymbol(sym.TIMES); }
{divide}	{ return getSymbol(sym.DIVIDE); }
{if}		{ return getSymbol(sym.IF); }
{then}		{ return getSymbol(sym.THEN); }
{else}		{ return getSymbol(sym.ELSE); }
{while}		{ return getSymbol(sym.WHILE); }
{less_than}	{ return getSymbol(sym.LESS_THAN); }
{greater_than}	{ return getSymbol(sym.GREATER_THAN); }
{equal_to}	{ return getSymbol(sym.EQUAL_TO); }
{nequal_to}	{ return getSymbol(sym.NEQUAL_TO); }
{string}	{ return getSymbol(sym.STRING_LITERAL, yytext()); }
{print}		{ return getSymbol(sym.PRINT); }
{a}		{ return getSymbol(sym.A); }
{is}		{ return getSymbol(sym.IS); }
{is_a}		{ return getSymbol(sym.IS_A); }
{set}		{ return getSymbol(sym.SET); }
{to}		{ return getSymbol(sym.TO); }
{than}		{ return getSymbol(sym.THAN); }
{there}		{ return getSymbol(sym.THERE); }
{has}		{ return getSymbol(sym.HAS); }
{having}	{ return getSymbol(sym.HAVING); }
{with}		{ return getSymbol(sym.WITH); }
{not}		{ return getSymbol(sym.NOT); }
{lparen}	{ return getSymbol(sym.LPAREN); }
{rparen}	{ return getSymbol(sym.RPAREN); }
{apo_s}		{ return getSymbol(sym.APO_S); }
{connector}	{ return getSymbol(sym.CONNECTOR); }
{semicolon}	{ return getSymbol(sym.SEMICOLON); }
{colon}		{ return getSymbol(sym.COLON); }
{and}		{ return getSymbol(sym.AND); }
{or}		{ return getSymbol(sym.OR); }
{in}		{ return getSymbol(sym.IN); }
{for}		{ return getSymbol(sym.FOR); }
{every}		{ return getSymbol(sym.EVERY); }
{period}	{ return getSymbol(sym.PERIOD); }
{whitespace}    { /* Ignore. */ }
{identifier}	{ // Will need to add symbol table management.
		  return getSymbol(sym.IDENTIFIER, yytext());
		}
.               { return getSymbol(sym.INVALID); }
