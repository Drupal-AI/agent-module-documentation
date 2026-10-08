<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the "Pattern" Views style

No settings page — configuration lives entirely on the View display. Requires `ui_patterns`
(1.x) providing at least one pattern; optionally `ui_patterns_settings` for per-pattern settings.

## Enable it on a View

1. Edit a View → a display → **Format** → *Settings* → choose **Pattern**.
2. In the style settings (built by UI Patterns' `PatternDisplayFormTrait`):
   - **Pattern** — the component to render each group with.
   - **Variant** — the pattern variant (stored as `pattern_variant`).
   - **Field mapping** — map the available sources onto pattern destinations. This style's source
     plugin `view_style` offers two sources: **title** and **rows**. Set each to a pattern slot,
     or `_hidden` to drop it.
   - **Pattern settings** — only shown/applied when `ui_patterns_settings` is enabled.
3. Because the style uses a row plugin (`usesRowPlugin = TRUE`), also configure the **Row style**
   (Fields, or an entity row) as usual — those rows become the `rows` source.

## Style option keys (`defineOptions`)

| Option | Meaning |
|---|---|
| `pattern` | Selected pattern id. |
| `pattern_variant` | Selected variant. |
| `pattern_mapping` | `source => { destination, weight, plugin, source }` map. |
| `pattern_settings` | Per-pattern settings keyed by pattern id. |

An `#element_validate` (`Pattern::cleanSettings`) runs UI Patterns' `processFormStateValues()` to
normalise submitted settings.

## What render() produces

For each Views group, `Pattern::render()` sets on the group build:
`#options['pattern']`, `#options['variant']`, and `#options['context']` = a
`PatternContext('views_style', ['view_name' => id, 'display' => current_display, 'view' => storage])`.
It then fills `#options['fields']` from the mapping:

- source `title` → `group['#title']` (falls back to `$this->view->getTitle()`),
- source `rows` → `group['#rows']`.

If `ui_patterns_settings` is enabled and settings exist for the pattern,
`#options['settings']` = `UiPatternsSettings::preprocess(...)`.

## Template

`templates/view--pattern.html.twig` (theme hook `view--pattern`) merges `options.fields` with the
variant, `context`, wrapper `attributes`, and `options.settings`, then calls:

```twig
{{ pattern(options.pattern, pattern_settings) }}
```

Override this template in your theme to change how the pattern is invoked.

## Source plugin

`view_style` (`ViewStyleSource extends PatternSourceBase`, tag `view_style`) declares the two
mappable source fields via `getSourceFields()`: `title` and `rows`.

## Update hook

`ui_patterns_views_style_update_9101()` (delegates to service
`ui_patterns_views_style.updater` → `update9101()`) rewrites any `views.view.*` display whose
style type is `pattern` from the legacy `variants` + nested `pattern_mapping` structure to the
current `pattern_variant` + flat `pattern_mapping` shape. Run via `drush updatedb`.
