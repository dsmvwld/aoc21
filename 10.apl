⍝ day 10

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      load←{(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}
      conv←{+⌿↑(¯5+⍳9)×↓'>}])*([{<'∘.=⍵}

      cv←{((⍵-1)⍴1),0 0,((⍴⍺)-⍵+1)⍴1}

∇r←reduce v;i;d
 r←v
 d←0
Begin:
 i←d+(d↓{(¯1↓⍵)+1↓⍵}r)⍳0
 →(i≥⍴r)/0
 :If r[i]>0
     r←(r cv i)/r
 :Else
     d←i
 :EndIf
 →Begin
∇

∇r←score line;s;i
 s←reduce conv line
 i←(0>s)⍳1
 :If i>⍴s
     r←0
 :Else
     r←3 57 1197 25137[|s[i]]
 :EndIf
∇

      +/score¨load '10.test'
26397

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

      {⍵[⍋⍵][⌈(⍴⍵)÷2]}{5⊥⌽reduce conv ⍵}¨{({0=score ⍵}¨⍵)/⍵}load'10.test'
288957

⍝ ============================================================
⍝ guide
⍝ ============================================================

⍝ We will change the input lines into something more comfortable
⍝ for processing. The goal is to detect matching parentheses of
⍝ all four classes simultaneously, and along the entire input string.
⍝ We chose a numerical representation, with opening parens (of any
⍝ kind) being positive numbers, and the respective closing parens
⍝ being negative numbers. We can then search the resulting vector
⍝ for places where consecutive numbers, when added, result in a
⍝ zero sum.
⍝ Why detect consecutive matching parens? To eliminate them from
⍝ the string! If we do that as long as it's possible -- we'll only
⍝ reduce the leftmost occurrence of any kind of paren pair -- then
⍝ the resulting (shorter) string will tell us if it is corrupt or
⍝ merely incomplete.
⍝ 
⍝ But, first the encoding.

      input←load '10.test'
      line←input⊃1
      DISPLAY line
┌→───────────────────────┐
│[({(<(())[]>[[{[]{<()<>>│
└────────────────────────┘

      '>}])*([{<'∘.=line
0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 1 0 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0
1 0 0 0 0 0 0 0 0 1 0 0 1 1 0 1 0 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0
0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0

⍝ The asterisk in the middle of the string is just a placeholder.
⍝ It is useful because we now assign each found paren a number
⍝ from ¯4 to 4. (The asterisk would correspond to index 0.)
⍝ The parentheses '()' are 1 and ¯1 respectively, the brackets '[]'
⍝ are 2 and ¯2, the braces '{}' are 3 and ¯3, and finally the angle
⍝ brackets '<>' are 4 and ¯4.
⍝ We then collapse the matrix columns, and voilà our desired
⍝ numeric representation.

      ¯5+⍳9
¯4 ¯3 ¯2 ¯1 0 1 2 3 4

      ↑(¯5+⍳9)×↓'>}])*([{<'∘.=line
0 0 0 0 0 0 0  0  0 0  0 ¯4 0 0 0 0  0 0 0 0  0 0 ¯4 ¯4
0 0 0 0 0 0 0  0  0 0  0  0 0 0 0 0  0 0 0 0  0 0  0  0
0 0 0 0 0 0 0  0  0 0 ¯2  0 0 0 0 0 ¯2 0 0 0  0 0  0  0
0 0 0 0 0 0 0 ¯1 ¯1 0  0  0 0 0 0 0  0 0 0 0 ¯1 0  0  0
0 0 0 0 0 0 0  0  0 0  0  0 0 0 0 0  0 0 0 0  0 0  0  0
0 1 0 1 0 1 1  0  0 0  0  0 0 0 0 0  0 0 0 1  0 0  0  0
2 0 0 0 0 0 0  0  0 2  0  0 2 2 0 2  0 0 0 0  0 0  0  0
0 0 3 0 0 0 0  0  0 0  0  0 0 0 3 0  0 3 0 0  0 0  0  0
0 0 0 0 4 0 0  0  0 0  0  0 0 0 0 0  0 0 4 0  0 4  0  0

      +⌿↑(¯5+⍳9)×↓'>}])*([{<'∘.=line
2 1 3 1 4 1 1 ¯1 ¯1 2 ¯2 ¯4 2 2 3 2 ¯2 3 4 1 ¯1 4 ¯4 ¯4
      line
[({(<(())[]>[[{[]{<()<>>

⍝ We now enter the realm of the reduce function. It compares
⍝ the vector with itself shifted by 1 position.

      v←+⌿↑(¯5+⍳9)×↓'>}])*([{<'∘.=line
      {(¯1↓⍵)+1↓⍵}v
3 4 4 5 5 2 0 ¯2 1 0 ¯6 ¯2 4 5 5 0 1 7 5 0 3 0 ¯8

⍝ There are five 0s in that result, corresponding to the
⍝ substrings (), [], [], () and <> in our string. What the
⍝ reduce function now does is to expunge the leftmost pair
⍝ and to re-evaluate. This is important, because elimination
⍝ of the leftmost pair now gives parens even further left
⍝ a chance to match up. (This is indeed the case when we
⍝ eliminate the first match -- it brings another pair of
⍝ opening and closing parentheses together.)
⍝ 
⍝ There is one detail that reduce has to pay attention to,
⍝ however. The converted string '()' results in a zero sum
⍝ when added together in that shifted fashion. But so does
⍝ the string ')(', and that certainly is not a matched pair!
⍝ Therefore, reduce explicitly checks if the left number is
⍝ positive (i.e. an opening paren) when a sum is zero.
⍝ Furthermore, reduce maintains a displacement (d) when
⍝ scanning the sum vector for zeroes. If a zero sum is the
⍝ result of a "bad match", the displacement is used to scan
⍝ for the next zero after that.
⍝ However, if the zero sum is indeed from a open-then-close
⍝ pair of parens, the helper function cv computes a compression
⍝ vector which is used to shorten our working string.
⍝ 
⍝ In the end, the first line comes out as:

      reduce conv line
2 1 3 1 2 2 3 3

⍝ This reduced "stem" of the input line is quite informative!
⍝ In this case -- the first line from the test input -- only
⍝ positive numbers remained in the stem. It is an incomplete
⍝ entry. Let's compare it with a corrupt entry, e.g. the 3rd
⍝ from the test input.

      reduce conv 3⊃input
3 1 2 1 4 2 ¯3 ¯4 3 3 2 1

⍝ In this case, the reduced stem also contains closing parens,
⍝ represented by negative numbers. And not only that, the first
⍝ of the negative numbers also tells us what closing paren (¯3)
⍝ did not match the nearest opening paren (2). Just what we need
⍝ for computing the score!
⍝ 
⍝ And that is basically what the score function does. It checks
⍝ for the first occurrence of a negative number in the reduced
⍝ stem. If none is present, the entry was incomplete, and a zero
⍝ score is returned. However if a negative entry is indeed found,
⍝ its numeric value is retrieved and used to look up the score.

      s←reduce conv 3⊃input
      s
3 1 2 1 4 2 ¯3 ¯4 3 3 2 1
      (s<0)⍳1
7
      3 57 1197 25137[|s[7]]
1197

⍝ With that, part 1 is complete. We map the score function 
⍝ across all entries from the input file, and sum up the
⍝ the results. 

      +/score¨load '10.test'
26397

⍝ That was a lot of code for solving part 1, but to our
⍝ amusement we find that we already have all the building
⍝ blocks for solving part 2 directly.
⍝ 
⍝ That's because we now look at the incomplete entries again.
⍝ Recall the "incomplete" entry that we examined before, the
⍝ one that had only positive numbers (i.e., opening parens):

      reduce conv line
2 1 3 1 2 2 3 3

⍝ One could convert this back to the string representation
⍝ using

      {'>}])*([{<'[5+⍵]} reduce conv line
[({([[{{

⍝ These are exactly the parens that need closing! In reverse
⍝ order, of course.

      -⌽reduce conv line
¯3 ¯3 ¯2 ¯2 ¯1 ¯3 ¯1 ¯2
      {'>}])*([{<'[5+⍵]} -⌽reduce conv line
}}]])})]

⍝ The first step however is to filter for the desired
⍝ "incomplete" entries that need autocompleting. For the test
⍝ data set, there are five of them. (Always an odd number, as
⍝ the puzzle text promised.)

      ⍴{({0=score ⍵}¨⍵)/⍵}load'10.test'
5

⍝ For scoring the autocompletion strings, the puzzle explains
⍝ how the paren sequence 2 1 3 4 -- which by sheer luck coincides
⍝ with our numerical representation! -- is converted into the
⍝ number 294. In APL, we have it easy. The digits are to be
⍝ interpreted as a base-5 number.

      5⊥2 1 3 4
294

⍝ So the autocompletion scores for the "incomplete" entries are:

      {5⊥⌽reduce conv ⍵}¨{({0=score ⍵}¨⍵)/⍵}load'10.test'
288957 5566 1480781 995444 294

⍝ If we sort that (in either direction) and retrieve the median,
⍝ we have our answer for part 2.

      {⍵[⍋⍵][⌈(⍴⍵)÷2]}{5⊥⌽reduce conv ⍵}¨{({0=score ⍵}¨⍵)/⍵}load'10.test'
288957

⍝ #

⍝ ============================================================
⍝ appendix
⍝ ============================================================

⍝ A closing remark: if you chose to implement reduction
⍝ differently, make sure to get the 8th entry from the test
⍝ file correct. It's a nice test case for the reduce function.

      8⊃input
[<(<(<(<{}))><([]([]()
      reduce conv 8⊃input
2 4 1 4 1 4 1 4 ¯1 ¯1 ¯4 4 1 1

⍝ #
