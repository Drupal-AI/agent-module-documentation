<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Y LB Branch Social Links (lb_branch_social_links_blocks) — agent index

Block type for a **location's own social accounts** (not the organisation's).
Version **1.0.7**. Core `^10 || ^11`.
Depends on `paragraphs`, `y_lb`, `link`, **`link_attributes`**.

`link_attributes` is the detail worth noting: these are outbound links usually opening in a new
tab, and `target="_blank"` without `rel="noopener"` hands the opened page a handle on yours.
Per-link attributes let that be **set** rather than remembered.

**Documented from source — cannot be enabled. Verified:** `y_lb` resolves to the **0.1 (2022)**
Packagist stub (`^8 || ^9`); the real one is in the YMCA composer repository. Requires `y_lb` with
**no version constraint**.