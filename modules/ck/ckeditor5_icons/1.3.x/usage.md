<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Icons adds an **Icons** toolbar button to CKEditor 5 that opens a native, searchable Font Awesome icon picker, inserting the chosen icon as an `<i class="fa-solid fa-heart">` element that can then be resized, aligned and restyled from a widget balloon toolbar.

---

The module registers a single CKEditor 5 plugin, `ckeditor5_icons_icon`, declared in `ckeditor5_icons.ckeditor5.yml` and backed by `Drupal\ckeditor5_icons\Plugin\CKEditor5Plugin\Icon`. Configuration is **per text format**: you add the `icon` toolbar item on a format's *Configure editor* page and the plugin's vertical tab then exposes the Font Awesome version (6 or 5), which styles are selectable, whether metadata is loaded asynchronously, and an optional "Recommended" category with a custom icon list. All of that is stored inside `editor.editor.<format>` under `settings.plugins.ckeditor5_icons_icon` (schema `ckeditor5.plugin.ckeditor5_icons_icon`), so there is **no global settings form and no `configure` route**. The icon catalogue itself ships with the module as YAML metadata for Font Awesome 5.15.4 and 6.7.2 (`libraries/fontawesome{5,6}/metadata/{icons,categories}.yml`, ~1.4k and ~1.9k icons), read and cached by the `ckeditor5_icons.CKEditor5Icons` service. When *Load metadata asynchronously* is on (the default) the picker fetches that catalogue on demand from a CSRF-protected route registered dynamically by `MetadataRouting` at `/modules/contrib/ckeditor5_icons/metadata/fontawesome{6,5}`; when off, the whole catalogue is inlined into the editor settings. If the contrib `fontawesome` module is installed you can instead select **Custom** metadata, which sources categories/icons from `fontawesome.font_awesome_manager` (the way to use Font Awesome Pro or a custom Kit). Inserted icons are plain `<i>` tags carrying Font Awesome classes — style (`fa-solid`/`fas`, `fa-brands`/`fab`, …), size (`fa-xs` … `fa-10x`) and alignment (`fa-pull-left`/`fa-pull-right`) — and the plugin declares `<i>` and `<i class>` as allowed elements so restricted formats keep them through the HTML filter. Crucially the module **does not load the Font Awesome CSS on the front end**: it only supplies the picker and the markup, so the library must already be on the site (theme, CDN, or the `fontawesome` contrib module) or icons will render as blank boxes.

---

- Let editors insert a Font Awesome icon inline in body copy without touching Source view.
- Add an icon picker to the Full HTML format while keeping Basic HTML icon-free.
- Search Font Awesome by name or keyword ("cart", "phone") from inside CKEditor 5.
- Restrict a format's picker to only the Solid and Brands styles so editors cannot pick Pro-only styles.
- Pin a site's five house-style icons into a "Recommended" category at the top of the picker.
- Switch a legacy site's format to Font Awesome 5 class names (`fas`, `far`, `fab`) instead of FA6.
- Insert social-network brand icons (`fa-brands fa-x-twitter`) into a footer text field.
- Resize an inserted icon to `fa-2x`…`fa-10x` from the widget toolbar instead of editing markup.
- Float an icon left or right of a paragraph with `fa-pull-left` / `fa-pull-right`.
- Change an already-inserted icon's style from Solid to Regular without re-picking it.
- Wrap an icon inside a link so a CTA button gets a leading arrow glyph.
- Allow `<i class>` through a restricted text format's HTML filter so icons survive filtering.
- Add icons to Webform HTML markup elements via the `webform_default` text format.
- Turn off async metadata loading when debugging why the picker shows no icons.
- Keep page weight down by leaving async metadata on so the ~650 KB icon catalogue loads only when the picker opens.
- Serve Font Awesome **Pro** metadata by installing the `fontawesome` contrib module and selecting Custom metadata.
- Expose a Font Awesome Kit's custom icons (`fa-kit`) to editors on a Pro site.
- Give a per-format icon experience: brands-only in one format, full catalogue in another.
- Audit which text formats currently allow icon insertion by reading `editor.editor.*` config.
- Ship icon-picker configuration between environments as part of a config export.
- Replace hand-typed `<i class="fa...">` snippets in source editing with a guided picker.
- Add decorative icons to accordion or card headings built with paragraphs.
- Standardise icon sizing across a site by teaching editors the size dropdown rather than inline CSS.
- Detect a misconfigured site where FA6 classes are emitted but only the FA5 stylesheet is loaded.
- Provide icons to non-technical editors who have no access to Source editing.
