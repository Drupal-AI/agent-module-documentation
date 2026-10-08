<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Computed Field adds a Views field whose value is a formula over the other fields in the view — `(field_price * field_quantity) - field_discount` — evaluated per row in PHP after the other fields have rendered.

---

Views can display fields and, with effort, sort on them, but it cannot easily show a *derived* value: a line total, a percentage, a running combination of columns. The usual workarounds are a computed field on the entity (which then exists everywhere, not just in this view) or a preprocess hook (code for what should be configuration). This module makes the derived value a Views field you configure in the UI: add **Global: Computed field**, then write a **Formula** that references the other fields by their machine names. The evaluation choice is the thing to note, and it is the right one — the formula is **not** run through `eval()`. It is evaluated with **Symfony's ExpressionLanguage**, which can only call functions explicitly registered with it; this module registers just **`round`** and **`ceil`**, so a formula cannot reach arbitrary PHP. Field names in the formula are validated against the view's actual fields before evaluation, and each field value is coerced to a number first (empty values become `0` when *hide empty fields* is on). ExpressionLanguage's operators are available — arithmetic (`+ - * / % **`), comparisons, logic, and the ternary `cond ? a : b` — so conditional pricing and the like work; only `round`/`ceil` are usable as functions (`floor`/`min`/`max`/`avg` are **not** registered and will error). Options cover empty-value handling and error handling (show the error, render `0`, or hide the field). Because the value is computed in PHP at render time from other rendered fields, it is display-only — it cannot be sorted or filtered in the database. Writing a formula requires the permission to administer the view.

---

- Compute a line total (`price * quantity`) in a view.
- Multiply two fields per row.
- Subtract a discount field from a subtotal.
- Show a derived percentage or ratio.
- Apply conditional pricing with a ternary (`qty > 10 ? price * 0.9 : price`).
- Round a computed result to N decimals with `round(value, 2)`.
- Round a value up with `ceil()`.
- Calculate a value without writing a preprocess hook.
- Avoid an entity-level computed field for a one-view calculation.
- Combine several fields in one formula.
- Treat empty fields as zero in the calculation.
- Choose to show, zero-out, or hide the field on an error.
- Keep formula evaluation sandboxed (ExpressionLanguage, not `eval()`).
- Configure the formula entirely in the Views UI.
- Reference source fields by their machine name.
- Order the computed field after the fields it uses.
- Add a subtotal or grand-total column to a report view.
- Restrict formula editing to users who administer views.
- Accept that the result is display-only (no DB sort/filter).
- Keep derived logic in the view instead of the entity.
