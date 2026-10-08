<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# unlimited_number — agent start

Provides an "Unlimited or a specific number" control in two forms:

1. A Form API **render element** — `#type => unlimited_number` — two radios ("Unlimited" /
   "Limited"); picking "Limited" reveals an inline `#type => number`. Submits either the
   string `'unlimited'` (constant `UnlimitedNumber::UNLIMITED`) or the entered integer.
2. A **field widget** — id `unlimited_number`, label "Unlimited or Number" — for **integer**
   fields, that stores "unlimited" as a configurable integer (`value_unlimited`, default `0`).

No admin UI, no permissions, no Drush. The only config surface is the widget's settings on an
entity form display. Config schema exists for `field.widget.settings.unlimited_number`.

- **Use the `#type => unlimited_number` render element in a custom form (properties, return value, validation)** → [api/unlimited_number.md](api/unlimited_number.md)
- **Use the "Unlimited or Number" field widget on an integer field (settings, how unlimited is stored, config)** → [plugins/unlimited_number.md](plugins/unlimited_number.md)

Facts an agent needs up front:
- The element/widget only makes sense for **integer** values; the widget declares
  `field_types = {"integer"}`.
- "Unlimited" is the **string** `'unlimited'` at the element level, but the widget converts it
  to the integer `value_unlimited` (default `0`; set it to `-1` for core cardinality style).
- Choosing "Limited" makes the number **required** — the element errors if left blank.
- The element renders empty via `renderInIsolation` on a bare element (its radios need full
  form processing); exercise it through a real form build, not in isolation.
