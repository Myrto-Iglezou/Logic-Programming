# Problems solved with prolog

### 1️⃣ diags.pl

Implement a diags(Matrix, DiagsDown, DiagsUp) statement, which takes as its argument a Matrix table, in the form of a list of lists (internal lists are the rows of the table), and returns to DiagsDown and DiagsUp the lists of elements of the descending and ascending diagonals of the table, respectively, in order of their elements from top to bottom. Example:

?- diags([[a,b,c,d],[e,f,g,h],[i,j,k,l]],DiagsDown,DiagsUp).
DiagsDown = [[i],[e,j],[a,f,k],[b,g,l],[c,h],[d]]
DiagsUp = [[a],[b,e],[c,f,i],[d,g,j],[h,k],[l]]

$$
  \begin{matrix}
   1 & 2 & 3 \\
   4 & 5 & 6 \\
   7 & 8 & 9
  \end{matrix} \tag{1}
$$



### 2️⃣ hopfield.pl 
### 3️⃣ games.pl
### 4️⃣ decode.pl
### 5️⃣ games_csp.pl
### 6️⃣ flights.pl
### 7️⃣ hcvrp.pl
