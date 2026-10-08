<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Styles Builder (image_styles_builder) — agent index

A **developer toolkit** that generates and flushes core **image styles in bulk** from YAML
`*.image_styles_builder_derivatives.yml` files, via two **Drush** commands and a **Twig** helper.
No UI, no routes, no permissions, no config form. Package `Development`. Depends only on core
**`image`**. Core requirement `^10.5 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.1.8.

- **Derivatives YAML format, the plugin manager, generate/flush services, Drush commands, and the
  Twig function** → [api/derivatives.md](api/derivatives.md)

## What it actually is

- A custom **YAML-discovery plugin type** named `image_styles_builder_derivatives`. `DerivativeManager`
  (`src/DerivativeManager.php`, service `plugin.manager.image_styles_builder.derivative`) extends
  `DefaultPluginManager` and uses `YamlDiscovery` over `getModuleDirectories()`. Each enabled module
  may ship one `MODULE.image_styles_builder_derivatives.yml`. `alterInfo('image_style_builder_derivatives')`.
- `processDefinition()` **requires** `label`, `suffix`, `styles`, and each style's `effects`, or throws
  `PluginException`. Discovery is cached (`image_style_builder` cache bin).
- Plain **value objects** (not Drupal plugins): `Plugin/Derivative/Derivative`, `ImageStyle`,
  `ImageEffect`. A style's machine name is built as `suffix_id` in `ImageStyle::__construct`.

## Provided services

- `image_styles_builder.manager.image_style_generator` → `ImageStyleGenerator::generate(ImageStyle)`.
  Creates a core `image_style` entity (name = label = `suffix_id`), adds each declared effect via the
  core `plugin.manager.image.effect` manager, saves it. **Skips** (returns NULL, logs a notice) if a
  style with that name already exists.
- `image_styles_builder.manager.image_style_flusher` → `ImageStyleFlusher::flush(ImageStyle)`. Loads and
  **deletes** the `image_style` entity of that name (logs a notice if absent).
- `image_styles_builder.twig_extension.image_style` → registers Twig function
  `isb_image_styles(derivative_id)` returning the derivative's generated style machine names (array).

## Drush commands (`drush.services.yml`)

- `image_styles_builder:generate` (alias **`isb:gen`**) — `Commands/GenerateCommand`. Prompts to pick a
  derivative or "All", generates styles, prints a table.
- `image_styles_builder:flush` (alias **`isb:flush`**) — `Commands/FlushCommand`. Prompts, deletes the
  declared styles, prints a table. Suggests `drush/drush ^12 || ^13`.

## Notes for agents

- CLI-only. There is **no HTTP surface** — no `*.routing.yml`, `*.permissions.yml`, controllers, or
  forms. Derivatives YAML comes from trusted on-disk module directories, not from requests.
- No `config/install` or `config/schema` ships; generated `image_style` entities are standard core
  config you export normally.
