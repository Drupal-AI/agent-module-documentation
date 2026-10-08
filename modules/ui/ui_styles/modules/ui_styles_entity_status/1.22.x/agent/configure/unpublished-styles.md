<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style unpublished content entities

Enable with `drush en ui_styles_entity_status` (needs `ui_styles`). There is no dedicated
route or permission — configuration rides on the core theme settings form.

## Where to configure

`FormSystemThemeSettingsAlter::alter()` adds a `ui_styles_styles` element titled
**"Unpublished entity styles"** to the system theme-settings form
(*Appearance → Settings → \<theme\>*, path `/admin/appearance/settings/<theme>`), scoped to
that theme (`#drupal_theme`). A `#validate` handler moves the submitted value from the
temporary form key `third_party_settings_ui_styles_entity_status_unpublished` to the real
config key before save.

## Storage

Constant `UiStylesEntityStatusInterface::UNPUBLISHED_CLASSES_THEME_SETTING_KEY` =
`third_party_settings.ui_styles_entity_status.unpublished`:

```
<theme>.settings:
  third_party_settings:
    ui_styles_entity_status:
      unpublished: { selected: { border: border-danger }, extra: 'opacity-50' }
```

Schema `theme_settings.third_party.ui_styles_entity_status` (a single
`ui_styles.selected_mapping`, not per-region).

## Render rule (`EntityView::alter`)

An `hook_entity_view_alter` handler runs only when **all** hold:

1. `$entity instanceof ContentEntityInterface`
2. `$entity instanceof EntityPublishedInterface`
3. `!$entity->isPublished()`

Then it reads the theme setting (via `ThemeSettingsProvider` / `theme_get_setting`), merges
`selected` + space-split `extra` onto `$build['#attributes']` (`AttributeHelper::mergeCollections`).
For a Layout Builder–enabled display (`LayoutEntityDisplayInterface::isLayoutBuilderEnabled()`)
it also applies the classes to every section render array in `$build['_layout_builder']` via
`StylePluginManager::addClasses()`. Published entities are untouched. Uninstall clears the theme
key.
