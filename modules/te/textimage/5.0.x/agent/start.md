<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Textimage — agent index

Renders text onto images by combining Image Effects' **"Text overlay"** effect with text from
field values, the API, or a URL. Ships two field formatters, a fluent PHP factory service,
two tokens, and a settings form. Requires `image` + `image_effects` (contrib) and the GD2 +
FreeType PHP libraries. Config UI: `textimage.settings` (`/admin/config/media/textimage`).

Core model: an **image style** with one or more "Text overlay" effects is the template; the
effect's *Default text* is replaced at render time by supplied text.

- **Settings, image-style Textimage options, cleanup, default font** →
  [configure/settings.md](configure/settings.md)
- **Text & Image field formatters (how to display a field as a Textimage)** →
  [configure/formatters.md](configure/formatters.md)
- **The `textimage.factory` fluent API — build images in PHP** →
  [api/factory.md](api/factory.md)
- **Tokens (`textimage-url` / `textimage-uri`) and hooks Textimage implements** →
  [hooks/tokens-and-hooks.md](hooks/tokens-and-hooks.md)
- **`textimage_formatter` theme hook and its variables** →
  [theming/formatter.md](theming/formatter.md)
- **Permission: `generate textimage url derivatives`** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts: formatter ids `textimage_text_field_formatter` and `textimage_image_field_formatter`;
service id `textimage.factory` (interface `Drupal\textimage\TextimageFactoryInterface`);
settings config object `textimage.settings`; direct-URL generation is OFF by default and gated by
the permission above.
