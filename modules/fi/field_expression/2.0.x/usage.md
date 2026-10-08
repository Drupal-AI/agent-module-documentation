<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Expression Field adds a field whose value is computed from an expression containing tokens, rather than entered by a person.

---

Derived values are everywhere in a content model: a display title assembled from three fields, a total from a quantity and a price, a sort key normalised from a date, a slug built from a name. Storing them means asking editors to keep them in step by hand, which they will not; computing them at render time means they cannot be sorted or filtered on.

An expression field is the middle path — the value is derived from an expression the site builder writes, using tokens for the other fields, and stored so Views can sort and filter on it.

Two things to be deliberate about. **When the expression is evaluated** decides whether the value can go stale: a field computed on save will not update when a referenced entity changes, and whether that matters depends on what the expression reads. And **what an expression can reach** is worth checking on a site where the person configuring fields is not fully trusted — tokens can expose more than the immediate entity, and an expression facility is exactly the sort of feature where the boundary deserves a look rather than an assumption.

Used for what it is good at — a computed display value, a sortable derived key — it removes a class of data-entry error entirely, because the value cannot be wrong relative to its inputs.

---

- Compute a display title from several fields.
- Derive a sortable key from a date.
- Calculate a total from quantity and price.
- Build a slug from a name field.
- Stop editors maintaining derived values by hand.
- Make a computed value sortable in Views.
- Filter on a derived field.
- Use tokens from the current entity.
- Decide when the expression is evaluated.
- Handle a value going stale after a reference changes.
- Check what tokens an expression can reach.
- Remove a class of data-entry error.
- Keep derivation logic in configuration.
- Document an expression for future maintainers.
- Audit fields with computed values.