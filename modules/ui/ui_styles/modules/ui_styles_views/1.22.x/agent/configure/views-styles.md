<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style a view's parts

Enable with `drush en ui_styles_views` (needs `views` + `ui_styles`).

## Display extender registration

`Drupal\ui_styles_views\Plugin\views\display_extender\Styles` is a
`#[ViewsDisplayExtender(id: 'ui_styles', … no_ui: FALSE)]`. Display extenders must be turned on
globally: `ui_styles_views_install()` appends `ui_styles` to `views.settings` →
`display_extenders`; uninstall removes it. After that the extender's options appear on every
view display in the Views UI (under the display's "advanced"/other section — id `ui_styles`).

## The three sections

`buildOptionsForm()` (only when `$form_state->get('section') == 'ui_styles'`) shows a
`ui_styles_styles` element per applicable section:

| section id | title | applies when |
|---|---|---|
| `exposed_form_options` | Exposed form | always (non entity-ref / non response display) |
| `style_options`        | Style        | always |
| `pager_options`        | Pager        | only if `$display->isPagerEnabled()` |

`isApplicable()` excludes entity-reference displays and displays that return a response
(feeds, REST export).

## Storage

`submitOptionsForm()` writes each non-empty section into the display's extender options:

```
display_options:
  display_extenders:
    ui_styles:
      exposed_form_options: { selected: {...}, extra: '' }
      style_options:        { selected: { grid: row }, extra: 'g-3' }
      pager_options:        { selected: {...}, extra: '' }
```

Schema `views.display_extender.ui_styles` (each a `ui_styles.selected_mapping`).
`optionsSummary()` reports "Yes/No" for the "UI Styles" row.

## Render

`UiStylesViewsHooks::preprocessViewsView()` (`hook_preprocess_views_view`) reads the extender
via `getSelectedStyles($section)` / `getExtraStyles($section)` and applies classes with
`StylePluginManager::addClasses()` to:

- `$variables['exposed']` ← `exposed_form_options`
- `$variables['rows']` ← `style_options` (per group when the style uses grouping and the first
  key is `0`)
- `$variables['pager']` ← `pager_options`
