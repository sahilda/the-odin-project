Object Oriented Programming Projects
================

All Project and Work from http://www.theodinproject.com/ruby-programming/oop
* Tic Tac Toe
Sample Output:
```
sagarwal@propellerheads:oop (master*)$ ruby tic_tac_toe.rb 
Enter player 1 name:
sahil
Enter player 2 name:
aakash
    |   | 
 ---+---+---
    |   | 
 ---+---+---
    |   | 
sahil, your turn.
Where would you like to go? Enter row and column number 1-3 as such: 'x,y' or even 'xy'.
22
    |   | 
 ---+---+---
    | x | 
 ---+---+---
    |   | 
aakash, your turn.
Where would you like to go? Enter row and column number 1-3 as such: 'x,y' or even 'xy'.
11
  o |   | 
 ---+---+---
    | x | 
 ---+---+---
    |   | 
sahil, your turn.
Where would you like to go? Enter row and column number 1-3 as such: 'x,y' or even 'xy'.
13
  o |   | x
 ---+---+---
    | x | 
 ---+---+---
    |   | 
aakash, your turn.
Where would you like to go? Enter row and column number 1-3 as such: 'x,y' or even 'xy'.
21
  o |   | x
 ---+---+---
  o | x | 
 ---+---+---
    |   | 
sahil, your turn.
Where would you like to go? Enter row and column number 1-3 as such: 'x,y' or even 'xy'.
31
  o |   | x
 ---+---+---
  o | x | 
 ---+---+---
  x |   | 
sahil wins!
Play again? (y/n)
n
Thanks for playing!
```

* Mastermind
Sample Output:
```
sagarwal@propellerheads:oop (master*)$ ruby mastermind.rb
MasterMind: Do you got it? 
============================
Legend: a '2' indicates a correction color and position, a '1' means a right color, and a '0' means incorrect color and position.
==========================
Do you want think you can HAL9000 - (g)uess or (m)ake code?
m
What's the code, smarty-pants? Enter 4: (R)ed, (G)reen, (Y)ellow, (B)lue, (M)agenta, and (C)yan.
cmrg
==========================
|#1| r,r,g,g || 2,1,0,0 ||
==========================
==========================
|#2| r,g,b,y || 1,1,0,0 ||
|#1| r,r,g,g || 2,1,0,0 ||
==========================
==========================
|#3| g,b,g,b || 1,0,0,0 ||
|#2| r,g,b,y || 1,1,0,0 ||
|#1| r,r,g,g || 2,1,0,0 ||
==========================
==========================
|#4| r,b,c,r || 1,1,0,0 ||
|#3| g,b,g,b || 1,0,0,0 ||
|#2| r,g,b,y || 1,1,0,0 ||
|#1| r,r,g,g || 2,1,0,0 ||
==========================
You win!

The answer was: c,m,r,g
```