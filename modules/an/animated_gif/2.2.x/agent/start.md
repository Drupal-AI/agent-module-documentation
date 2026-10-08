<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Animated GIF — agent index

Renders animated GIFs without an image style so their animation survives (GD-based image styles
would flatten them to one frame). No settings form, no `configure` route, no permissions, no Drush.
Config schema: `field.formatter.settings.animated_gif_image_url` (extends `image_url`).

- **Detection service (`AnimatedGif`): how it decides a GIF is animated** →
  [api/service.md](api/service.md)
- **Field formatter `animated_gif_image_url` (Image URL without a style for GIFs)** →
  [plugins/formatter.md](plugins/formatter.md)
- **The preprocess hooks that strip image styles for animated GIFs + the editor warning** →
  [hooks/rendering.md](hooks/rendering.md)

Key facts: service id = interface FQN `Drupal\animated_gif\Service\AnimatedGifInterface`; a GIF is
"animated" when ≥2 frame headers are found (`MINIMUM_NUMBER_OF_ANIMATED_FRAMES = 2`) and the file is
`image/gif`. Formatter plugin id `animated_gif_image_url`. Just enabling the module makes core image
formatters bypass styles for animated GIFs automatically.
