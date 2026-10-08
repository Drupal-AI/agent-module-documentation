<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Creating Engine (image_creating_engine) — agent index

Submodule of **Dynamic Image Generator**. Provides the local **"Built-in Image Engine"**
rendering backend: turns rendered HTML/CSS into an image by shelling out to the
**`wkhtmltoimage`** binary. Version 1.1.2 (dir `1.1.x`). Core `^10`. GPL-2.0-or-later.
Depends on `dynamic_image_generator:dynamic_image_generator`. Composer requires
`spatie/browsershot:^3.0` (declared, but the shipped code uses the wkhtml CLI, not Browsershot).

No routes, permissions or config schema of its own.

## What it provides

- **Service `image_creating_engine.generator`** → `src/Service/InbuiltImageGenerator.php`
  (`generateImage($html, $css, $options)` returns `{uri, file, url, width, height, format,
  generator, success}` or NULL). Also a second service id `image_creating_engine.wkhtml_generator`
  that, in 1.1.2, is **also** wired to `InbuiltImageGenerator` (see services.yml). → [services/engine.md](services/engine.md)
- **Plugin** `InbuiltImageGeneratorPlugin` (`@ImageGenerator id = "inbuilt"`, label "Built-in
  Image Engine") in `src/Plugin/ImageGenerator/`, delegating to the generator service.
- `image_creating_engine.module` (empty stub) and `debug.php` (a `\Drupal::logger()` helper
  function `image_creating_engine_debug()`; not web-reachable, executes nothing on load).
- An unused `src/Service/WkhtmlImageGenerator.php` class (similar to InbuiltImageGenerator but with
  extra wkhtml flags); it is referenced by the parent's `testWkhtml` diagnostic but is not the
  class wired to either service id in 1.1.2.

## How it is used

The parent service `DynamicImageGeneratorService::callPosterGenerationApi()` calls
`\Drupal::service('image_creating_engine.generator')->generateImage(...)` when
`api_provider = inbuilt`. Output goes to `public://dynamic_image_generator/generated`.

Requires the OS package `wkhtmltopdf` (provides `wkhtmltoimage`) on the server.

## Docs

- [services/engine.md](services/engine.md) — the InbuiltImageGenerator service, command building, output.
