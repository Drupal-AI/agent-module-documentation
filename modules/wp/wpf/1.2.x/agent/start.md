<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webp fallback image (wpf) — agent index

Generates on-demand `.jpg` copies of WebP image-style derivatives and swaps them into the Responsive
Image fallback `<img>`, so non-WebP browsers still get an image. Config object `wpf.settings`
(`quality`, `styles.disabled`). Config form at `/admin/config/media/wpf` (route `wpf.settings_form`).
Requires `file`, `responsive_image`, and the GD extension. No Drush, no plugin types.

- **Settings (`wpf.settings` keys, defaults, the config form, disabling styles)** →
  [configure/settings.md](configure/settings.md)
- **How the fallback is wired (preprocess hook, route override, lazy JPEG generation, cleanup)** →
  [api/mechanism.md](api/mechanism.md)

Key facts: `wpf.settings.quality` (int, default 75) and `wpf.settings.styles.disabled` (array of
image-style ids to skip). The `.jpg` is created lazily when its URL is requested (the module overrides
the core `image.style_public`/`image.style_private` route controller). Fallback swap happens in
`hook_preprocess_responsive_image()` via `ImageFactory::getJpg()`. Intended pipeline: image style
converts to WebP → responsive image style → used in an entity display.
