<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Helper (media_helper) — agent index

**Twig filters/functions + an image field formatter for rendering Media images/videos with image styles.**

- **Version:** 2.0.x (2.0.3)
- **Core:** ^10.2 || ^11 — depends on file, image, media.
- **Configure:** `media_helper.settings` → `/admin/config/media/media-helper` (perm `administer site configuration`).
- **Twig (service `media_helper.twig_extension`):** filters `media_image`, `media_image_url`, `media_video`, `media_first_nonempty`; functions `media_bundle`, `media_source`.
- **Service:** `media_helper` (`src/Service/MediaHelper.php`); formatter `src/Plugin/Field/FieldFormatter/RenderedImage.php`.
- **Integrations:** responsive_image (auto), svg_image, svg_image_field (config-gated).
- **Permissions:** none of its own (settings route uses `administer site configuration`).
- **Security:** rendering only; `renderMediaImage()`/`renderVideo()` enforce `$media->access('view')` and bubble cache metadata. No creation/mutating routes; SVG reads use the media's own file URI, not user input. No security findings.

See [api/twig.md](api/twig.md).