<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Embed Extra adds per-embed **width and height override** fields to the core media embed dialog, so an editor can resize an individual embedded image media item straight from the WYSIWYG editor.

---

The module is a thin enhancement of core Media's embedding. It does two things. First, `hook_form_editor_media_dialog_alter()` adds a **Dimensions** fieldset (Width / Height number fields) to the "Edit media" dialog, but only when the embedded item is an image (it keys off the presence of the `alt` field), storing the chosen values as `data-width` and `data-height` attributes on the `<drupal-media>` tag. Second, `hook_filter_info_alter()` swaps the class of the core `media_embed` filter for its own `Drupal\media_embed_extra\Plugin\Filter\MediaEmbed` subclass, whose `applyPerEmbedMediaOverrides()` reads those `data-width`/`data-height` attributes at render time and overrides the image field's `width`/`height` (scaling proportionally when only one is supplied). It defines no field type, config entity, settings form, permission, or Drush command. To work end to end, the text format used by the editor must have the **Embed media** (`media_embed`) filter enabled and — if **Limit allowed HTML tags** is on — must allow the `<drupal-media>` tag together with the `data-width` and `data-height` attributes. It only affects image-source media; non-image media (with no image field) is untouched.

---

- Let an editor resize a single embedded image to a specific pixel width without changing the source media.
- Set an explicit height on one embedded image while leaving others at their natural size.
- Provide only a width and have the height scale proportionally (or vice versa).
- Constrain a hero image embedded in body copy to a fixed layout width.
- Give WYSIWYG authors per-embed dimension control without teaching them HTML.
- Add `data-width`/`data-height` attributes to `<drupal-media>` tags via the dialog UI.
- Override embedded image dimensions per article without creating extra image styles.
- Keep the same media entity but display it at different sizes on different pages.
- Enable dimension overrides on Full HTML by allowing `<drupal-media data-width data-height>`.
- Configure a custom text format so only certain roles can resize embedded media.
- Shrink an oversized embedded product image inline in a description field.
- Make an embedded logo a consistent width across body content.
- Let content teams fine-tune image sizing during editing instead of filing a design ticket.
- Reuse a single high-resolution media item and downscale it per placement.
- Present a decorative image at a small inline size while its media library copy stays full-size.
- Ensure only image-type media shows the Dimensions fields (non-image embeds are unaffected).
- Combine with the Align/Caption filters (order media_embed after them) for sized, captioned embeds.
- Standardise embedded image widths in a migration by writing `data-width` onto `<drupal-media>` tags.
- Avoid custom CKEditor plugins just to get width/height controls on media.
- Let authors match an embedded image's width to a surrounding grid column.
- Provide fallback proportional scaling so authors need only enter one dimension.
- Resize embedded images in landing-page rich text without a full layout tool.
- Support responsive-ish authoring by letting editors pick a max width per embed.
- Keep stored media metadata intact while overriding only the rendered image size.
