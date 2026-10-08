<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Remove Trailing Zeros is a field formatter that strips trailing zeros from decimal and float field values, so 12.50 displays as 12.5 and 12.00 as 12.

---

Decimal and float fields store a fixed scale — a price field might be `decimal(10,2)` — so a whole-number value renders as `12.00` and a half as `12.50`. That is often not how you want numbers shown: a measurement, a rating, a quantity usually reads better without the padding zeros. Core's formatters do not offer that, so the usual fix is a template override or a preprocess.

This module makes it a formatter option: set Remove Trailing Zeros as the field's display formatter and `12.00` becomes `12`, `12.50` becomes `12.5`, while `12.55` is unchanged. It is display-only — the stored value keeps its scale, only the rendering changes — which makes it low-risk and broadly reusable on any decimal or float field.

It is a small, single-purpose formatter. The main thing to confirm is that stripping trailing zeros is right for the field: for a currency amount you usually *want* `12.50`, so this suits measurements, quantities and ratings more than prices.

---

- Strip trailing zeros from a decimal.
- Show 12.5 instead of 12.50.
- Show 12 instead of 12.00.
- Format a measurement cleanly.
- Format a rating without padding.
- Remove padding zeros in display.
- Keep the stored scale intact.
- Format a quantity field.
- Display floats naturally.
- Avoid a template override.
- Apply as a field formatter.
- Clean up decimal display.
- Reuse across decimal fields.
- Confirm it suits the field.
- Avoid on currency fields.
- Render a weight without zeros.
- Show a percentage cleanly.
- Format a score.
- Keep display-only behavior.
- Tidy numeric output.