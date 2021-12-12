⍝ day 12

⍝ ============================================================
⍝ part 1, solution
⍝ ============================================================

      load←{'-'(≠⊆⊢)¨(⎕UCS 10)(≠⊆⊢)⊃⎕NGET AoCPath,⍵}
      distinct←{((⍵⍳⍵)=⍳⍴⍵)/⍵}

∇r←n adjacency nedges
 r←(n n)⍴0
 {(y x)←⍵ ⋄ r[y;x]←r[x;y]←1}¨nedges
∇

∇r←grow path;last;cand;i;c
 r←0
 last←¯1↑path
 i←⍳⊃⍴names
 cand←((,adj[last;])∧1-small∧∨/i∘.=path)/i
 :For c :In cand
     :If c=end
         r+←1
     :Else
         r+←grow path,c
     :EndIf
 :EndFor
∇

∇r←npaths fn;edges;path0
 edges←↑load fn
 names←distinct,edges
 adj←(⊃⍴names)adjacency↓{names⍳⊂⍵}¨edges
 small←27={⎕A⍳⊃⍵}¨names
 end←names⍳⊂'end'
 path0←1⍴names⍳⊂'start'
 r←grow path0
∇

      npaths '12.test'
10
      npaths '12.example2'
19
      npaths '12.example3'
226

⍝ ============================================================
⍝ part 2, solution
⍝ ============================================================

∇r←j jgrow path;last;cand;i;c;smallish
 r←0
 →(2<+/j=path)/0
 smallish←small ⋄ smallish[j]←0
 last←¯1↑path
 i←⍳⊃⍴names
 cand←((,adj[last;])∧1-smallish∧∨/i∘.=path)/i
 :For c :In cand
     :If (2=+/j=path)∧c=end
         r+←1
     :Else
         r+←j jgrow path,c
     :EndIf
 :EndFor
∇

∇r←npaths fn;edges;path0;more
 edges←↑load fn
 names←distinct,edges
 adj←(⊃⍴names)adjacency↓{names⍳⊂⍵}¨edges
 small←27={⎕A⍳⊃⍵}¨names
 end←names⍳⊂'end'
 path0←1⍴names⍳⊂'start'
 r←grow path0
 more←(small∧1-∨⌿(path0[1],end)∘.=⍳⍴names)/⍳⍴names
 {r+←⍵ jgrow path0}¨more
∇

      npaths '12.test'
36
      npaths '12.example2'
103
      npaths '12.example3'
3509

⍝ ============================================================
⍝ guide
⍝ ============================================================

⍝ TODO
⍝ 
⍝ Part 1: building graph as adjacency matrix, and following it
⍝ from start node to end node, counting the path completions.
⍝ Small nodes are eliminated from the next-to-visit candidates
⍝ when they've been visited before.
⍝ 
⍝ Part 2:  
⍝ In addition to the count from part 1, any of the small nodes
⍝ (except start and end) are designated as "joker" nodes, and
⍝ only further path completions are counted if the joker node
⍝ occurs twice. (For that, the joker node is exempted from the
⍝ "small cave" rule.)
⍝ Function jgrow implements this; only the last two lines of
⍝ function npaths are new.
⍝ 
⍝ #
