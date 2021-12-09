⍝ day 8

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      load←{(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}
      columns←{' '(≠⊆⊢)⍺⊃'|'(≠⊆⊢)⍵}

      ⊃+/+/2 3 4 7∘.=,⍴¨↑2 columns¨load '08.test'
26

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

      bits←{∨/'abcdefg'∘.=⍵}

∇r←decode line;u;n;d;pic1;pic4;fives;sixes;fourish;thrix
 u←↑bits¨1 columns line
 n←+/u
 d←10⍴0
 d[n⍳2]←1 ⋄ d[n⍳3]←7 ⋄ d[n⍳4]←4 ⋄ d[n⍳7]←8
 pic1←3 7⍴u[n⍳2;] ⋄ pic4←3 7⍴u[n⍳4;]
⍝ disambiguate 3/2/5:
 fives←(n=5)/(⍳10)×n=5
 thrix←(+/pic1∧u[fives;])⍳2
 d[fives[thrix]]←3
 fourish←+/pic4∧u[fives;]
 fourish[thrix]←0
 d[fives[fourish⍳2]]←2
 d[fives[fourish⍳3]]←5
⍝ disambiguate 9/6/0:
 sixes←(n=6)/(⍳10)×n=6
 d[sixes[(+/pic4∧u[sixes;])⍳4]]←9
 d[sixes[(+/pic1∧u[sixes;])⍳1]]←6
 r←(4⍴10)⊥{d[u⍳⍵]}¨bits¨2 columns line
∇

      +/decode¨load '08.test'
61229

⍝ ============================================================
⍝ guide
⍝ ============================================================

⍝ The load function creates a list of strings from the given
⍝ file, one for each complete line. The columns function gives
⍝ us either the part before the '|', the left argument
⍝ determines if we get the array of 8 strings before the
⍝ separator, or the array of 4 strings after the separator.
⍝ 
⍝ So if we take the first line of the test data as an example,

      DISPLAY 2 columns line
┌→──────────────────────────────────┐
│ ┌→──────┐ ┌→────┐ ┌→─────┐ ┌→───┐ │
│ │fdgacbe│ │cefdb│ │cefbgd│ │gcbe│ │
│ └───────┘ └─────┘ └──────┘ └────┘ │
└∊──────────────────────────────────┘

⍝ We map the string length function along it, and determine
⍝ where the length is one of 2, 3, 4 or 7 -- the number of
⍝ segments corresponding to the digits 1, 7, 4 or 8.

      ⍴¨2 columns line
 7  5  6  4
      2 3 4 7∘.=⍴¨2 columns line
 0  0  0  0 
 0  0  0  0 
 0  0  0  1 
 1  0  0  0
      ⊃+/+/2 3 4 7∘.=⍴¨2 columns line
2

⍝ The sum gives us the total number of occurrences of either,
⍝ in this case 'fdgacbe' (for a digit 8) and 'gcbe' (for a
⍝ digit 4). The other two segment strings are ambiguous, and
⍝ cannot be determined from length alone.
⍝ 
⍝ The solution performs this across all of the first set of
⍝ columns from the data file.

⍝ On to part 2. We will build a decoder vector from the first
⍝ set of columns, and apply it to the second set of columns.
⍝ Note that simple string matching across the border will not
⍝ suffice, as e.g. 'cgeb' from the left columns has to match
⍝ 'gcbe' from the right columns.
⍝ We therefore encode unique signal patterns from the left
⍝ side as binary, resulting in a single matrix u with 10 rows
⍝ -- one for each digit -- of 7 segment flags.

      1 columns line
 be  cfbegad  cbdgef  fgaecd  cgeb  fdcge  agebfd  fecdb  fabcd  edb 

      u←↑bits¨1 columns line
      u
0 1 0 0 1 0 0
1 1 1 1 1 1 1
0 1 1 1 1 1 1
1 0 1 1 1 1 1
0 1 1 0 1 0 1
0 0 1 1 1 1 1
1 1 0 1 1 1 1
0 1 1 1 1 1 0
1 1 1 1 0 1 0
0 1 0 1 1 0 0
      n←+/u
      n
2 7 6 6 4 5 6 5 5 3

⍝ We will build a digit vector that shall indicate which actual
⍝ digit each of those segment counts stands for. The matrix u
⍝ will help in disambiguation. For now, we can see that the counts
⍝ 2, 3, 4 and 7 indicate that the digits 1, 7, 4, and 8 "live" in
⍝ that position, respectively.

      d←10⍴0
      n⍳2
1
      n⍳3
10
      n⍳4
5
      n⍳7
2
      d[n⍳2]←1 ⋄ d[n⍳3]←7 ⋄ d[n⍳4]←4 ⋄ d[n⍳7]←8
      d
1 8 0 0 4 0 0 0 0 7

⍝ Of the remaining digits, there are 3 digits with 5 segments, and
⍝ 3 digits with 6 segments. We shall disambiguate each group by
⍝ comparing their segment images to the commonalities with the
⍝ segment images of the digits 1 and 4.
⍝ In the group of "fivers", only the digit 3 includes both of the
⍝ segments of the digit 1. (The digits 2 and 5 only share one common
⍝ segment with the digit 1.)
⍝ The fives are located at the following indexes in u.

      fives←(n=5)/(⍳10)×n=5
      fives
6 8 9
      +/pic1∧u[fives;]
1 2 1
      (+/pic1∧u[fives;])⍳2
2

⍝ So the digit 3 is at index 8 (=fives[2]) in the digit vector.
⍝ 
⍝ One little complication now is that to find ot which of the
⍝ remaining "fivers" is the 2 and which is the 5, we compare with
⍝ the image of the digit 4. The digit 2 shares 2 segments with the
⍝ 4, and the digit 5 shares 3 with the digit 4. But digit 3, which
⍝ we just located, *also* shares 3 segments with the digit 4.

      +/pic4∧u[fives;]
3 3 2

⍝ Thus, after locating digit 3, we invalidate its count, to safely
⍝ find the only remaining count of 3 (which is then the digit 5).
⍝ 
⍝ The group of "sixers" is comparatively easier to disambiguate.
⍝ The digit 9 shares 4 segments with the digit 4, and digit 6 is
⍝ the one that only shares only 1 segment with the digit 1.
⍝ The digit 0 is then simply the last unassigned element in d,
⍝ remaining at 0.
⍝ 
⍝ So once we have d complete, decoding the second set of columns
⍝ from the line is easy.

      {d[u⍳⍵]}¨bits¨2 columns line
8 3 9 4
      (4⍴10)⊥{d[u⍳⍵]}¨bits¨2 columns line
8394

      decode¨load '08.test'
8394 9781 1197 9361 4873 8418 4548 1625 8717 4315

      +/decode¨load '08.test'
61229

⍝ #
