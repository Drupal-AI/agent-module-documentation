CKEditor5 Label Fix is a CKEditor 5 plugin that preserves `<label>` markup (and its inline children) in rich-text content that CKEditor 5 would otherwise split or strip.

---

The module solves a CKEditor 5 regression from CKEditor 4: label wrappers that span links, cite elements, and inline formatting get broken apart or discarded on edit/save. It works in three coordinated parts. A CKEditor 5 client plugin (`js/label-fix-plugin.js`) registers `label` in the editor model schema as an inline object, allows the expected inline children (`a`, `cite`, `em`, `strong`, `b`, `i`, `span`, `br`, `$text`) inside it, and wires upcast/downcast converters so labels survive editing. The `*.ckeditor5.yml` definition adds the needed tags and attributes to the text format's allowed HTML through General HTML Support and exposes a hidden faux toolbar button (`cke5_label_fix_dummy`, labeled "Label Fix Dummy Plugin") that serves purely as the on/off switch for the plugin on a given text format. A server-side text-format filter (`LabelLinkFixFilter`, id `label_link_fix_filter`) repairs already-split `label`/`a`/`cite` patterns on output via a regex reassembly. A `hook_form_alter` implementation also attaches the plugin library to any form containing a `text_format` element when CKEditor 5 is installed. There is no configuration form, no permissions, no routes, and no database schema. Enablement is entirely per text format: enable the plugin on the format's CKEditor toolbar and enable the filter under the format's filter list.

---

- Preserve `<label>` wrappers that span an `<a>` link when editing rich text in CKEditor 5.
- Keep `<label>` markup intact after upgrading a site from CKEditor 4 to CKEditor 5.
- Retain `<cite>` elements nested inside `<a>` links inside a label (e.g. legal citations).
- Maintain WCAG/accessibility-oriented label structure in body/content fields.
- Allow inline emphasis (`<em>`, `<strong>`, `<b>`) inside label markup within the editor.
- Allow `<span>` styling and `<br>` line breaks inside label markup.
- Repair content that was already mangled by CKEditor 5 before the plugin was installed, on render, via the `label_link_fix_filter` filter.
- Enable label support on a specific text format only, without affecting other formats.
- Add the required allowed-HTML tags (`label`, `a`, `cite`, `em`, `b`, `strong`, `span`, `br`) to a format automatically when the plugin is turned on.
- Support government/enterprise content with legacy semantic label markup.
- Keep licence/regulatory notice markup (labels wrapping links and citations) rendering correctly.
- Use across Drupal 10, 11, and 12 text formats that use CKEditor 5.
- Attach the fix automatically to node edit forms, block forms, and any form with a `text_format` widget.
- Provide a silent, UI-invisible fix (no visible editor button once enabled).
- Combine label preservation with core CKEditor 5 and other GHS-based plugins on the same format.
- Migrate legacy content that relied on CKEditor 4's acceptance of label-wrapped links.
- Preserve `for`, `class`, `style`, `lang`, and `title` attributes on `<label>` in the editor.
- Preserve `href`, `class`, `style`, `lang`, `name`, `id`, and `title` attributes on `<a>` in the editor.
- Serve as a reference implementation pattern for other "CKEditor 5 element fix" plugins (Sup Fix, Table Fix, Definition List Fix).
- Avoid custom code: the fix is fully configuration/plugin-driven once enabled.
