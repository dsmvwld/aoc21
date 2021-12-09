⍝ day 9

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      load←{↑{⍎¨,⍵}¨(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}

      pad←{(9,[1]9,⍵,9),[1]9}
      unpad←{(¯2+⍴⍵)↑1⌽1⊖⍵}

      nbm←{p←⊂pad ⍵ ⋄ unpad⊃(⌊/¯1 1⊖¨p)⌊⌊/¯1 1⌽¨p}
      {f←⍵<nbm ⍵ ⋄ +/+/f+f×⍵} load '09.test'
15

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

      nbi←{p←(4 2⍴¯1 0 0 1 1 0 0 ¯1)+4 2⍴⍵ ⋄ ((∧/p≤4 2⍴⍺)∧∧/0≠p)⌿p}

∇r←m basin p;p1
 r←m
 :If 0=p⌷r
     (p⌷r)←1
     :For p1 :In ↓(⍴r)nbi p
         :If 0=p1⌷r
             r←r∨r basin p1
         :EndIf
     :EndFor
 :EndIf
∇
      ig←{i←¯1+(1=,⍵)/⍳×/⍴⍵ ⋄ ⍉1+(⍴⍵)⊤i}
 
∇r←basizes m;lows
 lows←ig m<nbm m
 r←{+/+/1=({9∧9=⍵}m) basin ⍵}¨↓lows
∇

      ×/3↑{⍵[⍒⍵]}basizes load '09.test'
1134

⍝ ============================================================
⍝ guide
⍝ ============================================================

⍝ The load function simply loads the given file as a matrix of
⍝ single-digit numbers.

      m←load '09.test'
      m
2 1 9 9 9 4 3 2 1 0
3 9 8 7 8 9 4 9 2 1
9 8 5 6 7 8 9 8 9 2
8 7 6 7 8 9 6 7 8 9
9 8 9 9 9 6 5 6 7 8

⍝ The pad function wraps a given matrix with 9s around the four
⍝ edges, and unpad unsurprisingly removes such a wrapping. This
⍝ process is used for computing "surroundings" such as the
⍝ lowest neighbourhood value computation in the nbm function.

      pad 2 3⍴⍳6
9 9 9 9 9
9 1 2 3 9
9 4 5 6 9
9 9 9 9 9
      unpad pad 2 3⍴⍳6
1 2 3
4 5 6

⍝ The nbm function gathers, for each position in a matrix, the
⍝ lowest value of any of its adjacent four fields. Due to the
⍝ padding with 9s, the locations at the matrix border are not
⍝ encumbered by toroidal "wraparound."

      nbm m
1 2 1 7 4 3 2 1 0 1
2 1 5 6 7 4 3 2 1 0
3 5 6 5 6 7 4 7 2 1
7 6 5 6 7 6 5 6 7 2
8 7 6 7 6 5 6 5 6 7

⍝ The question that part 1 of the puzzle asks is the sum of the
⍝ risk levels. First, a binary matrix indicates the found low
⍝ points, i.e. where a value is actually less than their neigh-
⍝ bourhood minimum.

      {⍵<nbm ⍵}m
0 1 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 1 0 0 0

⍝ From there, the total risk value is derived easily.

      {f←⍵<nbm ⍵ ⋄ +/+/f+f×⍵}m
15

⍝ On to part 2, where we'll implement a flood-fill algorithm. 
⍝ [This may not be clear at first, see note in appendix.]
⍝ 
⍝ Two helper functions pave the way: nbi, when given a matrix
⍝ shape and a coordinate, will return the indices of the
⍝ adjacent neighbours.
⍝ So, in the middle of our test matrix, it will return four
⍝ pairs of values, at the matrix edge only three, and at the
⍝ matrix corners only two.

      (⍴m) nbi 3 3
2 3
3 4
4 3
3 2
      (⍴m) nbi 1 3
1 4
2 3
1 2
      (⍴m) nbi 1 10
2 10
1  9

⍝ The other helper function is the index generator ig. When
⍝ given a boolean matrix, it will return the indices of the
⍝ true values. (We will use it to convert the found "low point"
⍝ flags to usable indices for flood filling.)
⍝ A silly example:

      m=2
1 0 0 0 0 0 0 1 0 0
0 0 0 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
      ig m=2
1  1
1  8
2  9
3 10

⍝ With these in hand, we construct a recursive flood filler.
⍝ It will initially be given a "blank" matrix of 9s and 0s,
⍝ derived from the actual matrix, and a starting coordinate pair.
⍝ 
⍝ The flood filler function (basin) works by checking whether
⍝ the given position is yet-unvisited, and if so, marking it as
⍝ such and recursing into other connected, unvisited neighbour
⍝ locations. It then returns the updated visitation-flag matrix.
⍝ 
⍝ The four example basins from the puzzle text; from there, the
⍝ actual filled areas (1s) are easily extracted.

      ({9∧9=⍵}m) basin 1 2
1 1 9 9 9 0 0 0 0 0
1 9 0 0 0 9 0 9 0 0
9 0 0 0 0 0 9 0 9 0
0 0 0 0 0 9 0 0 0 9
9 0 9 9 9 0 0 0 0 0
      ({9∧9=⍵}m) basin 1 10
0 0 9 9 9 1 1 1 1 1
0 9 0 0 0 9 1 9 1 1
9 0 0 0 0 0 9 0 9 1
0 0 0 0 0 9 0 0 0 9
9 0 9 9 9 0 0 0 0 0
      ({9∧9=⍵}m) basin 3 3
0 0 9 9 9 0 0 0 0 0
0 9 1 1 1 9 0 9 0 0
9 1 1 1 1 1 9 0 9 0
1 1 1 1 1 9 0 0 0 9
9 1 9 9 9 0 0 0 0 0
      ({9∧9=⍵}m) basin 5 7
0 0 9 9 9 0 0 0 0 0
0 9 0 0 0 9 0 9 0 0
9 0 0 0 0 0 9 1 9 0
0 0 0 0 0 9 1 1 1 9
9 0 9 9 9 1 1 1 1 1

⍝ That extraction is exactly what the basizes function does. It is
⍝ given a matrix of depth-level data, and returns an (unordered)
⍝ vector of sizes.

      basizes m
3 9 14 9

⍝ By now, you may already recognize the next step and read it from
⍝ left to right as "the multiplication of the first three basin 
⍝ sizes when sorted downwards." 
⍝ 

      ×/3↑{⍵[⍒⍵]} basizes m
1134

⍝ # 

⍝ ============================================================
⍝ appendix
⍝ ============================================================

⍝ The puzzle text might lead you astray, as its four basin examples
⍝ can be interpreted as requiring an incremental, successively
⍝ increasing path from the low point. (I.e. from a low point of
⍝ 5 to any directly connected 6, from there to any connected 7,
⍝ etc.) If we implemented the algorithm in that way, the proposed
⍝ result would be wrong. The important phrase in the puzzle is
⍝ that "all other [non-9] locations will always be part of
⍝ exactly one basin."
⍝ 
⍝ Take a look at the very top right corner of the actual puzzle
⍝ input. When we replace the 9s with dashes, it looks like this:

...5-87654678
...43-876678-
...721-878---
...4323-8--87
...543-8-68-5
.............

⍝ From the low point at 1 97, our algorithm must be able to reach
⍝ all 18 connected locations. Note that the bit to the upper right
⍝ is not "connected" to the low point's digit 4 by a direct
⍝ increment (i.e. a 5).

      +/+/1=({9∧9=⍵}load '09.input') basin 1 97
18

⍝ If we got the basin fill algorithm right, the total size of all
⍝ basins in the puzzle input should be 7328. (As there are 7428
⍝ non-9 characters in the puzzle input, minus 100 newlines.)

      +/basizes load '09.input'
7328

⍝ # 
