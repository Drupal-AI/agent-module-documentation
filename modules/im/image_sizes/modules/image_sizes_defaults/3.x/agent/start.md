<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Sizes Defaults (image_sizes_defaults) — agent index

Optional **config-only** submodule of **Image Sizes** (`image_sizes`). No PHP, no routes, no
services, no permissions — it only imports config on install. Core `^9 || ^10 || ^11`. Package
**Media**. GPL-2.0-or-later.

Depends on **`image_sizes:image_sizes`** and **`image_effects:image_effects`** (the latter for the
blurred placeholder effect). Parent docs: `../../../3.x/agent/start.md`.

## What it installs

- Three presets (`config/install/image_sizes.image_sizes_preset_entity.*`):
  - **`default`** — `preload: Default_preload`, `styles` `Default_100`…`Default_1400`,
    `fallback: original`.
  - **`landscape`** — Landscape scale-and-crop styles (e.g. `Landscape_800` = 800×600).
  - **`portrait`** — Portrait scale-and-crop styles.
- For each preset, core `image.style.*` configs: a 100→1400px ladder in 100px steps plus a
  `*_preload` (15px + `image_effects_gaussian_blur`). `Default_*` use `image_scale`; `Landscape_*`
  / `Portrait_*` use `image_scale_and_crop`. All append an `image_convert` to **webp**.

## Operate it

```bash
drush en image_sizes_defaults -y   # pulls in image_sizes + image_effects
```

Presets then appear at `/admin/config/media/image_sizes_preset_entity` and in the parent's
**"Image sizes presets"** field formatter. All management (edit/delete presets, apply the formatter)
happens through the parent module — see:

- Formatter + preset mechanics → `../../../3.x/agent/fields/formatter.md`
- Building/generating presets → `../../../3.x/agent/config/presets.md`
