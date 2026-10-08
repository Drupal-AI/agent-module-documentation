<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Styles Generator adds a Drush command that pre-generates (warms) image-style derivatives for every image file on the site, so the derivatives already exist on disk instead of being built lazily on first request.

---

The module has no UI, no settings form, no configure route, no permissions and no config — it is purely a Drush command plus one service. The command `image:derive:multiple` (aliases `idm`, `image_derivatives:generate`) queries all published image files (`filemime LIKE image%`, `status = 1`), loads every `image_style` config entity (or only the ones named with `--image-styles=`), and for each file/style pair calls a `DerivativeWarmer` service that runs core's `ImageStyle::buildUri()` + `ImageStyle::createDerivative()` to write the derivative. A progress bar reports totals. `--skip-existing` skips pairs whose derivative file already exists on disk. The default behaviour regenerates unconditionally. The typical use is warming caches in CI/CD, after a deployment, or after flushing image styles, so visitors never pay the first-hit derivative-generation cost. The bundled `image_styles_generator_webp` submodule decorates the warmer to also emit a WebP copy of each derivative.

---

- Warm every image style for every image on the site before launch so no visitor triggers on-the-fly derivative generation.
- Pre-generate derivatives in a CI/CD pipeline so screenshot/visual-regression tests are not skewed by first-hit image build time.
- Regenerate all derivatives after running `drush image:flush` (image style caches cleared).
- Generate only specific styles with `drush image:derive:multiple --image-styles=large,thumbnail`.
- Skip already-built derivatives on a re-run with `--skip-existing` to make warming idempotent and fast.
- Warm derivatives after adding a new image style so existing content immediately has the new size.
- Warm derivatives after editing an image style's effects so every image reflects the change.
- Populate a CDN/origin cache by generating all derivatives, then letting the CDN pull them.
- Reduce time-to-first-byte on image-heavy landing pages by pre-building their responsive image sizes.
- Move derivative-generation CPU load to a scheduled off-peak cron/deploy job instead of live traffic.
- Rebuild derivatives on a fresh environment after copying originals from production.
- Ensure all image styles exist on disk before a load test so the test measures serving, not generation.
- Warm derivatives for a headless/decoupled backend so the frontend gets ready URLs.
- Batch-generate WebP copies of every derivative (with the `image_styles_generator_webp` submodule + the `webp` module).
- Script derivative warming from a deploy hook (`drush idm --skip-existing`).
- Verify that every image style can actually build for the current image toolkit by generating them all.
- Pre-warm derivatives for a small set of critical styles only, keeping deploy time short.
- Regenerate derivatives after switching image toolkit (GD ↔ ImageMagick).
- Call the `image_styles_generator.derivative_warmer` service from custom code to warm a single file/style pair.
- Force a full rebuild (omit `--skip-existing`) after corrupting or partially clearing the derivative directory.
- Warm derivatives for migrated content immediately after a migration import.
- Provide a predictable, repeatable derivative-generation step for release runbooks.
