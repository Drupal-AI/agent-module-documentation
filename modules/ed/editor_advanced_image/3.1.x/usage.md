<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Editor Advanced Image adds a CKEditor 5 plugin that lets content authors set the `title`, `class`, and `id` HTML attributes on inline images, plus optionally apply a default CSS class to every inserted image.

---

The module ships a single CKEditor 5 plugin (`editorAdvancedImage.EditorAdvancedImage`) that extends the core image balloon toolbar with an "Editor Advanced Image" button. Clicking it opens a small form where the author can edit the image's `title`, `class`, and/or `id` attributes — only the attributes an administrator allowlisted for that text format are shown. Which attributes are offered, whether the balloon button is shown at all, and a default class applied to newly inserted images are all configured per text format on the CKEditor 5 configuration form under *Editor Advanced Image*. There is no dedicated admin page or configure route: settings live inside each `editor.editor.<format>` config entity at `settings.plugins.editor_advanced_image_image`. The plugin declares the elements `<img title class id>` so those attributes survive Drupal's filter/allowed-HTML processing, and it only loads when the core `ckeditor5_image` plugin is enabled. Enabled attributes are also injected into the text format's "Allowed HTML tags" via `getElementsSubset()`. The PHP side (`EditorAdvancedImage` CKEditor5Plugin) provides the settings form and hands dynamic JS config (`editorAdvancedImageOptions`) to the browser; all editing behavior is implemented in the bundled JavaScript.

---

- Let editors add a `title` attribute (tooltip) to inline images in CKEditor 5.
- Allow authors to assign one or more CSS `class` values to an image from the editor.
- Let authors set a unique `id` on an inline image for in-page anchor links.
- Automatically apply a default class (e.g. `img-fluid`) to every image inserted in a text format.
- Restrict which image attributes editors may edit, per text format, via an allowlist.
- Hide the advanced-image balloon button entirely on a format by ticking "Disable Balloon".
- Give a Bootstrap-themed site responsive images by defaulting inserted images to `img-responsive`.
- Add accessibility hints by exposing the `title` attribute on images to editors.
- Ensure `<img title class id>` attributes survive the text format's HTML filtering.
- Configure different attribute sets for a "Full HTML" versus a "Basic HTML" format.
- Provide an anchor target by letting an editor set an image `id` used by a table of contents.
- Standardize image styling by forcing a utility class on all editorial images.
- Let a marketing team tag hero images with campaign-specific CSS classes.
- Add print-specific or theme-specific classes to images without leaving the editor.
- Keep image markup clean by only enabling the `class` attribute and nothing else.
- Migrate from CKEditor 4's advanced image dialog to the CKEditor 5 balloon equivalent.
- Let editors edit an existing image's classes by selecting it and opening the balloon form.
- Enforce a house style where every inserted image starts with a known wrapper class.
- Support deep-linking to specific images via editor-assigned `id` values.
- Expose the tooltip/`title` only for a documentation format where hover hints matter.
- Configure the plugin entirely through exported config for deployment (`editor.editor.<format>`).
