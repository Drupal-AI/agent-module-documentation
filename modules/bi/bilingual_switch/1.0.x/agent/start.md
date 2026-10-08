<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bilingual Switch (bilingual_switch) — agent index
**A block rendering one link that toggles between the two languages of a bilingual site (renders nothing if not exactly two).**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10 — depends on `language`.
- **Plugin:** Block `bilingual_switch` (`BilingualSwitchBlock`), category Multilingual.
- **Config:** per-block `bilingual_language_switch_prefix` (default "Switch to").
- **Behavior:** `build()` returns `[]` unless exactly two interface language-switch links exist; `blockAccess()` requires `isMultilingual()`; `getCacheMaxAge()` = 0.
- **Security:** presentational block only; access limited to multilingual sites; no routes, permissions, or mutating endpoints. No security findings.
