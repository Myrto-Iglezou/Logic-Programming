# Problems solved with prolog

### 1️⃣ diags.pl

<p>Implement a diags(Matrix, DiagsDown, DiagsUp) statement, which takes as its argument a Matrix table, in the form of a list of lists (internal lists are the rows of the table), and returns to DiagsDown and DiagsUp the lists of elements of the descending and ascending diagonals of the table, respectively, in order of their elements, from top to bottom.</p> 

__Example:__

> ?- diags([[a,b,c,d],[e,f,g,h],[i,j,k,l]],DiagsDown,DiagsUp). 
> 
> DiagsDown = [[i],[e,j],[a,f,k],[b,g,l],[c,h],[d]] 
> 
> DiagsUp = [[a],[b,e],[c,f,i],[d,g,j],[h,k],[l]] 

### 2️⃣ hopfield.pl 

<p> This task refers to <a href="https://en.wikipedia.org/wiki/Hopfield_network">Hopfield network</a>. The hopfield/2 predicate, takes a list of vectors to be stored in a Hopfield grid, where each vector is also a list of its elements. It returns the grid weight table to the second argument.</p> 

__Example:__

> ?- hopfield([[+1,-1,-1,+1], [-1,-1,+1,-1], [+1,+1,+1,+1]],W).
> 
> W = [[0,1,-1,3],[1,0,1,1],[-1,1,0,-1],[3,1,-1,0]]

### 3️⃣ games.pl

<p>Consider that in a place of entertainment there are specific electronic games, in which you can play in a given order. You can play each game more than once, but they will all be consecutive. In order to play a game once, you have to pay a chip. Your available chips are in a box, which has a capacity of <b>T</b> chips, which is initially full.After completing all the times of playing one game, and before starting the next, you are given a gift of <b>K</b> chips, or less, and in any case, no more than can fit in your box. Every time you play game i, your pleasure is Pi. The pleasure of a game can be negative, which means that you did not like the game, or zero, which means that your game is indifferent.</p>
<p>Define a games/5 predicate, which, when called as games(Ps, T, K, Gs, P), with Ps a list of game pleasures (with length same as the number of games), returns to Gs the list of times each game must be played to get maximum pleasure, and to P this maximum pleasure. If there is more than one optimal solution with the same maximum pleasure, the predicate returns them all by reversing.</p>
<p> This is a contraint problem, but it should not be solved with the constraint libray.

__Example:__

> ?- games([4,1,2,3],5,2,Gs,P).
> 
> Gs = [5,1,1,4]
>
> P = 35 --> ;
>
> no
  
### 4️⃣ decode.pl
### 5️⃣ games_csp.pl
### 6️⃣ flights.pl
### 7️⃣ hcvrp.pl
