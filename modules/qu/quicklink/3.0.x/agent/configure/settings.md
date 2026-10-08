<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Quicklink

Single config object: **`quicklink.settings`**. UI at
`admin/config/development/performance/quicklink` (route `quicklink.settings`, permission
`administer site configuration`). The form is grouped into vertical tabs; the tab is only UI
grouping — everything is flat keys in one config object.

## All settings keys (with shipped defaults)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `ignore_admin_paths` | bool | `true` | Do not prefetch `/admin` or `/edit`; also injects admin-link selector patterns to ignore. |
| `ignore_ajax_links` | bool | `true` | Do not prefetch links that trigger AJAX. |
| `ignore_hashes` | bool | `true` | Ignore URLs containing `#`. |
| `ignore_file_ext` | bool | `true` | Ignore links ending in a file extension. |
| `url_patterns_to_ignore` | string | `''` | Newline-separated substrings; a link href containing any is skipped. |
| `ignore_selectors` | string | `''` | Newline-separated CSS selectors whose links are skipped. |
| `selector` | string | `''` | Override parent selector Quicklink scans (e.g. `.main-content`). Empty = whole document. |
| `allowed_domains` | string | `''` | Newline-separated domains allowed for prefetch. Empty = origin only. |
| `prefetch_only_paths` | string | `''` | Newline-separated paths; if set, ONLY these are prefetched. |
| `no_load_when_authenticated` | bool | `true` | "Prefetch for anonymous users only" — library not loaded for logged-in users. |
| `no_load_when_session` | bool | `true` | Do not load while a PHP session is active (adds `session.exists` cache context). |
| `no_load_content_types` | sequence | `{}` | Map of content-type machine names to opt out of loading the library. |
| `total_request_limit` | int | `0` | Max prefetch requests per page (0 = unlimited). |
| `concurrency_throttle_limit` | int | `0` | Max simultaneous prefetches (0 = library default). |
| `viewport_delay` | int | `0` | ms a link must stay in viewport before prefetch. |
| `idle_wait_timeout` | int | `2000` | ms to wait for browser idle before prefetching. |
| `enable_debug_mode` | bool | `false` | Log prefetch decisions to the browser console. |

The config schema (`config/schema/quicklink.schema.yml`) validates every key. `user/logout` is
appended to the ignore list unconditionally in code and cannot be un-ignored via config.

## Read / write with drush

```bash
# Read the whole object or one key:
drush cget quicklink.settings
drush cget quicklink.settings no_load_when_authenticated

# Set values (booleans should be written as real booleans, e.g. via php:eval):
drush php:eval '\Drupal::configFactory()->getEditable("quicklink.settings")
  ->set("no_load_when_authenticated", TRUE)
  ->set("selector", ".main-content")
  ->set("url_patterns_to_ignore", "/cart\n/checkout")
  ->set("enable_debug_mode", TRUE)
  ->save();'
```

Newline-list keys (`url_patterns_to_ignore`, `ignore_selectors`, `allowed_domains`,
`prefetch_only_paths`) store one entry per line; the module `explode(PHP_EOL, …)` and trims
`\r`. `no_load_content_types` is a keyed map (`article: article`), set via the checkboxes on
the "When to Load Library" tab.

Changing config takes effect immediately: `hook_preprocess_html()` attaches the config's cache
tags, so no manual `drush cr` is needed.
