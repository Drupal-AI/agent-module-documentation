# Global settings — default accordion/tabs options

Route `jquery_ui_filter.settings` → `/admin/config/content/formats/jquery_ui_filter`
(permission `administer filters`; menu link under *Configuration → Content authoring*).
Form: `Drupal\jquery_ui_filter\Form\jQueryUiFilterSettingsForm` (id `jquery_ui_filter_settings_form`,
extends `ConfigFormBase`). These are the **site-wide default options** applied to every widget; a
token can override any of them per instance (see [filter.md](filter.md)).

The form renders one collapsible section per widget (`accordion`, `tabs`), each a single **Options
(YAML)** textarea. Values are validated as YAML on submit (`Yaml::decode`; a parse error blocks
save) and merged over the plugin's built-in defaults before saving.

## Config object: `jquery_ui_filter.settings`

Shipped default (`config/install/jquery_ui_filter.settings.yml`); identical defaults for both widgets:

```yaml
accordion:
  options:
    headerTag: h3          # heading tag delimiting panels
    mediaType: screen      # screen | all | print
    scrollTo: true         # scroll to bookmarked widget on load
    scrollToDuration: 500  # scroll animation ms
    scrollToOffset: auto   # px offset, or 'auto' (body top margin+padding)
tabs:
  options:
    headerTag: h3
    mediaType: screen
    scrollTo: true
    scrollToDuration: 500
    scrollToOffset: auto
```

Any additional jQuery UI accordion/tabs option can be added under `options:` and it will be passed
through to the widget at runtime.

### Schema (`config/schema/jquery_ui_filter.schema.yml`)

`jquery_ui_filter.settings` is a `config_object` with `accordion` and `tabs` mappings, each holding
an `options` value typed **`ignore`** (free-form YAML — not individually validated by config schema).

## Set without the UI

Drush:

```bash
drush cget jquery_ui_filter.settings
drush cset jquery_ui_filter.settings accordion.options.headerTag h2 -y
drush cset jquery_ui_filter.settings accordion.options.scrollToDuration 800 -y
```

PHP (replace a widget's whole options map):

```php
\Drupal::configFactory()
  ->getEditable('jquery_ui_filter.settings')
  ->set('tabs.options', [
    'headerTag' => 'h3',
    'mediaType' => 'all',
    'scrollTo' => TRUE,
    'scrollToDuration' => 500,
    'scrollToOffset' => 'auto',
  ])
  ->save();
```

The full config is exposed to the front end as `drupalSettings.jquery_ui_filter` whenever a page
contains a widget, and the config is registered as a cacheable dependency of the filtered output, so
changing it invalidates the render cache of affected content.
