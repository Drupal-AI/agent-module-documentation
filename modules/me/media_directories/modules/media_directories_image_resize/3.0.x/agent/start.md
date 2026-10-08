<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Directories Image Resize — agent index

One text filter, nothing else. It rewrites `<img width height src>` to a physically resized
derivative under `public://resize/{w}x{h}/…`. No settings form, no config object, no
permissions, no services, no schema. Depends only on core `filter` and `image` — usable
without the rest of Media Directories.

- **Enable it on a text format, filter ordering, and the exact transformation rules** →
  [plugins/resize-filter.md](plugins/resize-filter.md)

Key facts:
- Filter plugin id **`media_directories_image_resize`**, title *"Resize images"*,
  `TYPE_TRANSFORM_REVERSIBLE`, **weight 20**.
- Derivative directory constant:
  `ImageResize::DERIVATIVE_DIRECTORY === 'public://resize'`; a derivative lands at
  `public://resize/{width}x{height}/{relative path}/{filename}`.
- Only `<img>` tags with **both** `width` and `height` (and a resolvable `public://` `src`)
  are touched. SVGs are skipped. Images already at the requested size are skipped.
- The `width`/`height` attributes stay in the output; only `src` changes.
- "Place this filter **after** other filters that may add images" (its own description).
