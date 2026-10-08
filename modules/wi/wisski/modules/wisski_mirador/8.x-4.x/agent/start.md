<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Mirador (wisski_mirador) — agent index

Submodule of **wisski**. Integrates the **Mirador** IIIF viewer.
Version **8.x-4.3**. Core `>=10.4 <12`.

**Comparison is the point** — two manuscripts from different libraries side by side in one window
is what IIIF exists for, and for a research collection that is the actual work, not a nicety.

**Mirador is the viewer, not the server.** IIIF needs an image server speaking the IIIF Image API —
see `wisski_iip_image`. A collection whose images are ordinary files on disk needs that layer
first.

`wisski_mirador_block` places a viewer as a block.