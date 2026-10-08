<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scrollama — configuration

Form `Drupal\scrollama\Form\SettingsForm` at route `scrollama.settings_form`
(`/admin/config/system/scrollama`), gated by permission `administer scrollama configuration`.
All values live in the `scrollama.settings` config object (schema `scrollama.schema.yml`).

## Config keys (`scrollama.settings`)

| Key | Type | Default | Effect |
|---|---|---|---|
| `enable_globally` | bool | `false` | Attach `scrollama/scrollama` on every page via `hook_page_attachments`. |
| `enable_css` | bool | `false` | Attach the stock `scrollama/scrollama-css` stylesheet globally. |
| `debug` | bool | `false` | Draw scrollama's scroll line and `console.table` the element data. |
| `offset` | float | `0.75` | Scroll trigger point, 0 (viewport top) to 1 (bottom). |
| `order` | bool | `true` | On load, fire all triggers above the current scroll position. |
| `once` | bool | `true` | Fire each element's enter trigger only once, then stop listening. |

`offset`, `debug`, `order`, `once` are always emitted to the browser as `drupalSettings.scrollama`,
regardless of whether the library is attached globally.

## Enabling the behavior — two ways

The libraries are **off by default**. Pick one:

1. **Globally** — tick "Enable scrollama globally" (and optionally "Enable CSS animations") on the
   settings form. Simplest, but loads the library on every page (perf cost if rarely used).
2. **Per code (recommended for production)** — attach the library only where needed:
   ```php
   $build['#attached']['library'][] = 'scrollama/scrollama';
   $build['#attached']['library'][] = 'scrollama/scrollama-css'; // optional stock animations
   ```
   Works from render arrays, `hook_preprocess_*`, blocks, views, paragraphs, `*.libraries.yml`
   dependencies, etc.

## Drush

Read/set config without the UI:
```
drush cget scrollama.settings
drush cset scrollama.settings offset 0.5 -y
drush cset scrollama.settings enable_globally true -y
```

No entities, no plugins, no Drush commands are provided by the module.
