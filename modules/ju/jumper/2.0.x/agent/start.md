<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Jumper (jumper) — agent index

**Configurable smooth-scrolling block (jump-to-top / jump-anywhere) using native scrolling or optional Jump.js.**

- **Version:** 2.0.x
- **Core:** >=9.4
- **Dependencies:** drupal:block, blazy:blazy (>= 3.x) — Blazy used only for shared JS helpers
- **Block plugin:** `jumper_block` (category "Jumper")
- **Libraries:** `jumper/load` (vanilla JS, requestAnimationFrame + debounce); optional `jumper/jump` if Jump.js at `/libraries/jump/dist/jump.min.js`
- **Config:** block settings (target, duration, offset, icon, color, style, visibility, selectors, ootb, autovlm)
- **Security:** No routes, permissions, services, or server-side data handling. Settings are trusted block-admin config; `build()` strips tags from target/text (only `<span>` allowed). Client-side scrolling only.

See [configure/block.md](configure/block.md)