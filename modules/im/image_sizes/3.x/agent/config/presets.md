<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building presets: UI, config, and the Drush generators

## What a preset is

An `image_sizes_preset_entity` (config, prefix `image_sizes.image_sizes_preset_entity.<id>`) bundles:

- `styles`: the ladder of core image styles the JS may choose from (keyed by their width);
- `preload`: one style for the low-res / placeholder `src`;
- `fallback`: a style machine name **or `original`**, used when nothing in the ladder is wide enough.

Manage them at `/admin/config/media/image_sizes_preset_entity` (permission
**`administer image sizes`**). Schema:
`image_sizes.image_sizes_preset_entity.*` in
`config/schema/image_sizes_preset_entity.schema.yml`.

Example (from the `image_sizes_defaults` submodule,
`image_sizes.image_sizes_preset_entity.default.yml`):

```yaml
id: default
label: Default
preload: Default_preload
styles:
  Default_1400: Default_1400
  Default_1200: Default_1200
  # …down to…
  Default_100: Default_100
fallback: original
```

Each referenced `image.style.*` is a normal core image style (a scale effect at that width, usually
plus an `image_convert` to WebP). The preset declares a config dependency on every style it uses.

## Drush: generate a full ladder + preset — `image-sizes:generate` (`isg`)

`GenerateImageSizeCommand::generate($name, $min, $max, $steps, $options)`:

```bash
# name  min  max  steps  → styles from max down to min in `steps` decrements, plus a preset
drush isg "Default" 100 1400 100
```

For each step it `ImageStyle::create()`s `<name>_<width>` with an `image_scale` effect at that
width (and an `image_convert` to `--format`, default **webp**), saves it, and `addStyle()`s it to a
new preset whose `id` is a transliterated machine name of `$name`. The last (smallest) style becomes
the `preload`, and `fallback` is set to `original`.

Options:

| Option | Effect |
|---|---|
| `--ratio=WxH` | Aspect-ratio styles: uses `image_scale_and_crop` (or focal/manual crop) at `W×H` multiples instead of plain scale. |
| `--use-focal-point` | With `--ratio`, uses `focal_point_scale_and_crop` (errors if `focal_point` is absent). |
| `--use-manual-crop` | With `--ratio`, uses `crop_crop` and creates a matching `crop_type` (errors if `image_widget_crop` is absent). |
| `--format=webp\|png\|jpeg\|jpg\|gif` | Appends an `image_convert` effect (default `webp`). |
| `--generate-thumbnail` | Builds a separate blurred 15px `<name>_preload` style (`image_effects_gaussian_blur`, needs `image_effects`) and uses it as the preset's preload. |

If a style named `$name` already exists the command aborts ("Already exists").

## Drush: bulk-add a format — `image-sizes:add-format` (`isaf`)

`AddFormatCommand`:

```bash
drush isaf webp
```

Iterates **every** existing `image_style`; for any style that lacks a `ConvertImageEffect` it
appends an `image_convert` effect with the given extension and saves. Idempotent per style (skips
those already converting).

## Quick start with defaults

Instead of running `isg`, enable the submodule to import prebuilt presets and styles:

```bash
drush en image_sizes_defaults -y   # requires image_effects
```

Ships `default`, `landscape`, `portrait` presets (100–1400px ladders + a blurred WebP `*_preload`).
See `../../modules/image_sizes_defaults/3.x/agent/start.md`.
