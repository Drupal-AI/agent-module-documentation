<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apply UI Styles to theme regions

## Admin UI

- Overview: *Appearance → Regions styles* — `/admin/appearance/regions-styles`
  (route `ui_styles_page.regions.overview`).
- Per theme: `/admin/appearance/regions-styles/{theme}` (route
  `ui_styles_page.regions.theme_settings`, form `RegionsThemeSettingsForm`).
- Permission: **`administer themes`**.

The form lists every region declared by the theme with a `ui_styles_styles` selector.

## Where it is stored

In the theme's settings config `<theme>.settings`, keyed by region:

```yaml
# olivero.settings
third_party_settings:
  ui_styles_page:
    regions:
      content:
        selected:
          spacing: p-3
        extra: 'ui-styles-eval-region'
      header:
        selected: {}
        extra: 'bg-dark'
```

Each region entry is a `ui_styles.selected_mapping` (`{selected: {style_id: class}, extra}`).
Constant: `UiStylesPageInterface::REGION_STYLES_KEY_THEME_SETTINGS =
'third_party_settings.ui_styles_page.regions'`. `PreprocessRegion` reads the entry for the
current region and merges classes onto the region's `attributes`.

## Scriptable

```php
$config = \Drupal::configFactory()->getEditable('olivero.settings');
$config->set('third_party_settings.ui_styles_page.regions.content', [
  'selected' => [],
  'extra' => 'ui-styles-eval-region',
])->save();
drupal_flush_all_caches();
```

## Read it back

```bash
drush cget olivero.settings third_party_settings.ui_styles_page.regions
```
