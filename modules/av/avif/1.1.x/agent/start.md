<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Avif (avif) — agent index

Serves **AVIF** copies of core image-style derivatives to browsers that accept them, falling
back to the original derivative for the rest. Works by (a) taking over the core
`image.style_public` route with its own controller and (b) injecting an extra
`<source type="image/avif">` into every `responsive_image` render. Depends only on core
`image`; needs an image toolkit that can encode AVIF at runtime (ships one processor plugin
that drives the contrib `imagemagick` toolkit).

Core requirement `^10.3 || ^11`. Newest release on this branch is `1.1.0-rc1` (a release candidate).
Settings at `/admin/config/media/avif` (route `avif.settings_form`, permission
`administer site configuration`). No permissions, drush commands, or submodules of its own.

- **Set the processor and quality** → [configure/settings.md](configure/settings.md)
- **Add your own encoder backend (plugin type)** → [plugins/avif_processor.md](plugins/avif_processor.md)
- **The `avif.avif` service + how requests are served** → [api/avif_service.md](api/avif_service.md)
- **The responsive-image preprocess that adds the AVIF `<source>`** → [hooks/responsive_image.md](hooks/responsive_image.md)

Key facts:
- Config object `avif.settings`: `processor` (string, plugin id; empty/`undefined` = disabled) and
  `quality` (int 1–100, default `60`). Schema in `config/schema/avif.schema.yml`.
- Plugin type **AvifProcessor** — manager service `plugin.manager.avif_processor`
  (`AvifProcessorManager`), annotation `@AvifProcessor`, interface `AvifProcessorInterface::convert()`,
  base `AvifProcessorBase`, directory `Plugin/AvifProcessor/`, alter hook `avif_avif_processor_info`.
- Only shipped plugin: `imagemagick` (`Plugin/AvifProcessor/ImageMagick.php`) — encodes via the
  contrib `drupal/imagemagick` toolkit's `convert` operation. GD and CAVIF are named in the project
  page but are **not** shipped here.
- Service `avif.avif` = `Drupal\avif\Avif`: `getAvifCopy($uri, $quality = NULL)` and static
  `Avif::getAvifSrcset($srcset)`.
- Serving: `avif.route_subscriber` (`RouteSubscriber`) repoints `image.style_public` to
  `Drupal\avif\Controller\ImageStyleDownloadController::deliver`; it wraps the core controller and
  only diverges when `?file=` ends in `.avif` and the request `Accept`s `image/avif`.
- `drupal/imagemagick` is a composer `require-dev` here; install a toolkit with AVIF support to use it.
