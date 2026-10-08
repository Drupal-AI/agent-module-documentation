<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Styles Generator WebP — agent index

Glue submodule of `image_styles_generator`. It makes the parent warm command
(`drush image:derive:multiple`) also write a `.webp` copy of every derivative it builds.
No command, route, config, permission or plugin of its own.

- **How the service override works** → [api/override.md](api/override.md)

Key facts:
- Depends on `webp:webp` (contrib) and `image_styles_generator:image_styles_generator`.
- `ImageStylesGeneratorWebpServiceProvider::alter()` swaps the class of the existing
  `image_styles_generator.derivative_warmer` service to `DerivativeWebpWarmer` and appends
  a `@webp.webp` argument.
- `DerivativeWebpWarmer::regenerateImageStyleDerivativeFromFile()` calls the parent (normal
  derivative) then `Webp::createWebpCopy($derivative_uri)`.
- Enabling the submodule is the entire configuration — the parent's Drush command then emits
  WebP copies automatically.
