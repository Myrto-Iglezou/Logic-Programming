% Logic Programming
% Second exercise

% Iglezou Myrto - 1115201700038



%%%%%%%%%%%% Multiplication of two matrices %%%%%%%%%%%%%

del_first([], [], []).
del_first([[X|L]|R], [X|RX], [L|RL]) :-
   del_first(R, RX, RL).

empty_lists([]).
empty_lists([[]|M]) :-
   empty_lists(M).

matr_transp(M, []) :-
   empty_lists(M).
matr_transp(M, [C|TM]) :-
   del_first(M, C, RM),
   matr_transp(RM, TM).

matr_mult(M1, M2, M3) :-
   matr_transp(M2, RM2),
   matr_transp_mult(M1, RM2, M3).

matr_transp_mult([], _, []).
matr_transp_mult([R1|M1], M2, [R3|M3]) :-
   matr_transp_mult1(R1, M2, R3),
   matr_transp_mult(M1, M2, M3).

matr_transp_mult1(_, [], []).
matr_transp_mult1(R1, [R2|M2], [X|R3]) :-
   inn_prod(R1, R2, X),
   matr_transp_mult1(R1, M2, R3).


inn_prod([], [], 0).
inn_prod([X1|R1], [X2|R2], IP1) :-
   inn_prod(R1, R2, IP2),
   IP1 is IP2 + X1 * X2.

%%%%%%%%%%%% Add & Sub  %%%%%%%%%%%%%

add_rows([],[],[]).
add_rows([H|L],[S|E],[F|N]):-
	F is H+S,
	add_rows(L,E,N). 

sub_rows([],[],[]).
sub_rows([H|L],[S|E],[F|N]):-
	F is H-S,
	sub_rows(L,E,N). 

m_add([],[],[]).
m_add([M1H|M1T],[M2H|M2T],[M3H|M3T]):-
	add_rows(M1H,M2H,M3H),
	m_add(M1T,M2T,M3T).

m_sub([],[],[]).
m_sub([M1H|M1T],[M2H|M2T],[M3H|M3T]):-
	sub_rows(M1H,M2H,M3H),
	m_sub(M1T,M2T,M3T).


%%%%%%%%%%%% Multiplication %%%%%%%%%%%%%

mul_n_m(_,[],[]).				% Multiplication of number and matrix
mul_n_m(N,[H|T],[S|E]):-
	mul_n_line(N,H,S),
	mul_n_m(N,T,E).

mul_n_line(_,[],[]).			% Multiplication of number and list
mul_n_line(N,[H|T],[S|E]):-
	S is N*H,
	mul_n_line(N,T,E).

mul_vectors(V,MV):-				% Multiplication of a vector and its transp vector
	 matr_transp(V,Vtransp),
	 matr_mult(Vtransp,V,MV).


%%%%%%%%%%%% Vectors %%%%%%%%%%%%%

v_list([],[]).								% list of the results of vector multiplication (Y x Y^T)
v_list([Item1|Tail],[Start|End]):-
	mul_vectors([Item1],Start),
	v_list(Tail,End).
	
v_sum([Item],Item).						% culculate the sum of that list 
v_sum([Item1,Item2|Tail],Total):-
	m_add(Item1,Item2,Sum),
	v_sum([Sum|Tail],Total).


%%%%%%%%%%%% Create a Matrix of zeroes %%%%%%%%%%%%%

make_matrix(M, N, Matrix) :-
   length(Matrix, M),
   make_lines(N, Matrix).

make_lines(_, []).
make_lines(N, [NLine|Matrix]) :-
   length(Line, N),
   zeroes(Line,NLine),
   make_lines(N, Matrix).

make_square_matrix(N, Matrix) :-
   make_matrix(N, N, Matrix).

zeroes([],[]).					% create a line of 0
zeroes([_|T],[0|E]):-
	zeroes(T,E).


%%%%%%%%%%%% Identity Matrix %%%%%%%%%%%%%

make_I_matrix(N,Matrix):-
	make_square_matrix(N,ZeroMatrix),		% make a NxN array of 0
	identity(N,ZeroMatrix,IdentityMatrix),	% set 1 to every row in the same position as the number of the row
	reverse(IdentityMatrix,Matrix).			% reverse the matrix, because we start from the last row (bottom -> up)

identity(0,[],[]).
identity(N,[H|T],[S|E]):-
	N>0,
	set_ith(N,H,S),
	X is N-1,
	identity(X,T,E).

set_ith(1,[_|T],[1|T]).			% set 1 in certain position of a list
set_ith(I,[H|L],[H|R]):-
	I>0,
	I1 is I-1,
	set_ith(I1,L,R).

%%%%%%%%%%%% Final predicate  %%%%%%%%%%%%%

matrix_lenght([H|T],R,C):-
	length([H|T],R),
	length(H,C).

hopfield(Matrix,Weights):-
	v_list(Matrix,Vect_list),		% make a list of the results of vector multiplication (Y x Y^T)
	v_sum(Vect_list,Sum),				% culculate the sum of that list
	matrix_lenght(Matrix,Rows,Columns),		% count the number of rows and columns of the Matrix
	make_I_matrix(Columns,I_Matrix),		% make an identity matrix CxC, where C is the number of neurons
	mul_n_m(Rows,I_Matrix,New_Matrix),		% multiply the identity matrix with R, where R  is the number of vectors
	m_sub(Sum,New_Matrix,Weights).			% make the final subtraction



