<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns deriver + Twig functions (`wingsuit_ui_patterns`)

This submodule is the real Drupal↔Wingsuit integration. It turns the front-end build's
`*.wingsuit.yml` component definitions into UI Patterns and adds two Twig functions.

Dependencies (`wingsuit_ui_patterns.info.yml`): `wingsuit_companion`, `ui_patterns (>=1.1)`,
`ui_patterns_layouts`, `ui_patterns_settings (>=2.0)`, `ui_patterns_extends`, `components`. On a
bare site these contrib modules must be present before it can be enabled.

## Pattern plugin + deriver

`src/Plugin/UiPatterns/Pattern/LibraryPattern.php` is a `@UiPattern` with `id = "yaml"`, label
"Wingsuit Library Pattern", and `deriver = LibraryDeriver`. It extends `ui_patterns`' `PatternBase`
and resolves the template path: it uses the provider module's `/templates` dir, or the pattern's own
`base path` when a `<template>.html.twig` exists there.

`src/Plugin/Deriver/LibraryDeriver.php` extends
`ui_patterns\Plugin\Deriver\AbstractYamlPatternsDeriver`.

- **Which files:** the valid extensions come from the service parameter
  `wingsuit_companion.file_extensions` = `.wingsuit.yml`, `.wingsuit.yaml` (defined in
  `wingsuit_ui_patterns.services.yml`).
- **Where it scans:** `getDirectories()` returns a single directory —
  `realpath(wingsuit_companion.config:dist_path)`, keyed by provider `wingsuit_companion`. So all
  derived patterns' provider is `wingsuit_companion` (this is why `only_own_layout` filters on
  provider `wingsuit_companion`).
- **How:** `getPatterns()` reads each matched file with `file_get_contents`, `Yaml::decode`s it, and
  for each top-level key builds a pattern definition (`id`, `base path` = the file's dir, `file
  name`, `provider`). `removeWingsuitExtensions()` strips Wingsuit-only preview scaffolding
  (`faker` previews → "Faked text", nested `preview` lists/ids/settings/variant) so the definition
  is valid for UI Patterns previews.

## Pattern filtering (`wingsuit_ui_patterns.module`)

- `hook_plugin_filter_layout_alter` — when `only_own_layout` is TRUE, removes every layout whose
  provider is not `wingsuit_companion`, hiding non-Wingsuit layouts in Layout Builder.
- `hook_ui_patterns_info_alter` — reads each pattern's `additional['visibility']` (a `|`-separated
  list); if present and it does **not** include `drupal`, the pattern is removed. This lets a
  shared component library mark which components are meant for Drupal.

## Twig functions

`src/TwigExtension/WingsuitExtension.php` (service `wingsuit_ui_patterns.twig`,
tag `twig.extension`) adds:

- **`ws_itok()`** → `urlencode((string) Settings::get('deployment_identifier'))`. Intended as a
  cache key / cache-buster for generated SVGs, keyed on the deployment identifier. Not marked
  `is_safe`; returns a urlencoded scalar.
- **`uuid()`** → `Html::getId(\Drupal::service('uuid')->generate())`, a DOM-safe unique id. Not
  marked `is_safe`.

Neither function outputs raw/unescaped markup.
