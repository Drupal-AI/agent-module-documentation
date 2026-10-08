<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bunny Optimizer (bunny_optimizer) — agent index

A Drupal **image toolkit** that serves image-style derivatives through **Bunny.net's** real-time
optimizer CDN by **rewriting the derivative URL with query parameters** — it never processes or
writes image files on the server. Package `Media`. Depends on core **`file`**, **`image`**, and
**`file_mdm`** (File MDM). Core `^9.3 || ^10 || ^11`, PHP `7.4`. License GPL-2.0-or-later.
Version 1.1.3.

- **Toolkit, URL generation, config, install/enable** → [image-toolkit/toolkit.md](image-toolkit/toolkit.md)
- **Every effect and operation (parameter mapping)** → [image-effects/effects.md](image-effects/effects.md)

## What it actually is (from source)

- One **image toolkit** plugin: `BunnyOptimizerToolkit` (id **`bunny_optimizer`**), in
  `src/Plugin/ImageToolkit/BunnyOptimizerToolkit.php`, extending core `ImageToolkitBase`. Its
  `save()`/`parseFile()`/`isValid()` are no-ops; `getWidth/Height/MimeType()` read the source via
  File MDM's `getimagesize`. It holds an in-memory `$params` array (`setParameter`/`getParameters`)
  and exposes the configured `cdn_hostname`.
- Config entity override: `BunnyOptimizerImageStyle` (`src/Entity/`) replaces core `ImageStyle`
  **only while `bunny_optimizer` is the default toolkit** (swapped in by
  `bunny_optimizer_entity_type_alter()`). Its `buildUrl()` runs every effect to populate toolkit
  params, then returns `scheme://host/path?query` — `host` swapped to `cdn_hostname` when set,
  query built with `http_build_query()`. `buildUri()` returns the original URI; `flush()` is a
  deliberate no-op (no derivative files exist to delete).
- **Toolkit operations** (`src/Plugin/ImageToolkit/Operation/`): `Resize`, `Scale`, `Crop`,
  `ScaleAndCrop`, `Convert`, `Desaturate`, and the generic `BunnyOptimizerParam`
  (id `bunny_optimizer_param`) — each just calls `setParameter()` on the toolkit. `Convert` is a
  pure no-op (Bunny picks the output format).
- **Image effects** (`src/Plugin/ImageEffect/`): `AutoOptimizeImageEffect`, `Blur`, `Brightness`,
  `Contrast`, `Flip`, `Flop`, `Hue`, `Quality`, `Saturation`, `Sepia`, `Sharpen`,
  `FaceCropImageEffect`, plus `ConvertImageEffect` / `ScaleAndCropImageEffect` (swapped over core's
  by `bunny_optimizer_image_effect_info_alter()`) and `BunnyOptimizerClassImageEffect`
  (id `bunny_optimizer_class`, applies a Bunny "image class" preset). Each `applyEffect()` calls
  `$image->apply('bunny_optimizer_param', ['key' => …, 'value' => …])`.
- **Config**: one config object `bunny_optimizer.settings` with a single key `cdn_hostname` (string,
  default `''`); schema in `config/schema/bunny_optimizer.schema.yml`, install default in
  `config/install/`. Configured on the core image-toolkit form (`configure:
  system.image_toolkit_settings`) via the toolkit's `buildConfigurationForm()`.
- **No** custom routes, **no** permissions, **no** Drush, **no** REST/webhook endpoints, **no**
  server-side HTTP client, and **no** stored API credentials. The only declared service is a logger
  channel `logger.channel.bunny_optimizer`.

## Requirements

- A Bunny CDN account with a **pull zone** that serves your images (from an origin or a Bunny
  storage zone). Optionally set `cdn_hostname` to that pull zone's hostname; leave it empty if the
  site's own hostname is already fronted by Bunny CDN. The *Bunny CDN* module pairs with it for
  full-page caching.
