⍝ day 15: Chiton

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

     load←{↑{⍎¨,⍵}¨(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}

∇r←coma m;h;i;j
 h←1↑⍴m
 r←(h,h)⍴0
 r[;h]←⊖+⍀⊖m[;h]
 r[h;]←⌽+\⌽m[h;]
 :For i :In ⌽⍳¯1+h
     r[i;i]←i pivot i
     :If i>1
         :For j :In ⌽⍳¯1+i
             r[i;j]←i pivot j
             r[j;i]←j pivot i
         :EndFor
     :EndIf
 :EndFor
∇

∇s←y pivot x
 s←m[y;x]+r[y+1;x]⌊r[y;x+1]
∇

      {((coma ⍵)[1;1])-⍵[1;1]} load '15.test'
40

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

      phase←{1+9|⍵+¯1+⍺}

      small←load '15.test'
      big←⊃,[1]/,/{⍵ phase small}¨(¯1+⍳5)∘.+(¯1+⍳5)

      {((coma ⍵)[1;1])-⍵[1;1]}big
315

⍝ ============================================================
⍝ guide
⍝ ============================================================

⍝ TODO

⍝ Part 2: a bigger playing field.

      q←3 3⍴⍳9
      q
1 2 3
4 5 6
7 8 9
      {1+9|q+¯1+⍵}1
2 3 4
5 6 7
8 9 1
      {1+9|q+¯1+⍵}2
3 4 5
6 7 8
9 1 2
      {1+9|q+¯1+⍵}5
6 7 8
9 1 2
3 4 5

      DISPLAY {⍵ phase q}¨v∘.+v←¯1+⍳5
┌→────────────────────────────────────────┐
↓ ┌→────┐ ┌→────┐ ┌→────┐ ┌→────┐ ┌→────┐ │
│ ↓1 2 3│ ↓2 3 4│ ↓3 4 5│ ↓4 5 6│ ↓5 6 7│ │
│ │4 5 6│ │5 6 7│ │6 7 8│ │7 8 9│ │8 9 1│ │
│ │7 8 9│ │8 9 1│ │9 1 2│ │1 2 3│ │2 3 4│ │
│ └~────┘ └~────┘ └~────┘ └~────┘ └~────┘ │
│ ┌→────┐ ┌→────┐ ┌→────┐ ┌→────┐ ┌→────┐ │
│ ↓2 3 4│ ↓3 4 5│ ↓4 5 6│ ↓5 6 7│ ↓6 7 8│ │
│ │5 6 7│ │6 7 8│ │7 8 9│ │8 9 1│ │9 1 2│ │
│ │8 9 1│ │9 1 2│ │1 2 3│ │2 3 4│ │3 4 5│ │
│ └~────┘ └~────┘ └~────┘ └~────┘ └~────┘ │
│ ┌→────┐ ┌→────┐ ┌→────┐ ┌→────┐ ┌→────┐ │
│ ↓3 4 5│ ↓4 5 6│ ↓5 6 7│ ↓6 7 8│ ↓7 8 9│ │
│ │6 7 8│ │7 8 9│ │8 9 1│ │9 1 2│ │1 2 3│ │
│ │9 1 2│ │1 2 3│ │2 3 4│ │3 4 5│ │4 5 6│ │
│ └~────┘ └~────┘ └~────┘ └~────┘ └~────┘ │
│ ┌→────┐ ┌→────┐ ┌→────┐ ┌→────┐ ┌→────┐ │
│ ↓4 5 6│ ↓5 6 7│ ↓6 7 8│ ↓7 8 9│ ↓8 9 1│ │
│ │7 8 9│ │8 9 1│ │9 1 2│ │1 2 3│ │2 3 4│ │
│ │1 2 3│ │2 3 4│ │3 4 5│ │4 5 6│ │5 6 7│ │
│ └~────┘ └~────┘ └~────┘ └~────┘ └~────┘ │
│ ┌→────┐ ┌→────┐ ┌→────┐ ┌→────┐ ┌→────┐ │
│ ↓5 6 7│ ↓6 7 8│ ↓7 8 9│ ↓8 9 1│ ↓9 1 2│ │
│ │8 9 1│ │9 1 2│ │1 2 3│ │2 3 4│ │3 4 5│ │
│ │2 3 4│ │3 4 5│ │4 5 6│ │5 6 7│ │6 7 8│ │
│ └~────┘ └~────┘ └~────┘ └~────┘ └~────┘ │
└∊────────────────────────────────────────┘

      DISPLAY ⊃,[1]/,/{⍵ phase q}¨v∘.+v←¯1+⍳5
┌→────────────────────────────┐
↓1 2 3 2 3 4 3 4 5 4 5 6 5 6 7│
│4 5 6 5 6 7 6 7 8 7 8 9 8 9 1│
│7 8 9 8 9 1 9 1 2 1 2 3 2 3 4│
│2 3 4 3 4 5 4 5 6 5 6 7 6 7 8│
│5 6 7 6 7 8 7 8 9 8 9 1 9 1 2│
│8 9 1 9 1 2 1 2 3 2 3 4 3 4 5│
│3 4 5 4 5 6 5 6 7 6 7 8 7 8 9│
│6 7 8 7 8 9 8 9 1 9 1 2 1 2 3│
│9 1 2 1 2 3 2 3 4 3 4 5 4 5 6│
│4 5 6 5 6 7 6 7 8 7 8 9 8 9 1│
│7 8 9 8 9 1 9 1 2 1 2 3 2 3 4│
│1 2 3 2 3 4 3 4 5 4 5 6 5 6 7│
│5 6 7 6 7 8 7 8 9 8 9 1 9 1 2│
│8 9 1 9 1 2 1 2 3 2 3 4 3 4 5│
│2 3 4 3 4 5 4 5 6 5 6 7 6 7 8│
└~────────────────────────────┘

⍝ TODO
