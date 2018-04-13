% Peter Gifford
% CSCI 305 Prolog Lab 2
mother(M,C):- parent(M,C), female(M).
father(F,C):- parent(F,C), male(F).
spouse(M,C):- married(C,M)
| married(M,C).

% children rules
child(C,P):- parent(P,C).
son(S,P):- parent(P,S), male(S).
daughter(D,P):- parent(P,D), female(D).

% sibling rules
% these only need mother or father because they are all male female pairs with no divorce
sibling(S,P):- mother(X,P), child(S,X), S \= P. % deal with repeated name
brother(S,P):- mother(X,P), child(S,X), S \= P, male(S).
sister(S,P):- mother(X,P), child(S,X), S \= P, female(S).

% uncle and aunt, also by blood means that they were a spouse then their spouses uncles
uncle(U,P):- parent(X,P),brother(U,X)
| spouse(Y,P),parent(Z,Y),brother(U,Z).
aunt(A,P):- parent(X,P),sister(A,X)
| spouse(Y,P),parent(Z,Y),sister(A,Z).

% double generation seperation commands
grandparent(G,P):- parent(X,P),parent(G,X).
grandfather(G,P):- parent(X,P),parent(G,X),male(G).
grandmother(G,P):- parent(X,P),parent(G,X),female(G).
grandchild(C,P):- child(X,P), child(C,X).

% recursive call to move all the way up the tree.
ancestor(X,Y):- parent(X,Y). % base case
ancestor(X,Y):- parent(Z,Y),ancestor(X,Z).

% same recursive style as above but using children
% X is descendant of Y
descendant(X,Y):- child(X,Y). % base case
descendant(X,Y):- child(Z,Y),descendant(X,Z).

% age based rules
older(X,Y):- born(X,A),born(Y,B), A<B.
younger(X,Y):-born(X,A),born(Y,B), A>B.

% regent when born method
% who X was ruling when Y was born
regentWhenBorn(X,N):- born(N,Y), reigned(X,B,C), Y > B, Y < C.

% cousins extra credit commands
% Merriam-Webster Cousin Definition: a child of ones uncle or aunt.
cousin(X,Y):- uncle(U,Y), child(X,U)
|aunt(A,Y), child(X,A).
