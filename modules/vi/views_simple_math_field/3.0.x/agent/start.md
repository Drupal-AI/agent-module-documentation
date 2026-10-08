<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Simple Math Field — agent index

Adds a **"Global: Simple Math Field"** Views field (`field_views_simple_math_field`) that computes
a value from a formula over other fields in the same view, plus a matching sort handler
(`views_simple_math_field_sort`). No admin page (`configure: null`), no permissions, no Drush, no
plugin types. All configuration is per-field, stored inside the view config.

- **Add & configure the field in a view, formula token syntax, mute_logs, and the sort handler** →
  [configure/field.md](configure/field.md)

Key facts:
- Field id `field_views_simple_math_field`, group **Global** (`#global` join, works in any view).
- Formula references chosen fields by `@<field_id>` tokens; evaluated with the
  `andileco/eval-math` (`EvalMath`) library. Requires that Composer dependency.
- Per-field options (in the view): `fieldset_one.data_field` (which fields feed the formula),
  `fieldset_one.formula` (the expression), `mute_logs` (silence division-by-zero logging).
- The value is computed in PHP at render time (`getValue()`), not in SQL; the sort handler sorts
  rows in PHP (`postExecute`).
