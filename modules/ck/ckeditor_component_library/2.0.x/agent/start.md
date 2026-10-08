<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Component Library (ckeditor_component_library) — agent index

**Embed Component Library (UI Patterns) pattern variants inside CKEditor 5.**

- **Version:** 2.0.x (dev-2.0.x checkout)
- **Core:** ^10 || ^11 · requires `embedded_content`, `component_library` (+ `ui_patterns`)
- **Configure route:** `ckeditor_component_library.settings` → `/admin/structure/component-library/ckeditor-embeds` (permission `administer component library patterns` **and** `use ckeditor5 embedded content`)
- **Key code:** `ckeditor_component_library.module` (`hook_theme` → `ckeditor_component_library_embed`); embed form built per pattern property, overridable via an `Embed Config Form Settings` JSON blob.

**Security:** single admin config route gated by a compound permission; no anonymous or mutating endpoints. Rendered output safety depends on the referenced Component Library templates and the CKEditor 5 text-format / Embedded Content filter setup.

See [configure/embeds.md](configure/embeds.md)