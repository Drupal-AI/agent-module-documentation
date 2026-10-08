<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Styles Generator — agent index

A CLI-only module: one Drush command warms (pre-generates) image-style derivatives for
every image file on the site. No UI, no config, no configure route (`configure: null`),
no permissions, no plugins, no config schema. One injectable service does the work.

- **Run the warming command, its options and aliases** → [drush/generate.md](drush/generate.md)
- **The `DerivativeWarmer` service + how the webp submodule overrides it** → [api/warmer.md](api/warmer.md)

Key facts:
- Command: `drush image:derive:multiple` (aliases `idm`, `image_derivatives:generate`).
  Options: `--image-styles=a,b` (comma-separated style IDs; default = all styles) and
  `--skip-existing` (skip derivatives already on disk). The `--image_styles` /
  `--skip_existing` underscore forms are **deprecated** aliases that emit a warning.
- It processes only **published image files** (`status = 1`, `filemime LIKE image%`).
- Service `image_styles_generator.derivative_warmer` (class `DerivativeWarmer`) wraps core
  `ImageStyle::buildUri()` + `ImageStyle::createDerivative()`.
- Submodule `image_styles_generator_webp` swaps the warmer class to also write a WebP copy.
