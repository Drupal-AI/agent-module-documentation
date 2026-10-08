<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Paragraphs Theme Extension (layout_paragraphs_theme_extension) — agent index

**Loads default-theme paragraph templates + an optional CSS/JS library into the Layout Paragraphs builder for editor/front-end parity.**

- **Version:** 1.1.x
- **Core:** ^11 || ^12
- **Dependencies:** layout_paragraphs:layout_paragraphs, paragraphs:paragraphs
- **Hooks (OOP `#[Hook]`):** `theme_registry_alter` (copies default-theme `paragraph`/`paragraph__<type>` + additional templates over the active theme; static re-entry guard), `element_info_alter` (pre-render attaches library to `layout_paragraphs_builder`)
- **Route/task:** `layout_paragraphs_theme_extension.settings` → `/admin/config/content/layout_paragraphs/default-theme` (perm `administer site configuration`)
- **Config:** `layout_paragraphs_theme_extension.settings` → `display_default_theme`, `default_theme_library`, `additional_templates`
- **Security:** Admin config route permission-gated; no mutating/anonymous endpoints. Library + template names are trusted admin input; only pre-existing default-theme registry entries are copied (no arbitrary path loading). Rebuild caches after config changes.

See [configure/settings.md](configure/settings.md)