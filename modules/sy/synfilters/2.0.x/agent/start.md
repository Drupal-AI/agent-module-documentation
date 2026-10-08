<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synfilters (synfilters) — agent index

Site-specific companion to **Better Exposed Filters (BEF)** that customizes one hard-coded
Commerce catalog View: id `product`, display `embed`. Package `SynapseF`. Version **2.0.x**
(2.0.5). Core `^11 || ^12`. Depends on `better_exposed_filters:better_exposed_filters`.

Not a general widget library — despite the name it only affects the `product`/`embed` View.

## What it provides
- **No** routes, permissions, services, config schema, settings form, plugins, or Drush commands.
- Two Views hooks wired in `synfilters.module`, each delegating to a static `Hook::hook()` class:
  - `hook_form_views_exposed_form_alter()` → `Drupal\synfilters\Hook\FormViewsExposedFormAlter::hook()`
    (`src/Hook/FormViewsExposedFormAlter.php`). Hides the exposed form (wraps it in
    `<div class="hidden">`) when the form `#id` is `views-exposed-form-product-embed`, the current
    route has a `taxonomy_term` parameter, and that term has child terms (`loadTree`).
  - `hook_views_pre_render()` → `Drupal\synfilters\Hook\ViewsPreRender::hook()`
    (`src/Hook/ViewsPreRender.php`). For view `product` / display `embed`, sets
    `$view->exposed_widgets['#action']` to the current path's alias.
- `hook_install()` in `synfilters.install` (`update_views_view_product()`): adds
  `taxonomy.vocabulary.product_options` to `views.view.product` `dependencies.config`, and
  `taxonomy` + `better_exposed_filters` to `dependencies.module`.
- `config/settings/views.view.product.yml` is a **reference/example** Commerce catalog View
  config; `config/settings/` is not an auto-imported Drupal directory, so it is not installed.

## Solution docs
- [agent/api/hooks.md](api/hooks.md) — the two hooks + install hook, exact conditions and effects.

Content-display / Views feature. It only alters exposed-form presentation and form action; it
adds no access logic and results still respect the View's own access.
