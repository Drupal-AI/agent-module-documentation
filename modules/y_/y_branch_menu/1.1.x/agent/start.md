<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Y Branch Menu (y_branch_menu) — agent index

**Single-level sub-menu** within a branch page and its sub-pages.
Version **1.1.1**. Core `^10 || ^11`. Depends on `y_lb`.

Scopes navigation to the location — a visitor on a branch page wants that branch's schedule and
programmes, not the organisation's global menu. **Single level is deliberate:** branch content is
shallow, and nested sub-navigation inside a site menu is unholdable.

**Documented from source — cannot be enabled. Verified:** `ycloudyusa/y_lb` on Packagist is only
**0.1 (2022)**, `^8 || ^9`, so Drupal reports it incompatible. Current `y_lb` is in the YMCA's own
composer repository. This module requires `y_lb` with **no version constraint**, which is why
composer accepted the stub and the failure appeared at enable time.