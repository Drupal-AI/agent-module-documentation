<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns Views Style — agent index

Provides a Views **style** plugin `pattern` that renders View results through a UI Patterns
component, plus a UI Patterns **source** plugin `view_style` exposing `title` + `rows`. No config
page (`configure` null), no permissions, no Drush. Depends on `views` + `ui_patterns`; optionally
uses `ui_patterns_settings`. This 1.4.x branch is for the **UI Patterns 1.x** API.

- **Selecting/using the Pattern style on a View, its options & field mapping, the source plugin,
  the template, and the update hook** → [configure/views-style.md](configure/views-style.md)

Key facts:
- Style plugin id `pattern` (`src/Plugin/views/style/Pattern.php`), `usesRowPlugin = TRUE`,
  theme `view--pattern`, `display_types = {"normal"}`.
- Options: `pattern`, `pattern_variant`, `pattern_mapping`, `pattern_settings`.
- Source plugin id `view_style` (`src/Plugin/UiPatterns/Source/ViewStyleSource.php`) → source
  fields `title` (group title, falls back to view title) and `rows` (rendered rows).
- `view--pattern.html.twig` calls `pattern(options.pattern, settings)` with fields + variant +
  context + attributes + optional settings.
- `hook_update_9101` (service `ui_patterns_views_style.updater`) migrates legacy option structure.
