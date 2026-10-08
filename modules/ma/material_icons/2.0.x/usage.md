Material Icons integrates Google's Material Icons and Material Symbols into Drupal, both as a dedicated field type (with an autocomplete icon picker) and as a CKEditor 5 toolbar button for inserting icons into rich text.

---

The module provides a `material_icons` field type storing three columns — `icon` (the icon name), `family` (the style, e.g. `baseline`, `outlined`, `symbols__rounded`), and optional `classes` — with a matching widget and formatter. The widget renders an autocomplete textfield (backed by the `material_icons.autocomplete` controller, which fetches icon metadata from Google's fonts API and caches it for a week) plus a style dropdown; its per-widget settings are `allow_style`, `default_style`, and `allow_classes`. The formatter themes each value through the `material_icon` template as `<i class="{family} {classes}">{icon}</i>`. Which icon font style packs are actually loaded on the page is controlled globally by `material_icons.settings` → `families` (a list; default `['baseline']`), set on the settings form at `/admin/config/content/material_icons`; every selected family is attached site-wide as an external Google Fonts stylesheet library via `hook_page_attachments()`. For rich text, a CKEditor 5 plugin (`material_icons.ckeditor5.yml`) adds a **Material Icons** toolbar button that opens the `material_icons.dialog` icon-picker modal and inserts a `<span>` with the icon classes. Two permissions gate it: `administer material icons` (the settings form) and `use material icons` (the picker dialog and autocomplete). It requires only core's `editor` module.

---

- Add an icon field to a content type so editors can attach a Material Icon to each node.
- Let editors insert Material Icons inline in the body via a CKEditor 5 toolbar button.
- Pick icons by name with an autocomplete that previews each glyph as you type.
- Offer multiple icon styles (Filled, Outlined, Rounded, Sharp, Two-Tone) per field.
- Use the newer Material Symbols families (Outlined, Rounded, Sharp) alongside classic Material Icons.
- Choose which icon style packs load site-wide from the settings page to control page weight.
- Set a default icon style on a widget so editors don't have to choose each time.
- Allow or forbid editors adding extra CSS classes (e.g. alignment) to an icon.
- Lock a field to a single style by disabling style selection on its widget.
- Render icons in views and displays through the Material Icons field formatter.
- Build an icon-driven feature list or services grid using an icon field per item.
- Add category/taxonomy-term icons that display next to term names.
- Insert status or action icons into WYSIWYG help text and callouts.
- Store multiple icons per entity with a multi-value Material Icons field.
- Provide a consistent icon vocabulary across a site by standardising on Material Symbols.
- Give menu or card components an icon field for editorial control of glyphs.
- Restrict icon insertion to trusted roles with the `use material icons` permission.
- Keep the Google Fonts icon stylesheet loading limited to only the families you enable.
- Theme icons further by targeting the `<i class="material-icons …">` output in CSS.
- Add vertical-alignment helper classes (e.g. `align-text-top`) to individual icons.
- Configure per-text-format availability by adding the toolbar button only where wanted.
- Prototype an icon picker quickly without bundling a large local icon library.
- Reuse the same field on media, taxonomy, or user entities that support fields.
- Export field and settings config to roll out the icon setup across environments.
