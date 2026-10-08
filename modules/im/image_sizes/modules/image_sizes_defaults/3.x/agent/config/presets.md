<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The default presets and styles this submodule ships

`image_sizes_defaults` is a config-only submodule: enabling it imports everything under
`config/install/` and does nothing else. Nothing here overrides parent behavior — the presets are
ordinary `image_sizes_preset_entity` config you can edit or delete after install.

## Install

```bash
drush en image_sizes_defaults -y
```

Pulls in `image_sizes` and `image_effects` (declared in `image_sizes_defaults.info.yml`). Because
`image_effects` is required for the gaussian-blur preload effect, enabling fails if it cannot be
installed.

## Presets

`config/install/image_sizes.image_sizes_preset_entity.{default,landscape,portrait}.yml`:

| Preset id | preload | styles | fallback |
|---|---|---|---|
| `default` | `Default_preload` | `Default_100` … `Default_1400` (14 scale styles) | `original` |
| `landscape` | `Landscape_preload` | `Landscape_100` … `Landscape_1400` (scale-and-crop) | `original` |
| `portrait` | `Portrait_preload` | `Portrait_100` … `Portrait_1400` (scale-and-crop) | `original` |

Each preset lists a config dependency on every image style it references (added by the parent
entity's `calculateDependencies()`).

## Image styles

For each family the submodule ships `config/install/image.style.<Family>_<width>.yml`:

- **`Default_<w>`** — one `image_scale` effect at `width: <w>` (height null, no upscale) + an
  `image_convert` to `webp`. No crop, so aspect ratio is preserved.
- **`Landscape_<w>` / `Portrait_<w>`** — one `image_scale_and_crop` at a fixed ratio (e.g.
  `Landscape_800` = 800×600, `anchor: center-center`) + `image_convert` to `webp`.
- **`<Family>_preload`** — `image_scale` to 15px + `image_effects_gaussian_blur`
  (`radius: 3`) + `image_convert` to `webp`. This is the blurred low-res placeholder shown before
  the JS swaps in the full derivative; it is the source of the `image_effects` dependency.

## Using them

Apply the parent's **"Image sizes presets"** formatter to an image or media field and pick
`default`, `landscape`, or `portrait` (see `../../../3.x/agent/fields/formatter.md`). To customize,
clone a preset in the UI (`/admin/config/media/image_sizes_preset_entity`) or add/remove styles;
you do not need this submodule enabled once you have your own presets.
