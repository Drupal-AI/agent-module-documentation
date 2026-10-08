<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Block: Headings Menu (vlsuite_block_headings_menu) — agent index

Nested submodule of **vlsuite_block**. **In-page navigation generated from headings**.
Version **2.3.3**. Core `^10.3 || ^11`.
Pulled in by both `vlsuite_shuttle` and `vlsuite_demo` — the project treats it as baseline.

Removes the maintenance of a hand-written anchor list: the menu reflects what is on the page and
reorders when sections do.

**Strongest argument is accessibility** — screen reader users navigate by heading structure anyway.
Which also makes it a **diagnostic**: if editors use headings for visual size rather than
structure, the generated menu shows it.