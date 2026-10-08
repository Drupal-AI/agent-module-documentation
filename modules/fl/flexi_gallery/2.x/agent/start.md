<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flexi Gallery (flexi_gallery) — agent index

**A multi-value image-field formatter rendering big images + a thumbnail strip, with per-set image styles, link-to-original, and optional Colorbox/Fancybox lightboxes.**

- **Version:** 2.x
- **Core:** ^9 || ^10 || ^11 || ^12 || ^13 || ^14 || ^15
- **Plugin:** FieldFormatter `flexi_gallery` (`FlexiGalleryFormatter`).
- **Theme/template:** `flexi_gallery` → `templates/flexi-gallery.html.twig`; library `flexi_gallery/main` (jQuery, once).
- **Optional integrations:** Colorbox (`colorbox.attachment`), Fancybox (`fancybox_ui/fancybox`) — attached only when selected.
- **Configure:** field *Manage display* → choose Flexi Gallery formatter.

**Security:** display-only field formatter; markup built with core `image`/`image_style` render elements and `Attribute`; no routes, permissions, or user-supplied HTML — no findings.

See [configure/flexi_gallery.md](configure/flexi_gallery.md).