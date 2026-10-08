<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Effect — agent index

Adds an **advance resize** image-style effect with **GD** and **ImageMagick** toolkit operations. Version **2.0.2**. Core `^9 || ^10`.

- Plugins: `src/Plugin/ImageEffect/AdvanceResizeImageEffect.php`; toolkit ops under `Plugin/ImageToolkit/Operation/gd/` and `imagick/`.
- Configured via image-styles UI (`administer image styles`). No own routes/permissions; local processing only.
