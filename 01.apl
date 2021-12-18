⍝ day 1: Sonar Sweep

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      load←{↑⍎¨(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}
      +/{(1↓⍵)>¯1↓⍵}load '01.test'
7

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

      +/{(1↓⍵)>¯1↓⍵}{¯2↓+/[1]0 1 2⌽(3,⍴⍵)⍴⍵}load '01.test'
5

⍝ ============================================================
⍝ guide
⍝ ============================================================
⍝ 
⍝ First, load is a direct function (DFN) to load the test
⍝ vector (or the actual input vector) from disk. The function
⍝ accepts a right argument (⍵), which is the file name (either
⍝ *.test or *.input). AoCPath is defined in setup.apl.
⍝ 
⍝ Loading happens by reading the entire file at once, then
⍝ splitting on line feeds (UCS 10), parsing each line string
⍝ as a number, and contracting to a simple vector.
⍝ 
⍝ The result of load then looks like this:

      DISPLAY load '01.test'
┌→──────────────────────────────────────┐
│199 200 208 210 200 207 240 269 260 263│
└~──────────────────────────────────────┘

⍝ The actual computation compares ("shifts") the test vector
⍝ along itself by dropping one element from the front and back
⍝ respectively, and comparing those shorter vectors element-
⍝ wise. The sum reduction (+/) of the comparison results
⍝ (1s where true) thus gives the desired count.
⍝ 
⍝ 199 200 208 210 200 207 240 269 260 263
⍝      >   >   >   ≤   >   >   >   ≤   >
⍝     199 200 208 210 200 207 240 269 260 263

      v←load '01.test'

      1↓v
200 208 210 200 207 240 269 260 263

      ¯1↓v
199 200 208 210 200 207 240 269 260

      (1↓v)>(¯1↓v)
1 1 1 0 1 1 1 0 1

      +/(1↓v)>(¯1↓v)
7

⍝ The code for part 2 inserts one transformation DFN into
⍝ the computation pipeline. That additional {}-block rather
⍝ clumsily computes the windowed sums by taking the vector,
⍝ creating a window-sized matrix from it, and shifting the
⍝ "lower" matrix rows. (Rotating, actually. But the last
⍝ two matrix columns will be dropped soon anyhow.)

      {(3,⍴⍵)⍴⍵}v
199 200 208 210 200 207 240 269 260 263
199 200 208 210 200 207 240 269 260 263
199 200 208 210 200 207 240 269 260 263

      0 1 2⌽{(3,⍴⍵)⍴⍵}v
199 200 208 210 200 207 240 269 260 263
200 208 210 200 207 240 269 260 263 199
208 210 200 207 240 269 260 263 199 200

⍝ Then, columns are added up, and the last two columns are 
⍝ dropped.

      +/[1]0 1 2⌽{(3,⍴⍵)⍴⍵}v
607 618 618 617 647 716 769 792 722 662

      ¯2↓+/[1]0 1 2⌽{(3,⍴⍵)⍴⍵}v
607 618 618 617 647 716 769 792

⍝ From there, the part 1 solution is reused:

      +/{(1↓⍵)>¯1↓⍵}¯2↓+/[1]0 1 2⌽{(3,⍴⍵)⍴⍵}v
5

⍝ #
