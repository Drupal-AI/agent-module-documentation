<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BS Slider (bs_slider) — agent index

A **pluggable slider / carousel / gallery framework**. Core module provides no slider of its own:
it defines a config entity, a render-plugin type, a manager service and three field formatters.
The actual slider libraries come from submodules. Package `Media`. No dependencies (parent only
requires core). Core `^9.2 || ^10 | ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha8.

> Enable at least one library submodule (e.g. `bs_slider_bootstrap`) — without one there are **no
> `BsSlider` plugins**, and the optionset form shows *"There are no BS Slider plugins installed"*.

## Solution docs

- **Config entity, admin routes, permission, forms, manager service, theming** →
  [config/optionsets.md](config/optionsets.md)
- **The `BsSlider` plugin type (write your own slider plugin)** →
  [plugins/bs-slider-plugins.md](plugins/bs-slider-plugins.md)
- **Core field formatters (Text / Media / Media Gallery) + the shared trait** →
  [fields/formatters.md](fields/formatters.md)

## Submodules (each documented in its own tree under `modules/`)

- **bs_slider_bootstrap** — Bootstrap Carousel + Gallery Grid plugins (requires `bs_lib`). →
  [modules/bs_slider_bootstrap/1.0.x/agent/start.md](../../bs_slider_bootstrap/1.0.x/agent/start.md)
- **bs_slider_swiper** — Swiper.js plugin + Swiper Thumbs Gallery plugin. →
  [modules/bs_slider_swiper/1.0.x/agent/start.md](../../bs_slider_swiper/1.0.x/agent/start.md)
- **bs_slider_tiny_slider** — Tiny Slider (tns) plugin, YAML-configured. →
  [modules/bs_slider_tiny_slider/1.0.x/agent/start.md](../../bs_slider_tiny_slider/1.0.x/agent/start.md)
- **bs_slider_views** — a Views style plugin that renders rows as a slider. →
  [modules/bs_slider_views/1.0.x/agent/start.md](../../bs_slider_views/1.0.x/agent/start.md)
- **bs_slider_entity_reference_revision** — formatter for `entity_reference_revisions` fields
  (requires `entity_reference_revisions`). →
  [modules/bs_slider_entity_reference_revision/1.0.x/agent/start.md](../../bs_slider_entity_reference_revision/1.0.x/agent/start.md)
- **bs_slider_paragraphs** — a Paragraphs behavior plugin (requires `paragraphs`). →
  [modules/bs_slider_paragraphs/1.0.x/agent/start.md](../../bs_slider_paragraphs/1.0.x/agent/start.md)

## What it actually provides (from source)

- **Config entity** `bs_slider` (`config_prefix = "configuration"`, class
  `src/Entity/BsSliderConfiguration.php`) — an "optionset": `id`, `label`, `status`, `plugin_id`,
  `options`. `admin_permission = "administer bs_slider"`.
- **Permission** `administer bs_slider` (`bs_slider.permissions.yml`) — gates all optionset routes.
- **Plugin type** `BsSlider` (manager `plugin.manager.bs_slider` = `Plugin/BsSliderManager`,
  base `Plugin/BsSliderBase`, interface `Plugin/BsSliderInterface`, annotation
  `Annotation/BsSlider`; subdir `Plugin/BsSlider`, alter hook `bs_slider_bs_slider_info`).
- **Service** `bs_slider_configuration.manager` = `BsSliderConfigurationManager` — loads
  optionsets and instantiates their plugin (`entityLoad`, `getAllOptionSet`, `getPlugin`, …).
- **Field formatters** `bs_slider_text`, `bs_slider_media`, `bs_slider_media_gallery`
  (`src/Plugin/Field/FieldFormatter/`).
- **Theme hook** `bs_slider` (`templates/bs-slider.html.twig`) with
  `hook_theme_suggestions_bs_slider()` producing `bs_slider__{plugin}`, `bs_slider__{config}`,
  `bs_slider__{plugin}__{config}`.
- **Admin UI**: collection `/admin/configuration/media/bs_slider` (menu under *Configuration →
  Media*), add/edit/duplicate/delete forms; duplicate route added by `BsSliderHtmlRouteProvider`.
- No Drush, no cron, no external services, no REST.
