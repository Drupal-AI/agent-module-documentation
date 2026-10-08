<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expression Field (field_expression) — agent index

Field whose value is **computed from a token expression**. Version **2.0.3**.
Core `^9 || ^10 || ^11`. Depends on `token`.

The middle path between hand-maintained derived values (which drift) and render-time computation
(which cannot be sorted or filtered).

**Two things to settle:**

1. **When the expression is evaluated** decides whether the value goes stale — a field computed on
   save will not update when a referenced entity changes.
2. **What an expression can reach.** Tokens can expose more than the immediate entity. On a site
   where whoever configures fields is not fully trusted, check that boundary rather than assume
   it.