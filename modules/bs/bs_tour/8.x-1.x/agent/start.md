<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# D8: Bootstrap Tour (`bs_tour`) — agent index
**Popover-based guided site tours via the Bootstrap Tour JS plugin, rendered as a block.**

- **Version:** 8.x-1.x  | **Core:** ^8 || ^9 || ^10
- **Configure:** `/admin/config/user-interface/bs-tour` (`bs_tour.admin`)
- **Permission:** `administer bs tour` (restrict access: TRUE)
- **Block:** `BSTourBlock`. Library assets in `assets/`, declared in `bs_tour.libraries.yml`.

**Security:** admin config gated by a dedicated restricted permission; output is a JS tour block. No findings.
