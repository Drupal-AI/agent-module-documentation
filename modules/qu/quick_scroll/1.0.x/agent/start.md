<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quick Scroll (quick_scroll) — agent index

**Attaches a site-wide scroll-to-top button by loading its JS/CSS library on every page.**

- **Version:** 1.0.x · **Package:** User interface
- **Core:** ^10.3 || ^11 · **Dependencies:** none (core only)
- **Mechanism:** `Drupal\quick_scroll\Hook\QuickScrollHooks::preprocessHtml()` (`#[Hook('preprocess_html')]`) attaches library `quick_scroll/quick_scroll` (js `js/quick_scroll.js`, css `css/quick_scroll.css`; deps `core/drupal`, `core/once`).
- **Config/routes/permissions:** none.

**Security:** no routes, permissions, forms, or mutating endpoints; front-end asset attachment only. No security findings.