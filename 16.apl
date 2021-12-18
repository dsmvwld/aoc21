⍝ day 16: Packet Decoder

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      htob←{,⍉2 2 2 2⊤¯1+(⎕D,⎕A)⍳⍵}
      load←{htob⊃(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}

∇r←consume n
 r←n↑feed
 feed←n↓feed
∇

∇r←parse;ver;type;lit;bits;n
 ver←2⊥consume 3
 r←ver,type←2⊥consume 3
 :If type=4 ⍝ literal:
     lit←⍬
     :Repeat
         bits←consume 5
         lit,←1↓bits
     :Until 0=1↑bits
     r,←⊂2⊥lit
 :Else ⍝ operator:
     :If 0=consume 1
         r,←parsebits 2⊥consume 15
     :Else
         r,←parsepkts 2⊥consume 11
     :EndIf
 :EndIf
∇

∇r←parsebits n;eop
 r←⍬
 eop←(⍴feed)-n
 :While eop<⍴feed
     r,←⊂parse
 :EndWhile
∇

∇r←parsepkts n;i
 r←⍬
 :For i :In ⍳n
     r,←⊂parse
 :EndFor
∇

∇r←vsum pkt;type
 (r type)←2↑pkt
 :If type≠4
     {r+←vsum ⍵}¨2↓pkt
 :EndIf
∇

      feed←load '16.ex4' ⋄ vsum parse
16
      feed←load '16.ex5' ⋄ vsum parse
12
      feed←load '16.ex6' ⋄ vsum parse
23
      feed←load '16.ex7' ⋄ vsum parse
31

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

∇r←eval pkt
 :Select 2⊃pkt
 :Case 0
     r←+/eval¨2↓pkt
 :Case 1
     r←×/eval¨2↓pkt
 :Case 2
     r←⌊/eval¨2↓pkt
 :Case 3
     r←⌈/eval¨2↓pkt
 :Case 4
     r←3⊃pkt
 :Case 5
     r←>/eval¨2↓pkt
 :Case 6
     r←</eval¨2↓pkt
 :Case 7
     r←=/eval¨2↓pkt
 :EndSelect
∇

      ⎕PP←17
      feed←load '16.ex8' ⋄ eval parse
3
      feed←load '16.ex9' ⋄ eval parse
54
      feed←load '16.ex10' ⋄ eval parse
7
      feed←load '16.ex11' ⋄ eval parse
9
      feed←load '16.ex12' ⋄ eval parse
1
      feed←load '16.ex13' ⋄ eval parse
0
      feed←load '16.ex14' ⋄ eval parse
0
      feed←load '16.ex15' ⋄ eval parse
1

⍝ ============================================================
⍝ guide
⍝ ============================================================

      ¯1+(⎕D,⎕A)⍳'D2FE28'
13 2 15 14 2 8

      ⍉2 2 2 2⊤¯1+(⎕D,⎕A)⍳'D2FE28'
1 1 0 1
0 0 1 0
1 1 1 1
1 1 1 0
0 0 1 0
1 0 0 0

      ,⍉2 2 2 2⊤¯1+(⎕D,⎕A)⍳'D2FE28'
1 1 0 1 0 0 1 0 1 1 1 1 1 1 1 0 0 0 1 0 1 0 0 0

      feed←load '16.ex1' ⋄ parse
6 4 2021
      feed←load '16.ex2' ⋄ DISPLAY parse
┌→──────────────────────┐
│     ┌→─────┐ ┌→─────┐ │
│ 1 6 │6 4 10│ │2 4 20│ │
│     └~─────┘ └~─────┘ │
└∊──────────────────────┘
      feed←load '16.ex3' ⋄ DISPLAY parse
┌→────────────────────────────┐
│     ┌→────┐ ┌→────┐ ┌→────┐ │
│ 7 3 │2 4 1│ │4 4 2│ │1 4 3│ │
│     └~────┘ └~────┘ └~────┘ │
└∊────────────────────────────┘

⍝ TODO
