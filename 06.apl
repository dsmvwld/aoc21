⍝ day 6

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      load←{⍎¨','(≠⊆⊢)⊃(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}

∇r←next v;n
 v←v-1
 n←v=¯1
 r←(v+7∧n),(+/n)⍴8
∇

      ⍴(next⍣18)v
26
      ⍴(next⍣80)v
5934

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

      vton←{+/(¯1+⍳9)∘.=⍵}

      enc←{(15⍴10)⊤⍵}
      dzero←enc 0

∇r←a dadd b
 r←a
 :Repeat
     r←r+b
     b←1⌽9<r ⍝ carry
     r←10|r
 :Until 0=+/b
∇

∇r←next n;f
 f←1⊃n
 r←((6⍴⊂dzero),f dzero dzero)dadd¨(1↓n),⊂f
∇

      dadd/(next⍣256) enc¨vton load '06.test'
 0 0 0 0 2 6 9 8 4 4 5 7 5 3 9 

⍝ ============================================================
⍝ guide
⍝ ============================================================

⍝ Input data is loaded as before, the first line of the file
⍝ is then split at commas and then converted to numbers.
⍝ 
⍝ In part 1 we'll be keeping track of the lanternfish timers
⍝ individually. The function next, when given a vector of
⍝ timer states, computes the following day's timer states.
⍝ It does this by first subtracting 1 from every timer, and
⍝ then checking where the timers went from 0 (a legal state)
⍝ to ¯1.

∇r←next v;n
 v←v-1
 n←v=¯1
 r←(v+7∧n),(+/n)⍴8
∇

⍝ To see the effect, let's look at day 2's state, because it
⍝ conveniently contains one timer with a 0 value.

      w←2 3 2 0 1
      w
2 3 2 0 1
      ¯1=w-1
0 0 0 1 0

⍝ At that fourth position, the timer needs to be reset to 6
⍝ (by adding 7). A vector that has 7s at the desired positions
⍝ can be created in different ways, e.g. by logical AND or
⍝ simply by multiplication.

      7∧¯1=w-1
0 0 0 7 0
      7×¯1=w-1
0 0 0 7 0
      (w-1)+7∧¯1=w-1
1 2 1 6 0

⍝ This is already nearly the state of day 3, except for the
⍝ new fish. The count of ¯1 timers also specifies how many
⍝ timers of value 8 should be added to the end, in this case,
⍝ a single timer.

      +/¯1=w-1
1
      (+/¯1=w-1)⍴8
8
      ((w-1)+7∧¯1=w-1),(+/¯1=w-1)⍴8
1 2 1 6 0 8

⍝ To see successive days, repeatedly apply the function next.

      v←load '06.test'
      v
3 4 3 1 2
      next v
2 3 2 0 1
      next next v
1 2 1 6 0 8
      next next next v
0 1 0 5 6 7 8
      next next next next v
6 0 6 4 5 6 7 8 8

⍝ Multiple applications of the same function can be written
⍝ in a concise way as follows.

      (next⍣4)v
6 0 6 4 5 6 7 8 8
      (next⍣5)v
5 6 5 3 4 5 6 7 7 8

⍝ So if we determine the length of the state after 18 or 80
⍝ days respectively, we get:

      ⍴(next⍣18)v
26
      ⍴(next⍣80)v
5934

⍝ Part 2 makes it interesting, because it either requires huge
⍝ amounts of memory, or a twist of perspective. We'll do the
⍝ twist. First, let's see how part 1's simple approach fails.

      ⍴(next⍣256)load '06.test'
WS FULL

⍝ The message means that the vector grew too large to fit into
⍝ workspace memory. The puzzle text teases that for the given
⍝ example (3 4 3 1 2), the state vector would have to hold
⍝ 26,984,457,539 entries in the end.
⍝ 
⍝ Plot twist: notice that we aren't (and never were) asked for
⍝ the individual fishes' timer values, just for the total number
⍝ of fish.
⍝ 
⍝ Let's just keep track of the *number* of fish which are in a
⍝ specific state (from 0 to 8). That will only take a 9-element
⍝ vector. We'll have to convert from the given initial state to
⍝ such a counted representation, and rewrite our next function,
⍝ of course. The vton function performs the conversion part.
⍝ It creates an equaliy matrix against 0..8 and summarizes the
⍝ occurrences. Each column contains exactly one 1, and we a then
⍝ retrieve the row-wise sums.

      v
3 4 3 1 2
      ¯1+⍳9
0 1 2 3 4 5 6 7 8
      (¯1+⍳9)∘.=v
0 0 0 0 0
0 0 0 1 0
0 0 0 0 1
1 0 1 0 0
0 1 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
      +/(¯1+⍳9)∘.=v
0 1 1 2 1 0 0 0 0
      vton v
0 1 1 2 1 0 0 0 0

⍝ This then is our new state representation. There are no 0s
⍝ in the initial state, one 1, one 2, two 3s, and one 4 and
⍝ no 5, 6, 7 or 8.
⍝ 
⍝ The next function works by popping off the count for 0s,
⍝ and thereby shifting the other entries to the left -- all
⍝ those fish get their timer decremented, so they effectively
⍝ move one bucket to the left.
⍝ Depending on how many 0s there were, the bucket for the 6s
⍝ gets incremented by that amount, as does the new bucket for
⍝ the 8s.

∇r←nextn n;f
 f←1↑n
 r←((6⍴0),f,0 0)+(1↓n),f
∇

      nextn vton v
1 1 2 1 0 0 0 0 0
      nextn nextn vton v
1 2 1 0 0 0 1 0 1

⍝ So, can we now ask our actual question?

      (nextn⍣256) vton v
2376852196 2731163883 2897294544 3164316379 3541830408 3681986557 4275812629
      1985489551 2329711392

      +/(nextn⍣256) vton v
2.698445754E10

⍝ Oh well. That's indeed close to the number that the puzzle
⍝ text hinted at, but (a) it's not an exact integer and (b) the
⍝ actual puzzle input, with a start state of length 300, is likely
⍝ to be much higher even. Hmm, how much higher?

      10⍟+/(nextn⍣256) vton load '06.input'
12.24494827

⍝ On the order of 1E12. Let's continue our quest to determine
⍝ the exact number of fish after 256 generations. We'll implement
⍝ our own long arithmetic. Fortunately, we only need addition.
⍝ The enc function encodes a given integer into a digit-wise
⍝ representation.

      enc←{(15⍴10)⊤⍵}

      enc 999
0 0 0 0 0 0 0 0 0 0 0 0 9 9 9
      (enc 999)+enc 1
0 0 0 0 0 0 0 0 0 0 0 0 9 9 10

⍝ Obviously, it's not *that* easy.

∇r←a dadd b
 r←a
 :Repeat
     r←r+b
     b←1⌽9<r ⍝ carry
     r←10|r
 :Until 0=+/b
∇

      (enc 999) dadd enc 1
0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
      (enc 999) dadd enc 999
0 0 0 0 0 0 0 0 0 0 0 1 9 9 8

⍝ Much better. From there on, it's smooth sailing.
⍝ 
⍝ (Do you notice the lingering bug in dadd? The left-shift
⍝ of the carry digits is actually a rotation. This will spell
⍝ big trouble if a carry digit ever "wraps around.")
⍝ 

      dadd/(next⍣256) enc¨vton load '06.test'
 0 0 0 0 2 6 9 8 4 4 5 7 5 3 9

⍝ Finally! 
