⍝ day 2: Dive!

      u←'forward 5' 'down 5' 'forward 8' 'up 3' 'down 8' 'forward 2'

      forward←1 0
      down←0 1
      up←0 ¯1

      ×/⊃+/{(⍎¨2⊃¨⍵)×⍎¨⊃¨⍵}' '(≠⊆⊢)¨u
150
      ×/⊃+/{(⍎¨2⊃¨⍵)×⍎¨⊃¨⍵}' '(≠⊆⊢)¨ ,¯1↓LoadTEXT AoCPath,'02.test'
150

∇step s;n;args
 args←' '(≠⊆⊢)s
 n←⍎⊃args[2]
 :Select ⊃args[1]
 :Case 'down'
     aim←aim+n
 :Case 'up'
     aim←aim-n
 :Case 'forward'
     x←x+n
     depth←depth+aim×n
 :EndSelect
∇

∇r←run s
 x←aim←depth←0
 step¨s
 r←x×depth
∇

      run ,¯1↓LoadTEXT AoCPath,'02.test'
900
