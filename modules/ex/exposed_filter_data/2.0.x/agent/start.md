<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exposed Filter Data (exposed_filter_data) — agent index

A tiny Views display helper. Provides ONE block that prints the current request's URL query-string
parameters as a themed "Filtered by: name: value" summary — used to show which exposed-filter values
produced a View's result set. No config, routes, permissions, services, or update hooks.

- **Version:** 2.0.x · **License:** GPL-2.0-or-later · **Core:** `^10 || ^11`
- **Dependency:** `drupal:views` (the module only makes sense alongside Views; it does not call Views APIs).
- **Composer:** `drupal/exposed_filter_data` (no extra composer requirements).

## What it provides
- **Block plugin** `exposed_filters_data_block` — `src/Plugin/Block/ExposedFilterDataBlock.php`
  (admin label "Exposed Filters Data"). Reads `request_stack`→`getCurrentRequest()->query->all()`,
  runs `hook_exposed_filter_data_params_alter()`, renders via the theme hook below, attaches the CSS
  library, and sets `getCacheMaxAge() = 0`.
- **Theme hook** `exposed_filter_data_block` — `exposed_filter_data.module` (`hook_theme`), template
  `templates/block--exposed_filter_data.html.twig`, single variable `filters`.
- **Alter hook** `hook_exposed_filter_data_params_alter(&$params)` — documented in
  `exposed_filter_data.api.php`; lets a site rewrite/relabel/unset the raw query parameters.
- **Library** `exposed_filter_data/exposed_filter_data.block` (`exposed_filter_data.libraries.yml`) →
  `css/exposed_filter_data.css` only.

## No
- No `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `*.install`, `config/` (no settings form,
  no config schema), no submodules, no Drush commands, no Views plugins/handlers of its own.

## Solution docs
- [Block: exposed_filters_data_block](plugins/block.md) — placement, build flow, template, cache.
- [Alter hook: params_alter](api/params_alter.md) — relabel/rewrite/filter the displayed parameters.
