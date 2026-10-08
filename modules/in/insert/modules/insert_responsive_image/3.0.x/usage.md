<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Insert Responsive Image extends the Insert module with an insert style for every Responsive Image style, so editors can drop a responsive `<img>` (with `srcset`/`sizes`) into a body or text area.

---

Insert Responsive Image is an experimental style-provider submodule of Insert with no configuration or state of its own. For the image insert type it implements `hook_insert_styles` to add one insert style per Responsive Image style, named `responsive_image__<style-id>` (label `Responsive: <id>`), by loading every `ResponsiveImageStyle` entity. At insert time its `hook_insert_variables` implementation runs after the parent's (via `hook_module_implements_alter`), calls core's `template_preprocess_responsive_image()` to compute the `srcset` and `sizes` attributes for the file, resolves the fallback image style URL, and merges those attributes into the Insert template variables. There is no config object, no configure route, no permissions, and no per-widget setting of its own — it simply makes responsive-image options selectable in the parent Insert module's per-widget `styles` list. It depends on core `responsive_image` and on `insert`.

---

- Offer a "Responsive: wide" insert option on an image field so inserted images use `srcset`/`sizes`.
- Let editors drop a responsive image into a node body that adapts to the viewport.
- Expose every configured Responsive Image style as an inline insert option.
- Insert responsive images that serve smaller derivatives to mobile devices.
- Improve inline image performance by inserting responsive markup instead of a single derivative.
- Provide art-directed responsive images inline via a Responsive Image style's breakpoints.
- Standardise responsive inline images across content types.
- Add responsive image insertion without touching CKEditor's media embed.
- Reuse an existing Responsive Image style (e.g. `narrow`, `wide`) for inline body images.
- Give a photo-heavy article responsive inline images with correct `sizes`.
- Combine the responsive insert style with the parent Insert width/link settings.
- Fall back to the Responsive Image style's fallback image style when needed.
- Enable a `responsive_image__<id>` style in an image widget's Insert settings.
- Serve appropriately-sized inline images to retina and non-retina screens.
- Let authors pick which responsive style to use per inserted image.
- Migrate inline images to responsive markup by selecting the responsive insert styles.
- Keep inline image markup responsive on decoupled/front-end rendering.
- Present inline product images responsively in editorial content.
- Use responsive inline images alongside Colorbox or plain inserts on the same field.
- Roll out responsive inline images to an editorial team through one insert style choice.
