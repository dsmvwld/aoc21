⍝ day 4: Giant Squid

∇load fn;input
 input←(⎕UCS 10)(≠⊆⊢)⊃⎕NGET fn
 draws←⍎¨','(≠⊆⊢)⊃input
 cards←(((¯1+⍴input)÷5),5 5)⍴↑⍎¨1↓input
∇

      load AoCPath,'04.test'
      draws
7 4 9 5 11 17 23 2 0 14 21 24 10 16 13 6 15 25 12 22 18 20 8 19 3 26 1

      d←12↑draws
      h←∨⌿d∘.=cards  ⍝ hits
      +/h
3 4 4 1 0
2 3 2 3 2
5 1 1 2 3
      5∊+/h
1
      (+/(+/h)∊5)⍳1  ⍝ which card was hit?
3
      cards[3;;]
14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
      +/[2]h
1 2 3 2 4
2 2 2 3 3
2 3 2 2 3
      +/+/cards[3;;] ∧ (1-(∨⌿d∘.=cards)[3;;])
188
      (¯1↑d)×+/+/cards[3;;] ∧ (1-(∨⌿d∘.=cards)[3;;])
4512

∇r←cscore;n;d;h;c
 n←1
 :While 1
     d←n↑draws
     h←∨⌿d∘.=cards
     :If 5∊+/h
     :OrIf 5∊+/[2]h
         c←(+/(+/h)∊5)⍳1
         :Leave
     :Else
         n←n+1
     :EndIf
 :EndWhile
 r←(¯1↑d)×+/+/cards[c;;]∧1-h[c;;]
∇

      cscore
4512

⍝ part 2:

∇r←lscore;n;d;h;c;m
 n←1
 :While 1
     d←n↑draws
     h←∨⌿d∘.=cards
     m←(+/(+/h)∊5)∨+/(+/[2]h)∊5
     :If 0∊m
         c←m⍳0
         n←n+1
     :Else
         :Leave
     :EndIf
 :EndWhile
 r←(¯1↑d)×+/+/cards[c;;]∧1-h[c;;]
∇

      lscore
1924
