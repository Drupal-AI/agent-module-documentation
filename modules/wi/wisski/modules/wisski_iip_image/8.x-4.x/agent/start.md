<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI IIP Image (wisski_iip_image) — agent index

Submodule of **wisski**. **IIP Image** view for images — tiled delivery for very high-resolution
material. Version **8.x-4.3**. Core `>=10.4 <12`.

A 400-megapixel manuscript scan cannot be delivered as a file. Tiled servers deliver only the
tiles for the visible region and zoom level.

**This is infrastructure, not a setting.** IIPImage is a separate server process to install,
configure and keep running, with images in a tiled format (typically pyramidal TIFF) produced by a
conversion step. **Budget the server and its storage before a digitisation campaign** —
retrofitting means reprocessing everything.