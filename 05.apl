⍝ day 5

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      load←{↑{⍎¨(1-∨⌿' ,->'∘.=⍵)⊆⍵}¨(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}

∇r←j range k
 r←¯1+(j⌊k)+⍳1+|j-k
 :If j>k
     r←⌽r
 :EndIf
∇

∇r←n image line;x1;y1;x2;y2
 (x1 y1 x2 y2)←1+line
 r←n n⍴0
 :If x1=x2
 :OrIf y1=y2
     r[y1 range y2;x1 range x2]←1
 :EndIf
∇

      {+/+/⊃2≤+/+/(1+⌈/⌈/⍵) image¨↓⍵}load '05.test'
5

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

⍝ Extend the image function by an ELSE path. Only those two
⍝ lines are new.

∇r←n image line;x1;y1;x2;y2
 (x1 y1 x2 y2)←1+line
 r←n n⍴0
 :If x1=x2
 :OrIf y1=y2
     r[y1 range y2;x1 range x2]←1
 :Else
     r[↓(y1 range y2),[1.5](x1 range x2)]←1
 :EndIf
∇

     {+/+/⊃2≤+/+/(1+⌈/⌈/⍵) image¨↓⍵}load '05.test' 
12

⍝ ============================================================
⍝ guide
⍝ ============================================================

⍝ Loading the input data requires a bit more effort due to the
⍝ formatting. Let's look at the first line as an example:

      line←⊃(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,'05.test'
      DISPLAY line
┌→─────────┐
│0,9 -> 5,9│
└──────────┘

⍝ We locate a handful of delimiters in that string, and
⍝ partition the string according to their combination by
⍝ logical OR.

      ' ,->'∘.=line
0 0 0 1 0 0 1 0 0 0
0 1 0 0 0 0 0 0 1 0
0 0 0 0 1 0 0 0 0 0
0 0 0 0 0 1 0 0 0 0

      ∨⌿' ,->'∘.=line
0 1 0 1 1 1 1 0 1 0

⍝ The zeroes in that vector correspond to the net data
⍝ that we want to extract. We negate the vector, partition
⍝ the string accordingly, and convert the parts to numbers.

      DISPLAY {(1-∨⌿' ,->'∘.=⍵)⊆⍵}line
┌→────────────────┐
│ ┌→┐ ┌→┐ ┌→┐ ┌→┐ │
│ │0│ │9│ │5│ │9│ │
│ └─┘ └─┘ └─┘ └─┘ │
└∊────────────────┘

      DISPLAY {⍎¨(1-∨⌿' ,->'∘.=⍵)⊆⍵}line
┌→──────┐
│0 9 5 9│
└~──────┘

⍝ The load function applies that conversion to each of
⍝ the file's lines, and arrives at:

      DISPLAY load '05.test'
┌→──────┐
↓0 9 5 9│
│8 0 0 8│
│9 4 3 4│
│2 2 2 1│
│7 0 7 4│
│6 4 2 0│
│0 9 2 9│
│3 4 1 4│
│0 0 8 8│
│5 5 8 2│
└~──────┘

⍝ The idea of the solution is to transform each of those
⍝ 4-tuples into a binary image of the line, and to then
⍝ add all those images together.
⍝ For this, the function needs to know the dimensions of
⍝ the matrix. Since the line coordinates are 0-based, the
⍝ maximum coordinate value of the matrix is determined.

      m←load '05.test'
      1+⌈/⌈/m
10

⍝ The image function is called with that value, and each
⍝ of the tuples from our data. Examples:

      10 image 0 9 5 9
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
1 1 1 1 1 1 0 0 0 0

      10 image 2 2 2 1
0 0 0 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0

⍝ The sum of these images for all lines in m is then:

      DISPLAY ⊃{+/+/(1+⌈/⌈/⍵) image¨↓⍵}m
┌→──────────────────┐
↓1 0 1 0 0 0 0 1 1 0│
│0 1 1 1 0 0 0 2 0 0│
│0 0 2 0 1 0 1 1 1 0│
│0 0 0 1 0 2 0 2 0 0│
│0 1 1 2 3 1 3 2 1 1│
│0 0 0 1 0 2 0 0 0 0│
│0 0 1 0 0 0 1 0 0 0│
│0 1 0 0 0 0 0 1 0 0│
│1 0 0 0 0 0 0 0 1 0│
│2 2 2 1 1 1 0 0 0 0│
└~──────────────────┘

⍝ From there, it should be easy to determine which elements
⍝ are at least 2, and how many of those there are.

      ⊃{2≤+/+/(1+⌈/⌈/⍵) image¨↓⍵}m
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 1 0 0
0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 1 0 1 0 0
0 0 0 1 1 0 1 1 0 0
0 0 0 0 0 1 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
1 1 1 0 0 0 0 0 0 0

      +/+/⊃{2≤⊃+/+/(1+⌈/⌈/⍵) image¨↓⍵}m
12

⍝ The image function relies on the range function as its
⍝ index generator. The range function takes a left and
⍝ right argument, and generates the sequence between those
⍝ two values, inclusive.

      3 range 6
3 4 5 6
      8 range 2
8 7 6 5 4 3 2
      1 range 1
1
      ⍴1 range 1
1

⍝ Also note how the image function increments all line
⍝ coordinates by 1, in order to accomodate 1-based indexing
⍝ of the generated n×n matrix. (We could have changed APLs
⍝ array indexing to be 0-based, and worked with those.)

⍝ ============================================================
⍝ appendix
⍝ ============================================================

⍝ One idea that turned out to be unnecessary was the pre-
⍝ filtering of the matrix m down to only the horizontal
⍝ and vertical lines. It turned out that that was easily
⍝ accomplished in the image function itself. But for
⍝ completeness, the filtering is shown here.

      ((m[;1]=m[;3])∨m[;2]=m[;4])⌿m
0 9 5 9
9 4 3 4
2 2 2 1
7 0 7 4
0 9 2 9
3 4 1 4

      ortho←{((⍵[;1]=⍵[;3])∨⍵[;2]=⍵[;4])⌿⍵}
      {+/+/⊃2≤+/+/(1+⌈/⌈/⍵) image¨↓⍵} ortho load '05.test'
5

⍝ Likewise, notice that it's not necessary to distinguish
⍝ horizontal and vertical lines, as in the following.
⍝ In those cases where  y1 range y2  and y1=y2, the former
⍝ expression can still be used, since it evaluates to the
⍝ same one-element vector.

∇r←n image line;x1;y1;x2;y2
 (x1 y1 x2 y2)←1+line
 r←n n⍴0
 :If x1=x2 ⍝ vertical
     r[y1 range y2;x1]←1
 :ElseIf y1=y2 ⍝ horizontal
     r[y1;x1 range x2]←1
 :EndIf
∇
