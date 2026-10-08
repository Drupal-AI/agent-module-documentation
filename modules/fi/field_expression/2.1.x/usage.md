<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Expression Field adds field types whose value is computed from a mathematical expression containing tokens, rather than entered by a person. The expression is parsed by a safe math evaluator (webit/eval-math), not by PHP eval().

---

Derived values are everywhere in a content model: a total from a quantity and a price, a sortable key normalised from a date, a display number assembled from several fields. Storing them means asking editors to keep them in step by hand, which they will not; computing them at render time means they cannot easily be sorted or filtered on.

An expression field is the middle path — the value is derived from an expression the site builder writes, using tokens for the other fields, and stored so Views can sort and filter on it. 2.1 broadens the original single string field into a family: a base `field_expression` string field plus typed numeric variants (`expression_integer`, `expression_decimal`, `expression_float`) that extend core's own number field types, so their stored value formats and sorts like a real number.

Expressions support the operators `+ - * / ^ %` (`^` is exponentiation, `%` is modulo) and a fixed set of single-argument math functions (`sin`, `cos`, `sqrt`, `abs`, `ln`, `log`, and their inverses/hyperbolics). The numeric field types also let you assign variables and define your own multi-argument functions across several `;`-separated statements (e.g. `min(a,b) = (a+b-abs(a-b))/2; min(3,5)`). Tokens in the expression are replaced by the token module when the entity is saved; per-token defaults can be supplied in curly braces (`[node:field_x]{100}`) and unresolved tokens optionally fall back to zero.

Two things to be deliberate about. **When the expression is evaluated** decides whether the value can go stale: it is computed on save by default, and a field that reads a referenced entity will not update when that entity changes — the formatter's "Always Evaluate" option recomputes on every render at a performance cost. And **what an expression can reach**: tokens can expose more than the immediate entity, so on a site where whoever configures fields is not fully trusted the token boundary deserves a look — though the math evaluator itself is sandboxed and cannot execute arbitrary PHP.

Used for what it is good at — a computed, sortable numeric value — it removes a class of data-entry error entirely, because the value cannot be wrong relative to its inputs.

---

- Compute a total from a quantity field and a price field.
- Store a derived value as a real integer for sorting in Views.
- Store a derived value as a decimal for currency-style display.
- Derive a sortable numeric key from other fields.
- Assign variables and reuse them across `;`-separated statements.
- Define your own multi-argument function (e.g. min/max) inside an expression.
- Provide a per-token default with `[node:field_x]{100}`.
- Default unresolved tokens to zero instead of breaking the expression.
- Suppress evaluation errors so a bad expression yields a blank value.
- Debug an expression's token replacement and result via the Devel module.
- Make a computed value sortable and filterable in Views.
- Stop editors maintaining derived values by hand.
- Recompute a value on every render when its referenced content may change.
- Use exponentiation (`^`) or modulo (`%`) in a stored calculation.
- Apply trig / logarithmic functions to field inputs.
- Keep derivation logic in field configuration rather than code.
- Remove a class of data-entry error entirely.
- Audit fields with computed values.
- Check what tokens an expression can reach on a multi-role site.
- Document an expression for future maintainers.
