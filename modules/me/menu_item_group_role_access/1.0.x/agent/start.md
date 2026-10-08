<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Item Group Role Access — agent index

**Manages menu-item visibility by group and role**, with an option to **overwrite (ignore) the menu target's
access check**. Depends on core `menu_link_content`, `menu_ui`, `group`. Provides permissions. Version **1.0.x**
(dev). Core `^9.5||^10||^11`.

Governs whether the **link shows**, not target access — menu visibility is **not a security boundary** (target
enforces its own access). The "overwrite target access" option can **disclose links/titles** of content the user
still can't open (click → 403). Use deliberately; it does not change target access.
