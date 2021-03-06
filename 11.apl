⍝ day 11: Dumbo Octopus

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      load←{↑{⍎¨,⍵}¨(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}
      pad←{¯1⊖¯1⌽(2+⍴⍵)↑⍵}
      unpad←{(¯2+⍴⍵)↑1⌽1⊖⍵}
      nb←{unpad⊃+/+⌿¯1 0 1∘.⊖¯1 0 1⌽¨⊂pad ⍵}
      ef←{(1-⍵)∧nb ⍵}

      total←0

∇r←step m;f;fd;n
 r←m+1 ⋄ fd←m∧0
 :While 0<n←+/+/f←9<r
     total←total+n  ⍝ ugly
     fd←fd∨f
     r←(1-fd)∧r+ef f
 :EndWhile
∇

∇r←steps m;dummy
 total←0
 dummy←(step⍣100)m
 r←total
∇

      steps load '11.test'
1656

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

∇r←sync m;i
 i←0
 :While 0<+/+/m
     m←step m
     i←i+1
 :EndWhile
 r←i
∇

      sync load '11.test'
195

⍝ ============================================================
⍝ guide
⍝ ============================================================

      fx←pad 5≠3 3⍴⍳9
      fx
0 0 0 0 0
0 1 1 1 0
0 1 0 1 0
0 1 1 1 0
0 0 0 0 0
      l←1+8×fx
      l
1 1 1 1 1
1 9 9 9 1
1 9 1 9 1
1 9 9 9 1
1 1 1 1 1
      step l
3 4 5 4 3
4 0 0 0 4
5 0 0 0 5
4 0 0 0 4
3 4 5 4 3
      step step l
4 5 6 5 4
5 1 1 1 5
6 1 1 1 6
5 1 1 1 5
4 5 6 5 4

      m←load '11.test'
      total←0
      step step m
8 8 0 7 4 7 6 5 5 5
5 0 8 9 0 8 7 0 5 4
8 5 9 7 8 8 9 6 0 8
8 4 8 5 7 6 9 6 0 0
8 7 0 0 9 0 8 8 0 0
6 6 0 0 0 8 8 9 8 9
6 8 0 0 0 0 5 9 4 3
0 0 0 0 0 0 7 4 5 6
9 0 0 0 0 0 0 8 7 6
8 7 0 0 0 0 6 8 4 8
      total
35

      steps load '11.test'
1656

⍝ On to part 2.

      sync load '11.test'
195

⍝ #
