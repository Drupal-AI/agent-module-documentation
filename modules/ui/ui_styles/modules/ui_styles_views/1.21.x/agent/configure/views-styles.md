<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apply UI Styles to a view

## Registration

UI Styles Views ships a Views **display extender** plugin `ui_styles`
(`Drupal\ui_styles_views\Plugin\views\display_extender\Styles`). Display extenders must be
enabled globally: the module's `hook_install()` appends `ui_styles` to
`views.settings` → `display_extenders` (and `hook_uninstall()` removes it). So after enabling
the module the extender is active on **every** view display.

```bash
drush cget views.settings display_extenders   # should include 'ui_styles'
```

## The three sections

`buildOptionsForm()` adds a `ui_styles_styles` selector for each handled section:

| section key | UI label | applies to |
|---|---|---|
| `exposed_form_options` | Exposed form | the view's exposed filter form |
| `style_options` | Style | the result rows / format region |
| `pager_options` | Pager | the pager (only if the display has a pager) |

## Where it is stored

On the view display, under the display extender:

```yaml
# views.view.<view>.display.<display_id>.display_options
display_extenders:
  ui_styles:
    exposed_form_options:
      selected: {}
      extra: 'row g-3'
    style_options:
      selected:
        layout: d-grid
      extra: ''
    pager_options:
      selected: {}
      extra: 'justify-content-center'
```

Each section is a `ui_styles.selected_mapping` (`{selected: {style_id: class}, extra}`).

## Rendering

`hook_preprocess_views_view()` reads each section via the extender's `getSelectedStyles()` /
`getExtraStyles()` and injects the classes onto `$variables['exposed']`,
`$variables['rows']`, and `$variables['pager']` with `StylePluginManager::addClasses()`
(iterating groups when the style uses grouping).

## Configure in the UI

Edit the view (*Structure → Views*), open a display's *Advanced* settings; the UI Styles
selectors appear among the display extender options ("Exposed form", "Style", "Pager").
