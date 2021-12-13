⍝ day 13

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      ⎕IO←0

      paper←{
          pts←{⍎¨','(≠⊆⊢)⍵}¨⍵
          m←(⊃1+⌈/pts)⍴0
          dummy←{(⍵⌷m)←1}¨pts
          ⍉m
      }
      insn←{⍎¨'='(≠⊆⊢)2⊃' '(≠⊆⊢)⍵}
      load←{
          in←(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵
          d←{0=⍵⍳'f'}¨in
          (⊂paper(1-d)/in),⊂insn¨d/in
      }
      y←0
      x←1

∇r←x foldleft m;h;w;left;right;d;pad
 (h w)←⍴m
 left←m[;⍳x]
 right←m[;1+x+⍳w-1+x]
 d←(¯1↑⍴right)-¯1↑⍴left
 :If d≠0
     pad←(h,|d)⍴0
     :If d<0
         right,←pad
     :Else
         left←pad,left
     :EndIf
 :EndIf
 r←left∨⊖[1]right
∇

∇r←y foldup m;h;w;top;bottom;d;pad
 (h w)←⍴m
 top←m[⍳y;]
 bottom←m[1+y+⍳h-1+y;]
 d←(1↑⍴bottom)-1↑⍴top
 :If d≠0
     pad←((|d),w)⍴0
     :If d<0
         bottom←bottom,[0]pad
     :Else
         top←top,[0]pad
     :EndIf
 :EndIf
 r←top∨⌽[0]bottom
∇

∇r←part1 data;m;dir;coord
 m←0⊃data
 (dir coord)←⊃1⊃data
 :If 0=dir
     m←coord foldup m
 :Else
     m←coord foldleft m
 :EndIf
 r←+/+/m
∇

      part1 load '13.test'
17

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

      plot←{'.#'[⍵]}

∇part2 data;m;insn;dir;coord
 m←0⊃data
 :For insn :In 1⊃data
     (dir coord)←insn
     :If 0=dir
         m←coord foldup m
     :Else
         m←coord foldleft m
     :EndIf
 :EndFor
 plot m
∇

      part2 load '13.test'
#####
#...#
#...#
#...#
#####
.....
.....

⍝ ============================================================
⍝ guide
⍝ ============================================================

      DISPLAY load '13.test'
┌→────────────────────────────────────────┐
│ ┌→────────────────────┐ ┌→────────────┐ │
│ ↓0 0 0 1 0 0 1 0 0 1 0│ │ ┌→──┐ ┌→──┐ │ │
│ │0 0 0 0 1 0 0 0 0 0 0│ │ │0 7│ │1 5│ │ │
│ │0 0 0 0 0 0 0 0 0 0 0│ │ └~──┘ └~──┘ │ │
│ │1 0 0 0 0 0 0 0 0 0 0│ └∊────────────┘ │
│ │0 0 0 1 0 0 0 0 1 0 1│                 │
│ │0 0 0 0 0 0 0 0 0 0 0│                 │
│ │0 0 0 0 0 0 0 0 0 0 0│                 │
│ │0 0 0 0 0 0 0 0 0 0 0│                 │
│ │0 0 0 0 0 0 0 0 0 0 0│                 │
│ │0 0 0 0 0 0 0 0 0 0 0│                 │
│ │0 1 0 0 0 0 1 0 1 1 0│                 │
│ │0 0 0 0 1 0 0 0 0 0 0│                 │
│ │0 0 0 0 0 0 1 0 0 0 1│                 │
│ │1 0 0 0 0 0 0 0 0 0 0│                 │
│ │1 0 1 0 0 0 0 0 0 0 0│                 │
│ └~────────────────────┘                 │
└∊────────────────────────────────────────┘

      m←⊃load '13.test'
      plot m
...#..#..#.
....#......
...........
#..........
...#....#.#
...........
...........
...........
...........
...........
.#....#.##.
....#......
......#...#
#..........
#.#........
      plot 7 foldup m
#.##..#..#.
#...#......
......#...#
#...#......
.#.#..#.###
...........
...........
      plot 5 foldleft 7 foldup m
#####
#...#
#...#
#...#
#####
.....
.....

⍝ The test data from part 1 only folds in the center of
⍝ the paper. The folding instructions from the actual input
⍝ data also folds off-middle, so attention must be paid to
⍝ proper alignment and padding.
⍝ 
⍝ #
