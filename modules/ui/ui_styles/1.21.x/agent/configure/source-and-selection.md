<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Source plugins and how a selection is stored

The base module has **no settings form and `configure: null`**. "Configuration" here means
(a) which widget a style uses to pick an option, and (b) the tiny data structure each
integration stores.

## Source plugins (the widget)

`plugin.manager.ui_styles.source` discovers **Source** plugins from
`src/Plugin/UiStyles/Source/` (attribute `Drupal\ui_styles\Attribute\Source`). The base
module ships three, chosen automatically per style via `getApplicableSourcePlugin()`:

| id | class | widget | when applicable |
|---|---|---|---|
| `select` | `Source\Select` | a `<select>` of the options | default / any style |
| `checkbox` | `Source\Checkbox` | one checkbox per option | style with a single option |
| `toolbar` | `Source\Toolbar` | button/toolbar of options with icons | styles designed for icons |

Each Source implements `SourceInterface`: `isApplicable(StyleDefinition)` and
`getWidgetForm(StyleDefinition, string $selected)`. You add a new widget by dropping a
plugin in `src/Plugin/UiStyles/Source/` of your module. `empty_option` supplies the
"- None -" choice.

## The selection data structure

Every integration stores a builder's choices with the shared config-schema type
**`ui_styles.selected_mapping`**:

```yaml
selected:            # sequence: the chosen CSS classes, keyed by style plugin id
  text_color: text-primary
  spacing: p-3
extra: 'my-custom-class another-class'   # free-text extra classes (space separated)
```

- `selected` — a map of *style plugin id → chosen option class*. Only styles with a
  non-empty choice are kept.
- `extra` — an escape hatch string of additional classes, split on spaces at render time.

The `ui_styles_styles` form element (see [../api/apply-styles.md](../api/apply-styles.md))
produces exactly this `{ selected, extra }` array as its value; each submodule then persists
it in its own config location, e.g.:

- `ui_styles_block`: `block.block.<id>` → `third_party_settings.ui_styles.{block,title,content}`
- `ui_styles_layout_builder`: section `third_party_settings.ui_styles.{selected,extra,regions}`
- `ui_styles_page` / `ui_styles_entity_status`: `<theme>.settings` →
  `third_party_settings.ui_styles_page.regions` / `.ui_styles_entity_status.unpublished`
- `ui_styles_views`: `display_options.display_extenders.ui_styles.{style,pager,exposed_form}_options`
- `ui_styles_ui_patterns`: a `ui_styles_attributes` source setting with `styles` + `extra`

See each submodule's docs for the exact path.
