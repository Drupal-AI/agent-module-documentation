# Configure: settings form & config object

Form: `\Drupal\animated_scroll_to\Form\AnimatedScrollToForm` (extends `ConfigFormBase`,
form id `animated_scroll_to_settings`).
Route: `animated_scroll_to.settings` → `/admin/config/animate-scroll-to/settings`
(permission `administer animated scroll to`, menu link under `system.admin_config_content`).
Config object: `animated_scroll_to.settings` (the form's only editable config name).

There is **no `config/install` default and no `config/schema`**. Until the form is saved the
config is empty, `getRawData()` returns `[]`, and `hook_preprocess_page()` attaches nothing —
so you must save the form (with a functionality enabled) for anything to happen.

## Config keys

| Key | Form field | Type | Default* | Unit / meaning |
|-----|-----------|------|----------|----------------|
| `delay` | Animation delay | number | 0 | ms to wait before the animation starts |
| `default_speed` | Default animation speed | number | 600 | ms — jQuery `animate()` duration when `data-scroll-speed` absent |
| `default_pause` | Default animation pause | number | 3000 | ms — pause between successive targets (on-page-load, multi-hash only) |
| `default_correction` | Default scroll correction | number | 0 | px subtracted from the target's top offset (sticky-header offset) |
| `default_easing` | Default animation easing | select | `swing` | jQuery easing; options `swing`, `linear` |
| `on_page_load` | Enable scrolling for links that trigger a page reload | checkbox | 0 | attaches `on_page_load` library; handles `/node/1#anchor`, `https://ex.com/node/1#anchor` |
| `in_page` | Enable scrolling for in-page links | checkbox | 0 | attaches `in_page` library; handles `<a href="#anchor">` |
| `in_page_links_use_delay` | Enable animation delay on in-page links | checkbox | 0 | when off, `delay` is forced to 0 for in-page clicks |

\* Defaults are the form's fallbacks (`$config->get(...) ?? <default>`); they are only persisted
once you save. The JS also carries its own hardcoded fallbacks if `drupalSettings` is missing
(in-page: delay 0, speed 600, correction 0, easing swing; on-page-load: delay 300, speed 600,
pause 3000, correction 0, easing swing).

## How it is applied

`animated_scroll_to_preprocess_page(&$variables)` in `animated_scroll_to.module`:

- If `on_page_load === 1`: attaches library `animated_scroll_to/on_page_load` and
  `$variables['#attached']['drupalSettings']['animated_scroll_to']['default_settings']` = the raw config.
- If `in_page === 1`: attaches library `animated_scroll_to/in_page` and the same `drupalSettings`.

The whole config array (`getRawData()`) is exposed to the browser as `drupalSettings`; the JS
reads `default_settings.delay`, `.default_speed`, `.default_pause`, `.default_correction`,
`.default_easing`, `.in_page_links_use_delay`.

## Set without the UI

Drush:

```bash
drush cset animated_scroll_to.settings in_page 1 -y
drush cset animated_scroll_to.settings on_page_load 1 -y
drush cset animated_scroll_to.settings default_speed 800 -y
drush cset animated_scroll_to.settings default_correction 80 -y
drush cset animated_scroll_to.settings default_easing swing -y
```

PHP:

```php
\Drupal::configFactory()->getEditable('animated_scroll_to.settings')
  ->set('in_page', 1)
  ->set('on_page_load', 1)
  ->set('delay', 0)
  ->set('default_speed', 800)
  ->set('default_pause', 3000)
  ->set('default_correction', 80)
  ->set('default_easing', 'swing')
  ->set('in_page_links_use_delay', 0)
  ->save();
```

The toggles are compared with strict `=== 1` in the preprocess hook, so store integer `1`
(not `TRUE`/`"1"`) to enable a functionality.
