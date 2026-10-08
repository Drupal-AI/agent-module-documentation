<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Y LB Table (lb_table) — agent index

Table **block type** for YMCA Layout Builder pages. Version **1.1.0**. Core `^10 || ^11`.
Depends on `text`, `block_content`, **`datalayer`**, **`y_lb`**.

Two things decide whether a table is usable, and a block type lets them be handled once: **real
header cells with `scope`** (a screen reader announces context rather than a stream of values), and
a **deliberate responsive strategy** (scrolling preserves comparison, stacking destroys it).

The `datalayer` dependency implies table interactions are reported to analytics — a data-collection
decision as much as a measurement one.

**Documented from source — cannot be enabled.** `ycloudyusa/y_lb` on Packagist is only **0.1
(2022, `^8 || ^9`)**; current releases are in the YMCA's own composer repository. Requires `y_lb`
with **no version constraint**, so composer took the stub and it failed at enable time. See
`modules/y_/y_lb`.