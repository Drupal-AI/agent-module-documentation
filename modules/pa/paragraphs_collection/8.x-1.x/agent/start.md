<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Collection (paragraphs_collection) — agent index

A set of **ParagraphsBehavior plugins**, **styles** and **grid layouts** built on top of the
Paragraphs module. It does **not** define a new plugin type of its own — it ships plugins *of*
Paragraphs' `ParagraphsBehavior` type (`src/Plugin/paragraphs/Behavior/*`): `style` (applies a
pre-defined visual style — CSS classes/attributes/libraries and optional template suggestions — to a
paragraph), `grid_layout` (arranges a paragraph's referenced children into pre-defined columns),
`lockable` (locks a paragraph against editing unless the user has a permission), and `language`
(shows/hides a paragraph per interface language). It also installs 11 example paragraph types
(`container`, `footer`, `grid`, `intro`, `link`, `quote`, `separator`, `subtitle`, `text`, `title`,
`user`). Styles, style groups and grid layouts are **discovered from YAML files on disk** — any
module or theme may add `*.paragraphs.style.yml`, `*.paragraphs.style_group.yml` and
`*.paragraphs.grid_layouts.yml` files (see `paragraphs_collection.api.php`).

Its own info.yml description calls the project "a collection of EXPERIMENTS" and the README says
"DO NOT USE IT IN PRODUCTION … THERE IS NO UPGRADE PATH UNTIL A BETA RELEASE". It is an **alpha**
(`8.x-1.0-alpha12`) from the Thunder ecosystem. The two admin surfaces are read-only report pages at
`/admin/reports/paragraphs_collection/layouts` and `/admin/reports/paragraphs_collection/styles`
(the latter is a config form that toggles which styles are globally enabled). Behavior settings are
stored **on the paragraph entities**, so a plugin that changes shape or is removed leaves orphaned
settings on content.

- Depends on: `paragraphs:paragraphs`, `drupal:image`, `drupal:link`.
- Core: `^10.2 || ^11`. Package: `Paragraphs`. Composer: `drupal/paragraphs_collection` (requires `drupal/paragraphs:^1.12`).
- No dedicated settings page / `configure` route (info.yml has no `configure:` key). The two routes are admin **reports** behind `administer paragraphs types`; each behavior is configured per paragraph type on its Paragraphs Type form.
- Permissions: static `administer lockable paragraph` + dynamic `use {style} style` per YAML style flagged `permission: true` (callback `Permissions::permissions`).
- Provides config schema (`paragraphs_collection.settings`, behavior settings schemas). No drush commands.
- Submodules (in `modules/`): `paragraphs_collection_demo` (adds `accordion`, `anchor`, `background`, `slider` behaviors, demo content type + paragraph types, depends on `slick`, `block_field`, `jquery_ui_accordion`, `paragraphs_library`); `paragraphs_collection_test` (test fixtures only). Enabling demo is how the behaviors become usable out of the box.

## What you'd do → where

- **Enable/configure a behavior on a paragraph type; understand every behavior's config keys, per-paragraph settings and where they're stored; the access-control behaviors (lockable/language)** → [plugins/behaviors.md](plugins/behaviors.md)
- **Define your own style / style group / grid layout in YAML; the discovery services; the enabled-styles config form; the report pages; permissions & caching** → [configure/styles-and-layouts.md](configure/styles-and-layouts.md)

## Key facts (real machine names)

- Routes: `paragraphs_collection.layouts` (`/admin/reports/paragraphs_collection/layouts`),
  `paragraphs_collection.styles` (`/admin/reports/paragraphs_collection/styles`) — both
  `_permission: administer paragraphs types`; controller
  `Drupal\paragraphs_collection\Controller\OverviewController` (`layouts()`, `styles()`).
- Services: `paragraphs_collection.style_discovery` (`StyleDiscovery` / `StyleDiscoveryInterface`),
  `paragraphs_collection.grid_layout_discovery` (`GridLayoutDiscovery` / `GridLayoutDiscoveryInterface`),
  `paragraphs_collection.style_config_cache_tag_invalidator`
  (`EventSubscriber\ParagraphsCollectionStyleConfigCacheTag`, subscribes `ConfigEvents::SAVE`).
- Form: `paragraphs_collection_styles_overview_form` (`Form\StylesOverviewForm`, `ConfigFormBase`,
  edits `paragraphs_collection.settings:enabled_styles`).
- ParagraphsBehavior plugin ids (this module): `style`, `grid_layout`, `lockable`, `language`.
  Demo submodule adds: `accordion`, `anchor`, `background`, `slider`.
- Config object: `paragraphs_collection.settings` (key `enabled_styles`: sequence of style names).
  Behavior-settings schemas: `paragraphs.behavior.settings.style` (`groups.<group>.default`),
  `…grid_layout` (`paragraph_reference_field`, `available_grid_layouts`), `…language` (empty).
- YAML discovery suffixes (modules + themes): `<provider>.paragraphs.style.yml`,
  `<provider>.paragraphs.style_group.yml`, `<provider>.paragraphs.grid_layouts.yml`.
- Permissions: `administer lockable paragraph`; dynamic `use <style-name> style`.
- Hooks: `paragraphs_collection_paragraph_access()` (combines lockable + language `AccessResult`),
  `hook_theme_suggestions_paragraph_alter()` (adds `paragraph__<bundle>__<style-template>`),
  `hook_theme()`, `hook_modules_installed()/themes_installed()/themes_uninstalled()` (reset style
  cache). Update hooks: `paragraphs_collection_update_8001`/`8002`/`8003`.
- Libraries: `paragraphs_collection/overview`, `paragraphs_collection/plugin_admin`,
  `paragraphs_collection/paragraphs_quote`.
- Theme templates: `paragraph--separator.html.twig`, `paragraph--quote.html.twig`, and
  `field--paragraphs-*.html.twig`. Exceptions: `InvalidStyleException`, `InvalidGridLayoutException`.
