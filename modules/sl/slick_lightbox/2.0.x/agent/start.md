# Slick Lightbox — agent index

Opens images/Media videos in a **Slick carousel inside a lightbox**. It has **no formatter of
its own** and **no configure route** (`configure: null`). You use it by picking it as a
**Media switcher** on a Blazy/Slick formatter; its slider behaviour comes from one Slick
**optionset** config entity.

- **How to enable it on a field / filter (the "Image to Slick Lightbox" Media switcher) and
  the optionset it reads** → [configure/media-switch.md](configure/media-switch.md)

Key facts:
- Media switcher value: `slick_lightbox` (label "Image to Slick Lightbox"), registered via
  `hook_blazy_lightboxes_alter()`.
- Optionset config entity: `slick.optionset.slick_lightbox` (id `slick_lightbox`); edit UI at
  `/admin/config/media/slick/list/slick_lightbox/edit` (needs the `slick_ui` sub-module).
- Front-end library required at `/libraries/slick-lightbox/dist/slick-lightbox.min.js`
  (github.com/mreq/slick-lightbox); `hook_requirements()` reports if missing.
- Depends on `slick` (>= 3.x), which depends on Blazy. No permissions, services, or Drush.
