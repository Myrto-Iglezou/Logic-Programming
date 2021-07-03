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

<p>A two-dimensional black-and-white image is scanned horizontally, vertically, and diagonally (during its descending and ascending diagonals) and is encoded based on the number of black pixels in each row, each column, each descending diagonal, and each ascending diagonal.</p>
<p>Define a decode/4 predicate, which accepts as arguments the numbers of black pixels for all rows, columns, descending and ascending diagonals of the image, to decode the image and print it. </p>
<p> For this task <b>diags.pl</b> was used. </p>

__Example:__

> ?- decode([1,1,10,11,10,1,1],[3,3,3,3,3,3,3,5,5,3,1], [0,0,1,2,3,3,3,4,3,4,3,3,2,4,0,0,0], [0,0,1,2,3,3,3,4,3,4,3,3,2,4,0,0,0]).
>. . . . . . . * . . .
>
>. . . . . . . . * . .
>
>* * * * * * * * * * .
>
>* * * * * * * * * * *
>
>* * * * * * * * * * .
>
>. . . . . . . . * . .
>
>. . . . . . . * . . .


### 5️⃣ games_csp.pl

<p> The same problem as games.pl (3rd task), but with the use of ic library.</p>

### 6️⃣ flights.pl

<p> An airline has planned to operate N flights, which can be referred to, by the codes 1, 2, 3,…, N. In addition, it has created M flight combinations(pairings) Pi (1<=i<=M). Each Pi includes some of the flights 1, 2, 3,…, N and also the Pi are not necessarily foreign to each other. These combinations are constructed in such a way that it is possible all the flights to take place with one of the available pilots of the company. The goal is to select some combinations that exactly cover the company's flights, in order to be assigned to specific pilots. Finally, if a combination of Pi flights has a cost (overnight expenses, off-site allowances, overtime pay, etc.) to the company Ci, the combinations to be selected must be the ones that cause the lowest total cost.</p> 

<p>The data needed for this task, are in the file <i>flight_data.pl</i>. Run in Prolog get_flight_data(I,N,P,C), giving an input serial number (1, 2,…) to I and taking the number of flights to N, a list of flight combinations to P and the cost list of these combinations to C.  </p>

<p>Define a flight/3 predicate, which when called as flights(I, Pairings, Cost), should, for the data set with serial number I, find the optimal solution to the problem. </p>

__Example:__

> ?- flights(1,Pairings,Cost).
>
> Pairings = [[1, 2, 3, 7] / 10, [5, 8] / 12, [4, 9, 10] / 34,  [6] / 34]
>
> Cost = 90

### 7️⃣ hcvrp.pl

<p> In this problem, there is a company, which is going to distribute certain quantities of the product it produces to specific customers. All the product is initially in the company's warehouse. A fleet of vehicles, possibly of different capacities, will be used to deliver orders to customers.</p>

<p> A snapshot of the problem for 8 vehicles and 20 customers is given below. The data of the problem are in the file hcvrp_data.pl.</p>

> vehicles ([35, 40, 55, 15, 45, 25, 85, 55]).
> 
> clients ([c (15, 77, 97), c (23, -28, 64), c (14, 77, -39),
 c (13, 32, 33), c (18, 32, 8), c (18, -42, 92),
 c (19, -8, -3), c (10, 7, 14), c (18, 82, -17),
 c (20, -48, -13), c (15, 53, 82), c (19, 39, -27),
 c (17, -48, -13), c (12, 53, 82), c (11, 39, -27),
 c (15, -48, -13), c (25, 53, 82), c (14, -39, 7),
 c (22, 17, 8), c (23, -38, -7)]).
 
 <p> The list given as an argument in the vehicles/1 category corresponds to the company's trucks. Each item on the list is the capacity of the corresponding truck, for the product produced by the company. The list in the clients/1 category represents the data of the company's customers. The items on the list are structures of form c (D, X, Y), each corresponding to a customer, where D is the quantity of the product ordered by the customer and X and Y are its coordinates.</p>
 
 <p>The goal is to distribute to each customer the quantity of the product he has ordered, with one shipment. Each truck, as long as it is used for distribution, will have to make a single route, undertaking to serve specific customers. It will start from the warehouse, having loaded a quantity of the product equal to the total orders of the customers it will serve, which should not exceed its capacity, it will visit the customers in a certain order, to deliver their orders to them, and will return to the warehouse. The warehouse is in position (0.0). Satisfaction of orders must be done in the best way for the company, which consists in minimizing the total distance that the trucks will travel. The warehouse and the customers are connected in pairs with streets that are straight lines. That is, as a distance between two customers, or the warehouse and a customer, their Euclidean distance is considered. </p>
 
<p>Define an hcvrp/6 predicate, which when called as hcvrp (NCl, NVe, Timeout, Solution, Cost, Time), solves the problem, taking as data the first NCl clients from the clients / 1 list and the first NVe vehicles from the list of vehicles / 1. The predicate returns to Solution a list of each item that corresponds to a truck and is also a list of the serial numbers of the customers that the truck will serve, and in the order in which it will visit them. Cost is the cost of the solution (total distance traveled by trucks). </p>

__Example:__

>?- hcvrp(1, 1, 0, Solution, Cost, Time).
>
> Found a solution with cost 247694
> 
> Solution = [[1]]
> 
> Cost = 247694
> 
> Time = 0.0
>
>
> ?- hcvrp(2, 1, 0, Solution, Cost, Time).
> Found no solution with cost 0.0 .. 371541.0
