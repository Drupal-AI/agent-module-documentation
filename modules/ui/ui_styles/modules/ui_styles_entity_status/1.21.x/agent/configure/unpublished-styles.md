<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style unpublished content

## Where to configure

There is **no dedicated route**. UI Styles Entity Status adds an *Unpublished entity styles*
selector to the core theme settings form:

*Appearance → Settings → (your theme)* — `/admin/appearance/settings/{theme}` (permission
`administer themes`). The selector is a `ui_styles_styles` element added by
`FormSystemThemeSettingsAlter`.

## Where it is stored

```yaml
# olivero.settings
third_party_settings:
  ui_styles_entity_status:
    unpublished:
      selected:
        border: border-danger
      extra: 'ui-styles-eval-unpub'
```

A single `ui_styles.selected_mapping` (`{selected: {style_id: class}, extra}`). Constant:
`UiStylesEntityStatusInterface::UNPUBLISHED_CLASSES_THEME_SETTING_KEY =
'third_party_settings.ui_styles_entity_status.unpublished'`.

## Render rule

`EntityView::alter()` runs on entity build and adds the classes to `$build['#attributes']`
**only** when the entity:
- is a `ContentEntityInterface`, and
- implements `EntityPublishedInterface`, and
- `$entity->isPublished()` is FALSE.

Published content and non-publishable entities are untouched.

## Scriptable

```php
$config = \Drupal::configFactory()->getEditable('olivero.settings');
$config->set('third_party_settings.ui_styles_entity_status.unpublished', [
  'selected' => [],
  'extra' => 'ui-styles-eval-unpub',
])->save();
drupal_flush_all_caches();
```

## Read it back

```bash
drush cget olivero.settings third_party_settings.ui_styles_entity_status.unpublished
```
