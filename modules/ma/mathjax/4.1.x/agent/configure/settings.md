<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure MathJax

## `mathjax.settings`

Route `mathjax.settings` → `/admin/config/content/mathjax` (form `MathjaxSettingsForm`, form id
`mathjax_admin_settings`). Config object `mathjax.settings`, schema in
`config/schema/mathjax.schema.yml`.

| Key | Type | Default (`config/install`) | Meaning |
|---|---|---|---|
| `use_cdn` | integer (0/1) | `1` | Load MathJax from `cdn_url` instead of `/libraries/MathJax`. |
| `cdn_url` | string | `https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML` | The external script URL. |
| `config_type` | integer (0/1) | `0` | `0` = **Text Format** (assets attach only via the filter), `1` = **Custom** (assets attach on every page). |
| `default_config_string` | string (JSON) | `{"tex2jax":{"inlineMath":[["$","$"],["\\(","\\)"]],"processEscapes":"true"},"showProcessingMessages":"false","messageStyle":"none"}` | Used in Text Format mode. |
| `config_string` | string (JSON) | *(not in config/install; written on first save)* | Used in Custom mode. |
| `enable_for_admin` | integer (0/1) | `0` | In Custom mode, also attach on admin routes. |

```bash
drush cget mathjax.settings
drush cset mathjax.settings use_cdn 0 -y
drush cset mathjax.settings enable_for_admin 1 -y
drush cset mathjax.settings config_type 1 -y
drush cset mathjax.settings config_string '{"tex2jax":{"inlineMath":[["\\(","\\)"]]}}' -y
```

```php
\Drupal::configFactory()->getEditable('mathjax.settings')
  ->set('use_cdn', 0)
  ->set('config_type', 1)
  ->set('config_string', '{"tex2jax":{"inlineMath":[["\\\\(","\\\\)"]]}}')
  ->set('enable_for_admin', 1)
  ->save();
drupal_flush_all_caches();   // the settings form does this too — library info is cached
```

> The settings form calls `drupal_flush_all_caches()` on submit because
> `hook_library_info_build()` bakes `cdn_url` / `use_cdn` into the `mathjax/source` library
> definition. Changing the config with `drush cset` **without** a cache rebuild leaves the old
> script URL in place.

## Mode 0 — Text Format (recommended)

Nothing is attached globally. Add the **MathJax** filter to a text format:

```php
$format = \Drupal::entityTypeManager()->getStorage('filter_format')->load('full_html');
$format->setFilterConfig('filter_mathjax', ['status' => TRUE, 'weight' => 100, 'settings' => []]);
$format->save();
```

```bash
drush cget filter.format.full_html filters.filter_mathjax
```

`MathjaxFilter::process()` wraps the whole text in `<div class="tex2jax_process">…</div>` and
attaches `mathjax/config`, `mathjax/source`, `mathjax/setup` plus
`drupalSettings.mathjax = ['config_type' => 0, 'config' => json_decode(default_config_string)]`.
`js/setup.js` then adds the class `tex2jax_ignore` to `<body>` when `config_type === 0`, so only
the wrapped filtered text is typeset.

**Put the filter at the bottom of the "Filter processing order".** Its plugin `weight` is 50 but
that is only the default; if *Limit allowed HTML tags* or the HTML corrector runs after it they can
mangle the wrapper or the maths delimiters.

(Quirk: `process()` skips the wrapper div when `strip_tags($text) === 'TEST'` — a test hook, not a
feature.)

## Mode 1 — Custom

`mathjax_page_attachments()` attaches `mathjax/config`, `mathjax/source` and `mathjax/setup` on
**every** page, with `drupalSettings.mathjax.config = json_decode(config_string)`. It returns early
when `enable_for_admin` is falsy and `router.admin_context` says the route is an admin route.
No filter is required in this mode; the whole page is scanned.

## Libraries

`mathjax.libraries.yml`:

- `mathjax/config` → `js/config.js`; sets `window.MathJax = drupalSettings.mathjax.config`.
- `mathjax/setup` → `js/setup.js`; depends on `core/jquery`, `core/drupal`, `mathjax/source`;
  re-typesets on `$(document).ajaxComplete()` with `MathJax.Hub.Queue(['Typeset', MathJax.Hub])`.
- `mathjax/source` → **built at runtime** by `mathjax_library_info_build()`:

```php
$libraries['source']['js'] = [
  $config->get('use_cdn') ? $config->get('cdn_url')
                          : base_url . '/libraries/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML'
    => ['type' => 'external', 'minified' => TRUE],
];
```

`mathjax.info.yml` also lists all three under `libraries:`.

### Local install

Download MathJax and unpack it so `/libraries/MathJax/MathJax.js` exists, then set `use_cdn: 0`.
`mathjax_requirements('runtime')` reports a `REQUIREMENT_ERROR` named `mathjax_local_libraries`
("Missing JavaScript libraries") on `/admin/reports/status` when the file is not found.

### Version caveat

`js/setup.js` uses the **MathJax 2** `MathJax.Hub` API and the default CDN URL is a 2.7.0 build
with the `?config=TeX-AMS-MML_HTMLorMML` query. Pointing `cdn_url` at MathJax 3/4 will load the
library but break the AJAX re-typeset hook (`MathJax.Hub` no longer exists) and the
`?config=` parameter is ignored.

## Delimiters

Defaults come from the JSON config, not from PHP: inline `$…$` and `\(…\)`, display `$$…$$` and
`\[…\]`. Change them by editing `tex2jax.inlineMath` / `displayMath` in the config string
(Custom mode), or by overriding `default_config_string` in config.
