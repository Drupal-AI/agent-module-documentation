<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Style Generate (image_style_generate) — agent index

**One Migrate source plugin that generates image style config entities in bulk from a rules-and-patterns definition.** No UI, no routes, no services, no hooks, no permissions, no settings. Core `image` + `migrate` required. Version **1.2.0**, core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

## What it actually is

- Provides exactly one Migrate **source** plugin: `@MigrateSource(id = "image_style_generate")` in `src/Plugin/migrate/source/ImageStyleGenerate.php` (extends `SourcePluginBase`).
- Helper value object `src/ImageStyleRow.php` computes a single style's row (`name`, `label`, ordered `effects`) and does the `{{variable}}` substitution.
- You author a `migrate_plus` migration YAML with `source: { plugin: image_style_generate, ... }` and `destination: { plugin: entity:image_style }`. Running it (Drush `migrate:import` or Migrate Tools UI) creates image **style config entities**.
- It does **not** pre-generate derivative image files and does **not** fetch anything. Output is configuration only; derivatives are still built on demand by core.
- Generation is synchronous inside the migration run. No queue, no batch of its own (migrate's own batching applies).

## Mechanism (the loop)

`generateRows()` iterates `style_groups` × `base_sizes` × `size_scales`. For each combination it builds an `ImageStyleRow`, which:
- computes `size = base_size × size_scale / 100`, then a dimension = `size × size_multiplier` (default multiplier 1);
- treats that dimension as width unless `base_size_dimension: height`; derives the other dimension from `aspect_ratio` (`W:H`) when given;
- substitutes `{{token}}` placeholders into `id_pattern`, `label_pattern` and every effect's config via `strtr`;
- returns effects as an ordered list (`id`, incrementing `weight`, `data`).

Rows are keyed by the generated machine name, so **duplicate ids collapse** (why example 3 yields "9 styles less 3 duplicates").

Merge/override: `base_sizes`, `size_scales`, `effects` are resolved with `NestedArray::mergeDeepArray`, layering `defaults` → per-base-size → per-size-scale → per-style-group (most specific wins). Setting an entry to `false` **removes** it at that layer.

`MigrateException` is thrown for: missing `ids`, missing `style_groups`, a non-numeric or `< 1` base size, a non-numeric or `< 1` size scale.

## Configuration reference

Full source-plugin config keys, the `{{variable}}` list, and merge/override rules: [agent/api/source-plugin.md](api/source-plugin.md).

## Submodules (copy these as templates)

- **image_style_generate_example** — depends on `migrate_plus`. Three migrations: `_1` (2 max-width scale styles), `_2` (12 styles = core Thumbnail/Medium/Large × 100/150/200/300 density), `_3` (9 scale-and-crop styles across square/landscape/portrait). Configs in its `config/install/`.
- **image_style_generate_example_advanced** — depends on `migrate_plus`, `focal_point`, `image_style_quality`. One migration generating 336 styles (6 groups × 14 base sizes × 4 scales) with `focal_point_scale_and_crop` + per-scale `image_style_quality` overrides.

## Companions

Not hard dependencies but expected in practice: `migrate_plus` (stores the migration as config so it can be installed/run) and `migrate_tools` (Drush commands + UI to run/rollback). Advanced example additionally needs `focal_point` and `image_style_quality` for those effect plugins.

## Security

No routes, controllers, access checks, CSRF surface, remote fetch, or filesystem path handling. The only input is developer-authored migration YAML executed by a migrate-privileged user. Reviewed fresh: clean.
