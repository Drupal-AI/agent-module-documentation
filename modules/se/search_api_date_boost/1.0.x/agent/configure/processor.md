<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Date Field Boost processor

## Enable
1. Go to the Search API index (**Administration → Configuration → Search and metadata → Search API**),
   edit the index, open the **Processors** tab.
2. Enable **Date field-based boosting** (`date_field_boost`).

## Per-field settings
The processor lists every field on the index whose type is `date`. For each one:

- **Boost factor** — a dropdown of Search-API-style values (`0.00`, `0.10`, … `1.00`, … up to `21.00`).
  This is the maximum lift a future / just-now item receives. `0.00` effectively disables the field.
- **Decay period (days)** — default `30`. Larger values decay the boost more slowly for past items;
  smaller values prefer very recent items sharply.

## How the boost is computed (`preprocessIndexItems`)
For each item and configured field:
- `age_days = (now - date_value) / 86400`, using `max()` of the field's values if multivalued.
- If `age_days < 0` (future): `boost = boost_factor`.
- Else (past): `boost = boost_factor * exp(-age_days / decay_period)`, capped at `boost_factor`.
- Applied as `item->setBoost(item->getBoost() + boost)` — additive, and only when
  `decay_period > 0` and `boost_factor > 0`.

## Apply
Save the index and **re-index** so the new boosts are written into the index. Designed for the
Search API **Database** backend.
