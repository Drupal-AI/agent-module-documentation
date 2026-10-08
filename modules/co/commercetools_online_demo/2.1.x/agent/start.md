<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commercetools Online Demo — agent index

**Zero-click installer that turns a Drupal site into a pre-configured commercetools B2C "Lifestyle" demo store.** Version **2.1.0**. Core `^9 || ^10 || ^11`. Package: Commerce.

Not a runtime feature module and not pure sample config — it is a thin **orchestration layer**. All behaviour lives in a single `hook_install()` in `commercetools_online_demo.install`; the module ships no routes, controllers, forms, blocks, services, permissions, config schema, templates, or JS. Only assets are two PNGs (logo, favicon) under `assets/`.

## What it is
- A demo/showcase bootstrapper. Enabling it configures the whole site for a commercetools demo, then tells you to visit the catalog. Explicitly not for production.
- Depends on the commercetools suite (`commercetools`, `commercetools_demo`, `commercetools_content`, `commercetools_decoupled`) plus core `content_translation` and `locale`. `composer.json` also requires the `flexistyle_bootstrap` theme (`^1.3`) and `commercetools` (`^2.0`).

## What `hook_install()` does (source of truth: `commercetools_online_demo.install`)
Runs `drupal_flush_all_caches()`, then 8 steps via private helpers:
1. `_commercetools_online_demo_install_contrib_modules()` — installs the `flexistyle_bootstrap` theme if present in the codebase; warns and continues if not.
2. `_commercetools_online_demo_configure_themes()` — sets `flexistyle_bootstrap` as default frontend theme (falls back to `olivero` on failure), `claro` as admin theme.
3. `_commercetools_online_demo_configure_site()` — sets `system.site` name to `Commercetools`; sets `flexistyle_bootstrap.settings` `header_navbar_bg=bg-dark`, `header_position=header-normal`. (Doc comments mention a slogan, but no slogan is actually set.)
4. `_commercetools_online_demo_configure_logo()` — copies `assets/commercetools_logo.png` to `public://logos`, creates a `file` entity, points `flexistyle_bootstrap.settings` `logo.path` at it.
5. `_commercetools_online_demo_configure_favicon()` — same pattern for `assets/commercetools_favicon.png` into `public://favicons`.
6. `_commercetools_online_demo_configure_demo()` — the core step. Uses `commercetools_demo.configuration_deployer` to `deployDemoAccount('demo1_b2c_lifestyle')`, reads that account's API config, and dispatches `CommercetoolsConfigurationEvent` to write the live connection config. Then `deployDemoComponents`/`setDemoConfig`/`deployDemoPages` for `commercetools_demo`, `commercetools_content`, `commercetools_decoupled` (each guarded by `moduleExists`). Finally disables the `block.block.flexistyle_bootstrap_search_form_narrow` search block if present.
7. `_commercetools_online_demo_configure_front_page()` — sets `system.site` `page.front` to the deployed demo page, else `/node/1`, else `/commercetools-demo/content/catalog`.
8. Final `drupal_flush_all_caches()`; renames the `en` language label to `USA (English)`; prints a success message linking `/commercetools-demo/content/catalog`.

The file starts with `ini_set('memory_limit', -1)` (unbounded memory for the install run). Every step wraps its work in try/catch and degrades gracefully (logs a warning, continues) rather than failing the install.

## Where things actually run
- The storefront routes, catalog, and API calls belong to the **commercetools** suite modules, not this one. This module only wires them up. For runtime storefront/API behaviour, read the `commercetools` docs.
- The demo B2C credentials come from the `commercetools_demo` module's deployer (`demo1_b2c_lifestyle`); they are not stored in this module's code or config.

## Files
- `commercetools_online_demo.info.yml` — metadata, dependencies.
- `commercetools_online_demo.install` — the entire logic (`hook_install` + 7 helpers).
- `composer.json`, `CONTRIBUTING.md`, `LICENSE.txt`, `assets/commercetools_logo.png`, `assets/commercetools_favicon.png`.

## See also
- `../usage.md` — one-paragraph purpose + capability bullets.
- `../human-docs/` — human install/overview guide.
