<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Geofield (wisski_geofield) — agent index

Submodule of **wisski**. A **single field for latitude and longitude**.
Version **8.x-4.3**. Core `>=10.4 <12`.

Small modelling decision, real data-quality effect: two number fields means two chances to enter
one and forget the other, and no coherence validation.

**Two things to state whenever coordinates are collected:**

1. **Precision is a claim.** Six decimal places asserts sub-metre accuracy. If the source was a map
   reference or a town centre, that claim is false and will be believed downstream.
2. **Coordinates can be sensitive** — archaeological findspots, protected species, culturally
   significant sites. Publishing precise location is a real-world harm (looting, disturbance,
   trespass). Decide publication precision **per category**, deliberately.