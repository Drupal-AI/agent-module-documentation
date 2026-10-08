<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Single Language URL Prefix

## What it does

Core only adds the language prefix to URLs when **more than one** language is enabled. This module
re-enables the prefix for the **single-language** case via a path processor
(`single_language_url_prefix.path_processor` → `SingleLanguageNegotiationUrl`, tagged
`path_processor_inbound` priority 500 and `path_processor_outbound` priority -1):

- **Outbound** (generating URLs): if one language is enabled and the negotiation source is path
  prefix, it sets `$options['prefix'] = '<prefix>/'` so links come out as `/<prefix>/path`.
- **Inbound** (incoming requests): it strips the matching leading prefix so routing resolves the
  real path.

## Requirements (must be true for the module to act)

1. **Exactly one** language enabled. With two or more, the module returns early and core handles
   prefixes normally.
2. Core URL language negotiation is on with **source = path prefix**, and the single language has a
   **prefix** set. In config this is `language.negotiation` → `url`:
   - `source: path_prefix` (the constant `LanguageNegotiationUrl::CONFIG_PATH_PREFIX`)
   - `prefixes: { <langcode>: '<prefix>' }`, e.g. `prefixes: { en: en }`

   Set this at *Configuration → Regional and language → Languages → Detection and selection → URL*,
   or via config. If the prefix is empty, outbound prefixing is skipped.

## The one setting: `excluded_paths`

Config object `single_language_url_prefix.settings`, single key `excluded_paths` (default `''`).
Form at `/admin/config/regional/language/single-language-url-prefix` (permission *administer
languages*). One path per line; wildcards allowed — matched with core's `path.matcher`
(`PathMatcherInterface::matchPath`). Excluded paths keep working **without** the language prefix
(the processor skips them both inbound and outbound).

```
/admin
/admin/*
/api/*
/health
```

Read/write:

```bash
drush cget single_language_url_prefix.settings excluded_paths
drush cset single_language_url_prefix.settings excluded_paths $'/admin\n/admin/*\n/api/*' -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('single_language_url_prefix.settings')
  ->set('excluded_paths', "/admin\n/admin/*\n/api/*")
  ->save();
```

## Gotchas

- The module ships default config (`excluded_paths: ''`) but **no config schema**, so `excluded_paths`
  is a plain untyped string in `single_language_url_prefix.settings`.
- Prefix value and negotiation source come from **core** `language.negotiation` (`url`), not from
  this module — this module only decides whether to apply it on a monolingual site and which paths
  to skip.
