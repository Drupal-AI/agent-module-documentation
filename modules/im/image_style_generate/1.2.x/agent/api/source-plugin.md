<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Source plugin: `image_style_generate`

Class `Drupal\image_style_generate\Plugin\migrate\source\ImageStyleGenerate` (extends `SourcePluginBase`). Use inside a migration's `source:` section. Destination is normally `entity:image_style`.

## Minimal skeleton

```yaml
id: my_image_styles
migration_group: my_group          # requires migrate_plus
migration_tags:
  - image style

source:
  plugin: image_style_generate
  ids:                              # REQUIRED — the source key field(s)
    name:
      type: string
  defaults:
    id_pattern: 'max_width_{{width}}'
    label_pattern: 'Max width {{width}}'
    effects:
      image_scale:
        width: '{{width}}'
        height: null
        upscale: false
    base_sizes:
      - 320
      - 640
    size_scales:
      - 100
  style_groups:
    -                               # a single anonymous group

process:
  name: name
  label: label
  effects: effects

destination:
  plugin: entity:image_style
```

## Top-level source keys

| Key | Required | Meaning |
|-----|----------|---------|
| `ids` | **Yes** | Migrate ID map declaration. Missing → `MigrateException`. Examples use `name: { type: string }`. |
| `style_groups` | **Yes** | Map of group id → group config (or `-` for one anonymous group). Missing → `MigrateException`. Outer loop of generation. |
| `defaults` | No | Fallback values for `id_pattern`, `label_pattern`, `size_multiplier`, and the `base_sizes` / `size_scales` / `effects` sections. |
| `fields` | No | Optional passthrough returned by `fields()`; empty array if unset. |
| `base_sizes` / `size_scales` / `effects` | No (but needed to produce styles) | May appear under `defaults` and/or under a specific `style_groups[<id>]`; merged per section (see Merge order). |

### Per-`style_groups[<id>]` keys
All optional:
- `label` — group label, exposed as `{{group_label}}`.
- `aspect_ratio` — `'W:H'` string; drives the derived dimension and `{{aspect_ratio*}}` tokens.
- `base_size_dimension` — `width` (default) or `height`; which dimension the base size sets.
- May also carry its own `base_sizes`, `size_scales`, `effects`, `id_pattern`, `label_pattern`, `size_multiplier` to override defaults for that group.

### Pattern / multiplier keys (in `defaults` or a group)
- `id_pattern` — template for the generated machine name (the row key; duplicates collapse).
- `label_pattern` — template for the human label.
- `size_multiplier` — default `1`. Lets you express base sizes as small multiples (e.g. multiplier 40, base sizes 4/8 → 160/320).

## `base_sizes`
List (or map) of positive numeric base values. A scalar list item is the value itself; a map entry `value: {config}` can carry nested `size_scales`/`effects` overrides. Set an entry to `false` to remove it from a merged layer. Non-numeric or `< 1` → `MigrateException`.

## `size_scales`
Percentages of a base size (100 = 1×, 200 = 2×). Same scalar-or-map shape as base sizes; may be nested under `defaults.base_sizes.<size>` or `style_groups.<id>.base_sizes.<size>` for size-specific scales. `false` removes; non-numeric or `< 1` → `MigrateException`. `size = base_size × size_scale / 100`.

## `effects`
Map keyed by **image effect plugin id** (e.g. `image_scale`, `image_scale_and_crop`, `focal_point_scale_and_crop`, `image_style_quality`), value = that effect's config. Config values may contain `{{tokens}}`. Emitted in definition order with an incrementing `weight` starting at 0. Set an effect to `false` to drop it from a layer.

### Merge order (most specific wins), per section
`effects` layers, in order:
1. `defaults.effects`
2. `defaults.base_sizes.<base>.effects`
3. `defaults.size_scales.<scale>.effects`
4. `defaults.base_sizes.<base>.size_scales.<scale>.effects`
5. `style_groups.<group>.effects`
6. `style_groups.<group>.base_sizes.<base>.effects`
7. `style_groups.<group>.size_scales.<scale>.effects`
8. `style_groups.<group>.base_sizes.<base>.size_scales.<scale>.effects`

`base_sizes` merge `defaults` then `style_groups.<group>`; `size_scales` merge defaults → `defaults.base_sizes.<base>` → group → `group.base_sizes.<base>`. All via `NestedArray::mergeDeepArray(..., TRUE)`.

## `{{variable}}` tokens (for id_pattern, label_pattern, effect data)

| Token | Value |
|-------|-------|
| `{{group_id}}` | Style group machine name |
| `{{group_label}}` | Style group label |
| `{{base_size}}` | The base size |
| `{{base_size_padded}}` | `base_size × 1000`, zero-padded to 6 digits |
| `{{size}}` | `base_size × size_scale / 100` |
| `{{size_padded}}` | `size × 1000`, zero-padded to 6 digits |
| `{{size_multiplier}}` | The multiplier (default 1) |
| `{{size_scale}}` | The size scale (e.g. 150) |
| `{{size_scale_decimal}}` | `size_scale / 100` (e.g. 1.5) |
| `{{base_size_dimension}}` | `width` or `height` |
| `{{width}}` / `{{height}}` | Computed pixel dimensions |
| `{{aspect_ratio}}` | `'W:H'` or empty |
| `{{aspect_ratio_width}}` / `{{aspect_ratio_height}}` | Parsed ratio parts |

Dimension math: the base_size_dimension side = `size × size_multiplier`; the other side = `round(that × opposite_ratio / same_ratio)` when `aspect_ratio` is set, else null.

## Running it

With `migrate_plus` + `migrate_tools`:
```
drush migrate:import my_image_styles
drush migrate:rollback my_image_styles   # removes the generated styles
```
Generated entities are ordinary image styles — export via config management, deploy, and override normally. Editing the definition and re-importing updates them.

## Errors to expect
- `You must declare "ids" ...` — no `ids` in source.
- `Style groups must be defined ...` — no `style_groups`.
- `A positive base size value must be defined ...` — base size non-numeric or `< 1`.
- `A positive size scale value must be defined ...` — size scale non-numeric or `< 1`.
