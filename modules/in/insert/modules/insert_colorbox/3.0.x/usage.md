<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Insert Colorbox extends the Insert module with Colorbox-enabled insert styles, so an image inserted into a body/text area opens in a Colorbox lightbox and can be grouped into galleries.

---

Insert Colorbox is a submodule of Insert that adds a `colorbox__<image-style>` insert style for every image style (via `hook_insert_styles` for the image insert type) and renders those inserts through a Colorbox template (`hook_insert_render` + an `insert_colorbox_image` theme hook). It also injects an **Insert Colorbox** fieldset into the shared Insert settings form (`hook_insert_config_form`), whose two choices are saved to its own config object `insert_colorbox.config`: `style` (the image style shown inside the Colorbox — an image style name, `image` for the original, or `0` to reuse the widget's "Link image to" setting) and `gallery` (how inserted images are grouped: `post`, `page`, `field_post`, `field_page`, or `0` for no gallery). At insert time `hook_insert_variables` computes the Colorbox `gallery_id` (honouring Colorbox's unique-token setting) and the linked image URL. It depends on the contrib `colorbox` module and on `insert`; it has no route or permissions of its own beyond the shared Insert config form.

---

- Make images inserted into a body field open in a Colorbox lightbox.
- Group all inserted images on a page into a single Colorbox gallery.
- Group inserted images per node (post) into a gallery.
- Group inserted images per field within a post or page.
- Insert individual Colorbox images with no gallery grouping.
- Choose which image style is displayed inside the Colorbox (e.g. `large`).
- Show the original (full) image inside the Colorbox.
- Reuse the field widget's "Link image to" style for the Colorbox image.
- Offer editors a `Colorbox <style>` option per image style when inserting.
- Combine styled thumbnails inline with a full-size Colorbox popup.
- Provide lightbox galleries in rich-text content without a dedicated gallery field.
- Honour Colorbox's unique-token setting so galleries stay isolated per render.
- Add lightbox behaviour to article images edited in CKEditor.
- Standardise Colorbox gallery grouping across a site via one config object.
- Let a photo essay's inline images act as one navigable Colorbox gallery.
- Present documentation screenshots inline that enlarge in a lightbox.
- Configure the Colorbox insert image style and gallery mode from the Insert settings page.
- Deploy Colorbox insert settings via exported `insert_colorbox.config`.
- Switch a site from per-post to per-page galleries by changing one setting.
- Turn off gallery grouping to give every inserted image its own lightbox.
