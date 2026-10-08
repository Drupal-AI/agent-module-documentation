<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remove Trailing Zeros (rtz) — agent index

Field **formatter** stripping trailing zeros from decimal/float fields (`12.50`→`12.5`, `12.00`→`12`).
Version **2.0.4**. Core `>=8`. Display-only (stored scale unchanged).

Set as the field's display formatter. Suits measurements/quantities/ratings — usually **not**
currency (where `12.50` is wanted).