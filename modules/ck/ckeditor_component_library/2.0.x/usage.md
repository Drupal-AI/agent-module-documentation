<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Component Library lets content editors embed Component Library (UI Patterns) pattern variants directly inside CKEditor 5 rich-text content.

---

It builds on the `component_library` and `embedded_content` (ckeditor5 embedded content) modules. An administrator visits `/admin/structure/component-library/ckeditor-embeds` to choose which patterns are embeddable and to shape the embed form that editors see: for each pattern property a Form API element is generated (a textfield by default), and an `Embed Config Form Settings` JSON field overrides those elements — e.g. `{"url": {"#type": "url"}}` to use a URL widget, or `{"html_tag": {"#type": "value"}}` to lock a property so editors cannot change it. At render time a `ckeditor_component_library_embed` theme hook (declared in `hook_theme`) outputs the selected pattern variant with the editor-supplied property values.

The module's only route is the admin configuration form, protected by the compound permission `administer component library patterns` + `use ckeditor5 embedded content`. There are no anonymous or mutating endpoints. Setup requires enabling the Embedded Content filter/button on a CKEditor 5 text format, then configuring which patterns are exposed. Note the usual embedded-content caveat: editors choose pattern variants and fill their properties, so the security of rendered output depends on the underlying pattern templates and the text-format filter configuration.

---

- Embed Component Library pattern variants inside CKEditor 5.
- Choose which patterns are available for embedding.
- Insert a pattern/variant via the CKEditor Embedded Content button.
- Expose each pattern property as an editable embed-form field.
- Override an embed field's widget with Form API JSON settings.
- Use a URL widget for a link property (`{"#type":"url"}`).
- Lock a property to a fixed value with `{"#type":"value"}`.
- Hide a property from editors with `{"#access":false}`.
- Prevent editors from breaking markup by locking an `html_tag` property.
- Configure embeds at `/admin/structure/component-library/ckeditor-embeds`.
- Enable the Embedded Content button/filter on a CKEditor 5 text format.
- Reuse design-system components inside body content.
- Keep rich-text output consistent with the component library.
- Render embedded patterns via the `ckeditor_component_library_embed` theme hook.
- Gate configuration behind the component-library + embedded-content permissions.
- Provide editors a curated palette of embeddable components.
- Combine UI Patterns variants with editorial content.