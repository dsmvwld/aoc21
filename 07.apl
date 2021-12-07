⍝ day 7

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      load←{⍎¨','(≠⊆⊢)⊃(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}

      {⌊/+/|⍵∘.-⍵} load '07.test'
37

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

      fuel←{+/⍳⍵}
      range←{¯1+(⍺⌊⍵)+⍳1+|⍺-⍵}

      {⌊/+/fuel¨|((⌊/⍵) range ⌈/⍵)∘.-⍵} load '07.test'
168

⍝ ============================================================
⍝ guide
⍝ ============================================================
⍝ 
⍝ Loading the data is as before, splitting on commas. 

      v←load '07.test'
      v
16 1 2 0 4 2 7 1 2 14

⍝ No time to think today, we're going for brute force. Let's
⍝ compute the distance matrix for v against v, even if some
⍝ elements occur more than once (leading to superfluous
⍝ computations and multiple occurrences of the minimum).

      v∘.-v
  0 15 14 16 12 14  9 15 14   2
¯15  0 ¯1  1 ¯3 ¯1 ¯6  0 ¯1 ¯13
¯14  1  0  2 ¯2  0 ¯5  1  0 ¯12
¯16 ¯1 ¯2  0 ¯4 ¯2 ¯7 ¯1 ¯2 ¯14
¯12  3  2  4  0  2 ¯3  3  2 ¯10
¯14  1  0  2 ¯2  0 ¯5  1  0 ¯12
 ¯9  6  5  7  3  5  0  6  5  ¯7
¯15  0 ¯1  1 ¯3 ¯1 ¯6  0 ¯1 ¯13
¯14  1  0  2 ¯2  0 ¯5  1  0 ¯12
 ¯2 13 12 14 10 12  7 13 12   0

⍝ Ah, we meant the absolute value, of course.

      |v∘.-v
 0 15 14 16 12 14 9 15 14  2
15  0  1  1  3  1 6  0  1 13
14  1  0  2  2  0 5  1  0 12
16  1  2  0  4  2 7  1  2 14
12  3  2  4  0  2 3  3  2 10
14  1  0  2  2  0 5  1  0 12
 9  6  5  7  3  5 0  6  5  7
15  0  1  1  3  1 6  0  1 13
14  1  0  2  2  0 5  1  0 12
 2 13 12 14 10 12 7 13 12  0

⍝ We determine row-wise sums, and then seek their minimum.

      +/|v∘.-v
111 41 37 49 41 37 53 41 37 95

      ⌊/+/|v∘.-v
37

⍝ For part 2, we introduce a fuel cost function, and check
⍝ its first 11 values.

      fuel←{+/⍳⍵}
      fuel¨⍳11
1 3 6 10 15 21 28 36 45 55 66

⍝ We then map the fuel function across the distance matrix.
⍝ However, the simplistic approach from part 1 does not succeed.

      ⌊/+/fuel¨|v∘.-v
170

⍝ The minimum of 168 is not quite reached. That is because the
⍝ new "sweet spot" (5) is not even a member of the input vector.
⍝ We need to cover all positions from the minimum contained in v
⍝ to the maximum contained in v.
⍝ We'll kindof borrow the range function from day 5, and feed it
⍝ the required min/max values.

      (⌊/v) range ⌈/v
0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16

      ⌊/+/fuel¨|((⌊/v) range ⌈/v)∘.-v
168

⍝ Abstracting out the v reference as a right-hand argument of
⍝ a direct function:

      {⌊/+/fuel¨|((⌊/⍵) range ⌈/⍵)∘.-⍵}v
168

⍝ Final note: When applied to the actual puzzle input, the
⍝ numbers may crunch for a while. (The distance matrix for the
⍝ test vector has only 170 values, the puzzle input has nearly
⍝ 2M.)

⍝ #
