<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds SEO (seeds_seo) — agent index

Metapackage / starter module from the **Seeds** distribution. Version 2.0.2 (dir label `2.x`).
Ships **only** `seeds_seo.info.yml`, `composer.json`, `README.md`, `LICENSE.txt` — **no PHP, no
`src/`, no routes, no services, no config, no hooks, no permissions, no schema**. Its sole function
is to declare dependencies so that enabling it turns on a curated SEO stack.

## What enabling it does
`info.yml` `dependencies:` (auto-enabled with the module):
- `metatag:metatag`, `metatag:metatag_facebook`, `metatag:metatag_open_graph`
- `simple_sitemap:simple_sitemap`
- `redirect:redirect`
- `pathauto:pathauto`
- `link_attributes:link_attributes`
- `length_indicator:length_indicator`

`composer.json` `require` (pulled into the codebase, enabled individually as needed — NOT all in
info.yml): `fast_404`, `google_analytics`, `google_tag`, `yoast_seo`, `schema_metatag`, `ms_clarity`,
`linkchecker` (plus the info.yml deps above).

Note `composer.json` also carries core/yoast_seo patches under `extra.patches`.

## Entities / plugins / routes / services
None. All behaviour, configuration, and any security surface belong to the depended-on modules; this
project provides nothing of its own to configure.

## Solution docs
- [agent/config/install.md](config/install.md) — install/enable, the dependency set, how to operate.

`core_version_requirement: ^10 || ^11`. `package: Seeds`. License GPL-2.0-or-later.
