<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Styles Generator WebP is a glue submodule that makes the parent `image_styles_generator` warm command also write a WebP copy of every image-style derivative it generates.

---

The submodule adds no command, route, config, permission or plugin. It ships a single service provider (`ImageStylesGeneratorWebpServiceProvider::alter()`) that rewrites the parent's `image_styles_generator.derivative_warmer` service definition to use the subclass `DerivativeWebpWarmer` and injects the `@webp.webp` service. `DerivativeWebpWarmer` extends the parent `DerivativeWarmer`: it calls the parent to build the normal derivative, then calls `Webp::createWebpCopy($derivative_uri)` to emit a `.webp` alongside it. Because it decorates the same service ID, the unchanged `drush image:derive:multiple` command transparently produces WebP copies once this submodule is enabled. It requires both the parent module and the contrib `webp` module.

---

- Pre-generate a WebP copy of every image-style derivative during cache warming.
- Serve modern WebP images to supported browsers while keeping original-format derivatives as fallback.
- Warm both standard and WebP derivatives in one CI/CD step with `drush image:derive:multiple`.
- Reduce image payload sizes site-wide by ensuring WebP variants exist for all styles.
- Pair with the `webp` module's frontend delivery so warmed WebP files are actually served.
- Emit WebP copies after a deployment so first visitors get the smaller files immediately.
- Batch-create WebP derivatives for migrated image content.
- Warm WebP copies for a subset of styles via `--image-styles=large,hero`.
- Make WebP generation idempotent with `--skip-existing` on re-runs.
- Ensure WebP variants exist before running Lighthouse/performance audits.
- Offload WebP conversion CPU cost to a deploy/cron job rather than live requests.
- Keep WebP derivatives in sync after editing image-style effects (re-run the warm command).
- Generate WebP copies for a headless/decoupled frontend that prefers WebP URLs.
- Provide WebP output without changing any existing warm-command invocation (drop-in via service override).
- Warm WebP derivatives across all published image files on the site in a single command.
