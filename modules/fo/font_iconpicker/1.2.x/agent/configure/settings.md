# Configure Font Icon Picker

Settings form `\Drupal\font_iconpicker\Form\SettingsForm` (form id
`font_iconpicker_settings_form`, extends `ConfigFormBase`). Route `font_iconpicker.settings`
at `/admin/config/user-interface/font-iconpicker`, permission `administer site configuration`.
Menu link under `system.admin_config_ui`. Edits config object `font_iconpicker.settings`.

## Fields / config keys

| Key | Form field | Required | Default | Purpose |
|-----|-----------|----------|---------|---------|
| `css_font_path` | Font CSS file path (textfield) | yes | `''` | Path relative to Drupal root of your icon font's stylesheet, e.g. `themes/custom/mytheme/font/myfont/style.css`. Validated by `SettingsForm::validateCssFontPath`: the file must exist and its extension must be `css`. |
| `class_prefix` | Class prefix (textfield) | yes | `''` | Prefix that identifies icon selectors in the CSS, e.g. `icon-`. Drives the icon list (see api doc). |
| `additional_class` | Additional class (textfield) | no | `''` | Extra class some generators (e.g. IcoMoon) require, e.g. `icon`. Rendered alongside the chosen icon. |
| `theme` | Widget theme (radios) | yes | `grey` | fontIconPicker skin: `bootstrap`, `dark-grey`, `grey`, `inverted`. |

Config schema: `config/schema/font_iconpicker.schema.yml` declares `font_iconpicker.settings`
(config_object with the four keys above) plus `field.widget.settings.font_iconpicker`
(widget settings: `empty_icon` bool, `has_search` bool).
Default install config: `config/install/font_iconpicker.settings.yml`.

On submit, `SettingsForm::submitForm` saves the four keys then calls
`drupal_flush_all_caches()` — the widget-theme CSS and the custom-font CSS libraries are
built dynamically during library discovery (see [../api/icon-helper.md](../api/icon-helper.md)),
so a full cache flush is required for changes to take effect.

## Set via drush / PHP

```php
\Drupal::configFactory()->getEditable('font_iconpicker.settings')
  ->set('css_font_path', 'themes/custom/mytheme/font/myfont/style.css')
  ->set('class_prefix', 'icon-')
  ->set('additional_class', '')
  ->set('theme', 'grey')
  ->save();
drupal_flush_all_caches();
```

```
drush cset font_iconpicker.settings class_prefix 'icon-' -y
drush cset font_iconpicker.settings css_font_path 'themes/custom/mytheme/font/myfont/style.css' -y
drush cr
```

## Library requirement

`hook_requirements` (runtime, in `font_iconpicker.install`) reports an ERROR on the status
report when the jQuery fontIconPicker library is absent from
`/libraries/fonticonpicker/js/jquery.fonticonpicker.min.js`. Install it manually (download
from <https://fonticonpicker.github.io/>) or via the supplied `composer.libraries.json`
merge file — `fonticonpicker/fonticonpicker` v3.1.1.
