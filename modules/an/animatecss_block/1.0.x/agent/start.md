<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AnimateCSS Block (animatecss_block) — agent index

**Assigns Animate.css animations to Drupal blocks** through the AnimateCSS module's UI.

- **Version:** 1.0.x
- **Core:** `^8.8 || ^9 || ^10 || ^11`  · package Animate CSS
- **Requires:** `drupal:block`, `animatecss:animatecss_ui`.
- **Route:** `animatecss_block.settings` (`/admin/config/user-interface/animatecss/settings/block`, permission `administer animate css block`).
- **Service:** `animatecss_block.helper` (`AnimateCssBlockHelperService`) — registers selectors with `animatecss.animate_manager`, reads the `{animatecss}` table.

**Security:** settings route gated by the module's own `administer animate css block` permission; no anonymous or mutating public endpoints. The `{animatecss}` lookups use parameterized queries (`:selector` placeholder), not string concatenation. No security findings.

See [configure/block-animation.md](configure/block-animation.md)
