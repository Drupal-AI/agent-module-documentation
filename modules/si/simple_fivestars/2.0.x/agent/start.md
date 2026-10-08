<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Fivestars (simple_fivestars) — agent index

**A `fivestars` form element plus field widget and formatter for entering and displaying 0–5 star ratings on numeric fields.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10
- **Plugins:** `@FormElement('fivestars')`; `@FieldWidget(id='fivestars')` and `@FieldFormatter(id='fivestars')` for `integer`/`decimal`/`float` fields.
- **Widget setting:** `hide_label`.
- **Theme:** `fivestars` (`fivestars.html.twig`); preprocess sets fill width `number*2*10`%.
- **Library:** `simple_fivestars/main` (CSS + star SVGs).

**Security:** Field widget/formatter, not a public voting endpoint. Values are stored on entity fields and edited via ordinary entity forms — Form-API CSRF-protected and gated by entity/field access; no anonymous submission route, so no vote-stuffing/CSRF surface. Generated radio markup uses only numeric (0–5) values and the element id — no untrusted output. No security findings.

See [extend/fivestars.md](extend/fivestars.md)
