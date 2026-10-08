<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Y LB Branch Amenities (lb_branch_amenities_blocks) — agent index

Block displaying the **amenities at a branch** — pool, gym, childcare.
Version **3.0.0**. Core `^10 || ^11`.
Depends on `paragraphs`, `y_lb`, `blazy`, `media`, `media_library`.

Structured icon-and-label data rather than prose — which is what lets the same data drive location
**filtering** elsewhere, and keeps presentation consistent across dozens of branch pages.

**Documented from source — cannot be enabled. Verified:** `ycloudyusa/y_lb` resolves to **0.1
(2022)**, `^8 || ^9`, and Drupal reports it incompatible with core 11. The real `y_lb` is in the
YMCA composer repository. Requires `y_lb` with **no version constraint**, so composer accepted the
stub.