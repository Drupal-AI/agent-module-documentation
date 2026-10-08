<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Address — agent index

Provides a **simple address field** — uniform layout for all countries, **no validation** (vs the full
Address module's per-country formatting/validation). Depends on core `field`. Version **1.0.x** (dev). Core
`^8||^9||^10||^11`.

Fields/content — address is user input (escape on output). **No validation** — suits informal collection,
not shipping/billing where validation matters. No access role.
