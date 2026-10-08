<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Font Awesome integrates Drupal with the Font Awesome icon set by adding an icon-picker widget and an icon formatter to ordinary plain-text (`string`) fields — no custom field type, so a text field can store an icon class like `fas fa-eye` and render it as an `<i>` icon.

---

Unlike the older `fontawesome` module, this project stores icons in plain core `string` fields and simply supplies field plugins. It provides two field **widgets** for `string` fields — `font_awesome_icon_picker_widget` ("Font Awesome icon picker", the current one, using the Furcan IconPicker JS) and `font_awesome_icon_picker` ("Font Awesome icon picker (LEGACY)", using the Farbelous fontawesome-iconpicker, default value `fas fa-eye`) — so editors pick an icon visually instead of typing class names. It provides one field **formatter**, `font_awesome_icon` (extends core `StringFormatter`), which wraps the stored class string in `<i class="…">`, optionally adding a size class (`fa-xs` … `fa-10x`) and a fixed-width class (`fa-fw`, on by default), and attaches the Font Awesome library only when the field renders. The actual Font Awesome library (JS/SVG, CDN vs local, minification) is delivered by the required `lp_fontawesome` module (built on Libraries Provider), so this module carries no bundled font. Configuration is entirely per field on the entity's *Manage form display* (choose a widget) and *Manage display* (choose the icon formatter and its size / fixed-width) — there is no global settings page.

---

- Add an icon field to a content type by creating a plain text field and using the icon picker widget.
- Let editors pick a Font Awesome icon visually rather than typing `fas fa-star` by hand.
- Render a stored icon class as an `<i>` element with the `font_awesome_icon` formatter.
- Show a "card icon" beside each teaser using a string field formatted as an icon.
- Scale an icon in display with size classes `fa-xs` through `fa-10x` via formatter settings.
- Keep icons visually aligned by applying the fixed-width `fa-fw` class in the formatter.
- Store an icon on a taxonomy term (e.g. category icon) using a term string field + icon widget.
- Add social-network icons to a "links" content type via icon-picker string fields.
- Combine with Menu Item Fields to attach Font Awesome icons to menu items.
- Use Link Field Display Mode Formatter to inline an icon next to a link title.
- Offload Font Awesome library management (CDN or local, minified) to lp_fontawesome / Libraries Provider.
- Load the Font Awesome assets only on pages where an icon field is actually rendered.
- Set a sensible default icon (e.g. `fas fa-eye`) on the legacy widget for new field values.
- Provide an icon field on a custom entity type without defining a new field type.
- Migrate icon data as simple strings (class names) rather than a bespoke storage format.
- Display an icon as a link to the host entity using the formatter's link-to-entity option.
- Build an icon-driven feature list where each item's icon comes from an editable string field.
- Reuse the same string field with a plain text widget in one form mode and the icon picker in another.
- Present service or product icons chosen by content authors in a consistent size across the site.
- Add a status/indicator icon field whose class is picked from the Font Awesome catalogue.
