<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imagefield Slideshow adds a field formatter for multi-value **image** fields that renders the uploaded images as a jQuery Cycle2 slideshow instead of a stack of pictures.

---

The module's entire surface is one field formatter plugin, `imagefield_slideshow_field_formatter` (`ImagefieldSlideshowFieldFormatter`, extending core `ImageFormatterBase`, `field_types = {image}`). You enable it per view mode on a content type's *Manage display* page for any image field, and its per-formatter settings are stored in the `entity_view_display` config entity's component `settings`. The formatter renders the images through the `imagefield_slideshow` theme hook, which is driven by the bundled **jQuery Cycle2** library (`js/jquery.cycle2.js` plus CDN-loaded effect plugins) declared in `imagefield_slideshow.libraries.yml`. Available settings include an image style (`imagefield_slideshow_style`), transition effect (`imagefield_slideshow_style_effects`: `none`, `fade`, `fadeout`, `scrollHorz`, `flipHorz`, `flipVert`, `shuffle`), pause-on-hover, prev/next buttons, transition speed, timeout, a default pager, an image pager, and a "link image to" target (nothing / content / file). The slideshow behaviour (prev-next, pager, image-pager) is only activated when the field holds more than one image, so the field must allow multiple values. Output caching is disabled for the formatter (`max-age = 0`). The module has no settings form, no configure route, no permissions, no Drush, and no config schema of its own — everything lives in the view-display component settings.

---

- Render a multi-image gallery field as an automatic slideshow on node view.
- Turn a product's image field into a rotating carousel in the full view mode.
- Show a homepage banner field as a fading slideshow.
- Pick a transition effect (fade, scrollHorz, flipHorz, flipVert, shuffle) per display.
- Apply a named image style to every slide (e.g. `large`) via the formatter settings.
- Show the original images with no image style by choosing "None (original image)".
- Enable Prev & Next navigation buttons on the slideshow.
- Enable a default pager (dots) under the slideshow.
- Enable an image (thumbnail) pager instead of / alongside the dot pager.
- Pause the slideshow when the visitor hovers over it.
- Set the transition speed between slides (100–10000).
- Set the timeout each slide is shown before advancing.
- Link each slide to its parent content (node) so clicking a slide opens the node.
- Link each slide to the original image file.
- Configure a different effect per view mode (e.g. fade on teaser, scrollHorz on full).
- Constrain editors to whole galleries by using an unlimited-value image field.
- Provide a lightweight slider without adding a Views or JS-library dependency of your own.
- Export the slideshow configuration as part of the view display config for deployment.
- Fall back gracefully to a single static image when the field has only one value.
- Standardise gallery presentation across content types by reusing the same formatter settings.
- Combine with core image fields' alt/title, which are carried through to each slide.
