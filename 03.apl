⍝ day 3

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      load←{↑{⍎¨(⍳⍴⍵)⊆⍵}¨(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}
      ×/2⊥¨{(1-⍵) ⍵}{(+⌿⍵)>(1↑⍴⍵)÷2} load'03.test' 
198

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

      dom←{(0.5×1↑⍴⍺)≤+/⍺[;⍵]}

∇r←f narrow m;c
 c←1
 :While 1<1↑⍴m
     m←(m[;c]=f=m dom c)⌿m
     c←c+1
 :EndWhile
 r←2⊥m[1;]
∇

      {(0 narrow ⍵)×1 narrow ⍵} load '03.test'
230

⍝ ============================================================
⍝ guide
⍝ ============================================================

      m←load '03.test'
      m
0 0 1 0 0
1 1 1 1 0
1 0 1 1 0
1 0 1 1 1
1 0 1 0 1
0 1 1 1 1
0 0 1 1 1
1 1 1 0 0
1 0 0 0 0
1 1 0 0 1
0 0 0 1 0
0 1 0 1 0

      (+⌿m)>(1↑⍴m)÷2
1 0 1 1 0
      2⊥(+⌿m)>(1↑⍴m)÷2
22

      1-(+⌿m)>(1↑⍴m)÷2
0 1 0 0 1
      2⊥1-(+⌿m)>(1↑⍴m)÷2
9

      {(2⊥1-⍵)×2⊥⍵}{(+⌿⍵)>(1↑⍴⍵)÷2}m
198

⍝ Written in a more "functional" way:

      ×/2⊥¨{(1-⍵) ⍵}{(+⌿⍵)>(1↑⍴⍵)÷2}m
198

⍝ Onwards to part 2. First we'll write a function that will
⍝ give us the "dominant" value in a given column, given a
⍝ binary matrix and a column index. (Note the use of ≤ here.)

      dom←{(0.5×1↑⍴⍺)≤+/⍺[;⍵]}

      m
0 0 1 0 0
1 1 1 1 0
1 0 1 1 0
1 0 1 1 1
1 0 1 0 1
0 1 1 1 1
0 0 1 1 1
1 1 1 0 0
1 0 0 0 0
1 1 0 0 1
0 0 0 1 0
0 1 0 1 0
      m dom 1
1

⍝ Narrowing the matrix down to that dominant value then becomes 
⍝ one step in an ongoing loop.

      (m[;1]=m dom 1)⌿m
1 1 1 1 0
1 0 1 1 0
1 0 1 1 1
1 0 1 0 1
1 1 1 0 0
1 0 0 0 0
1 1 0 0 1

      1 narrow m
23
      0 narrow m
10
      {(0 narrow ⍵)×1 narrow ⍵}m
230

⍝ #
