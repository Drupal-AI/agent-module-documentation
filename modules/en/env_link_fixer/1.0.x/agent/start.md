<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Environment Link fixer (env_link_fixer) — agent index

Strips **mapped/production domain names** from absolute `<a href>` / `<img src>` URLs so they become
relative and resolve on the **current** environment. No entities, services, hooks (beyond helper
functions) or Drush. Provides one permission and a config object. Version **1.0.4**. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

## What it actually is (from source)

Three plugins, all sharing helper functions in `env_link_fixer.module`:

- **Text-format filter** `RewriteOwnDomainLinks` (id `env_link_fixer_strip_domain`, TRANSFORM_IRREVERSIBLE,
  weight 99) — `src/Plugin/Filter/RewriteOwnDomainLinks.php`. Rewrites filtered HTML output.
- **Link field widget** `EnvLinkFixerLinkWidget` (id `env_link_fixer_link_widget`) — extends core
  `LinkWidget`; strips the current `$base_url` host from an entered URI on save.
- **Link field formatter** `EnvLinkFixerLinkFormatter` (id `env_link_fixer_link_formatter`) — extends
  core `LinkFormatter`; when *Force relative URLs* is on, converts absolute URLs on local domains to
  internal at display time.

Runtime notes: the widget/formatter target the **`link`** field type (core `link` module); the filter
extends core `filter`. Neither dependency is declared in `env_link_fixer.info.yml` (it declares none).

## Config, route, permission

- Config object **`env_link_fixer.settings`**, key **`mapping`** (string, format `hostname|domain,domain`).
  Install default empty; schema in `config/schema/env_link_fixer.schema.yml`.
- Settings form `env_link_fixer.admin_form` at **`/admin/config/system/env_link_fixer`**
  (`SettingsForm`), permission **`administer env_link_fixer settings`** (`restrict access: TRUE`).
- `settings.php` overrides: `$settings['env_link_fixer_disabled']` and
  `$settings['env_link_fixer_custom_mappings']`.

## Solution docs

- **Config, mapping format, settings.php overrides, helper functions** →
  [config/settings.md](config/settings.md)
- **Text-format filter (HTML rewriting mechanism)** → [filters/strip_domain.md](filters/strip_domain.md)
- **Link field widget & formatter** → [fields/link.md](fields/link.md)
