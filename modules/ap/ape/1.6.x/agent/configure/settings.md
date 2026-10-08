<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

## Admin UI

- Route **`ape.admin`** → `/admin/config/development/performance/ape`
  (form `\Drupal\ape\Form\SettingsForm`, form id `ape_settings`).
- Permission: **`administer ape`** (`restrict access: TRUE`).
- The module hides core's `page_cache_maximum_age` selector on
  `/admin/config/development/performance` and links to the APE form instead
  (`ape_form_system_performance_settings_alter()`).

The form edits **two** config objects: `system.performance` (`cache.page.max_age`, the global
default) and `ape.settings` (everything else).

## `ape.settings` config keys (schema `ape.settings`, a `config_object`)

| Key | Type | Meaning |
|---|---|---|
| `alternatives` | string | Newline path list (core `request_path` "pages" syntax, wildcards `*`) that get the alternative lifetime |
| `exclusions` | string | Newline path list denied page caching entirely |
| `lifetime.alternatives` | int | max-age (seconds) for paths matching `alternatives` |
| `lifetime.301` | int | max-age for 301 responses |
| `lifetime.302` | int | max-age for 302 responses |
| `lifetime.404` | int | max-age for 404 responses |

The **default** lifetime for everything else is core's `system.performance` →
`cache.page.max_age` (APE does not duplicate it).

> Note: APE ships **no** `config/install/ape.settings.yml`; the object only exists once the
> form is saved (or you create it). `->get('lifetime.404')` returns NULL until set.

## Set it in code / drush

```php
\Drupal::configFactory()->getEditable('ape.settings')
  ->set('alternatives', "/\n/news\n/news/*")   // homepage + news get the alternative age
  ->set('lifetime.alternatives', 300)           // 5 minutes
  ->set('exclusions', "/cart\n/user/*")         // never cache these
  ->set('lifetime.301', 86400)
  ->set('lifetime.302', 3600)
  ->set('lifetime.404', 600)
  ->save();
// Global default lives in system.performance:
\Drupal::configFactory()->getEditable('system.performance')
  ->set('cache.page.max_age', 3600)->save();
```

Read back with `\Drupal::config('ape.settings')->get('lifetime.404')` etc. Both path lists use
core's RequestPath condition syntax (one path per line, `*` wildcard, leading `/`).
