<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Flexi Gallery

1. Enable: `drush en flexi_gallery -y`.
2. On a bundle with a **multi-value image field**, go to *Manage display* and set that field's format to **Flexi Gallery**.
3. Open the formatter settings (gear) and configure:
   - **Show big image** + **Big image style** — the large image derivative.
   - **Wrap big image with link to original** and **Original image style** — link target (raw file or a style).
   - **Open preview image in colorbox** / **in fancybox** — lightbox integration (requires the respective module).
   - **Show small images** + **Small image style** — the thumbnail derivative.
   - **Number of visible small images** — thumbnail cap.
4. Save. Output is themed by `templates/flexi-gallery.html.twig` and the `flexi_gallery/main` library (jQuery + once).

Colorbox is attached via the `colorbox.attachment` service on the first image; Fancybox attaches the `fancybox_ui/fancybox` library and a `data-fancybox` group attribute.