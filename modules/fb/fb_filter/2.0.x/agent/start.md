<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facebook Filter (fb_filter) — agent index

A single text-format **Filter plugin** that converts Facebook `#hashtags` in content into links to
`https://www.facebook.com/hashtag/<tag>` at display time. Package `Other`. Depends only on core
**`filter`**. Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.1.

- **The filter plugin, its one setting, the transform it performs, and how to enable it on a text
  format** → [plugins/fb-filter.md](plugins/fb-filter.md)

## What it actually is

- One plugin: `FbFilter` (id **`fb_filter`**, title *"Facebook filter"*), in
  `src/Plugin/Filter/FbFilter.php`, extending core's `FilterBase`. `type =
  TYPE_TRANSFORM_IRREVERSIBLE` — a display-time transform that does **not** alter stored content.
- **No** routes, controllers, permissions, services, entities, Drush commands, hooks beyond
  `hook_help()` (`fb_filter.module`), and no settings page of its own — a filter is configured
  per text format under *Configuration → Content authoring → Text formats and editors*.
- Provides config schema for its settings: `config/schema/fb_filter.schema.yml`
  (`filter_settings.fb_filter`).

## Mechanism (from source)

- `FbFilter::process($text, $langcode)` runs one `preg_replace` with the Unicode pattern
  `/(^|\s)#(\w*[\p{M}\p{L}]+[\p{M}\p{L}]*)/u`: a `#` at string start or after whitespace, followed by
  word/letter/mark characters, becomes
  `<a class="facebook-hashtag"[ target="_blank"] href="https://www.facebook.com/hashtag/<tag>">#<tag></a>`.
  The base URL is the class constant `FbFilter::SITE = 'https://www.facebook.com'`. It returns a
  `FilterProcessResult`.
- Non-matching text is passed through unchanged (standard filter-pipeline behavior); the filter adds
  only the fixed anchor markup and does not modify existing tags.
- `settingsForm()` exposes one select, `tips()` returns the author help string. Only `$text` and
  `$this->settings` are read — no request/global input.

## Settings (one)

`link_hashtags_target` — `none` (default; same tab) or `_blank` (adds `target="_blank"` to the
hashtag links). Default is declared in the `@Filter` annotation and constrained by the schema enum.
Details in [plugins/fb-filter.md](plugins/fb-filter.md).
