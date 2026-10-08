<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Language Display (language_display) — agent index

**Field formatters showing an entity's original language and translation count, plus a node view-builder override for language-aware display.**

- **Version:** 2.1.x (2.1.0-alpha1 — treat as alpha)
- **Core:** ^9 || ^10 || ^11
- **Dependency:** core `language`.
- **Plugins:** FieldFormatters `OriginalLanguageFormatter`, `OriginalLanguageTranslationCounterFormatter`.
- **Override:** `hook_entity_type_alter()` sets node view builder to `LanguageDisplayNodeViewBuilder`.
- **Library:** `language_display` CSS.

**Security:** display-only formatters and a view-builder override; no routes, permissions, or user input handling — no findings. (README notes an old core-patch dependency; verify on your core version.)