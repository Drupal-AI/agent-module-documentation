<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Standalone Styles lets the CKEditor 5 "Styles" dropdown be configured separately from the editor and text-format configuration form.

---

CKEditor Standalone Styles moves management of the CKEditor "Styles" dropdown out of the text-format /
editor configuration form and into a dedicated admin page. Each style is stored as a `ckeditor_style`
configuration entity — a label, one HTML element (e.g. `p`, `h2`, `span`), and one or more CSS classes —
managed with add/edit/delete/reorder forms at **Configuration → Content authoring → CKEditor styles**
(`/admin/config/content/ckeditor_style`). Because they are config entities, a theme or module can also ship
default styles.

The point is least privilege: the full text-format/editor form is powerful and security-sensitive (it
governs allowed HTML, an XSS-relevant setting), so being able to grant a role the single
`administer ckeditor standalone styles` permission lets a content lead curate the Styles dropdown while the
allowed-HTML and filter settings stay restricted to administrators. The module's sole dependency is core's
CKEditor 5 module; it adds no JavaScript libraries and makes no external requests.

It also does something core does not: when it builds the dropdown it automatically registers each style's
CSS classes with the format's allowed-HTML filter — but only for HTML elements the filter already allows —
so the classes are not stripped on save or render and the styles actually stick. In a CKEditor 5 format you
still add the Style button to the toolbar yourself; any styles configured in that format's own plugin
settings are then ignored, because the list comes entirely from the standalone entities. Styles are also
limited to elements the editor's filter format permits, so the dropdown never offers a style that could not
be applied.

---

- Manage the CKEditor Styles dropdown from a dedicated admin page instead of the editor config form.
- Store each style as a `ckeditor_style` config entity (label, element, CSS classes, weight).
- Add, edit, delete and drag-reorder styles at `/admin/config/content/ckeditor_style`.
- Ship default styles from a theme or module as config.
- Delegate styles management via the single `administer ckeditor standalone styles` permission.
- Keep the security-sensitive allowed-HTML / filter config restricted to administrators (least privilege).
- Auto-register a style's CSS classes with the format's allowed-HTML filter so they survive filtering.
- Add classes only to elements the filter already allows — never widen the allowed element set.
- Offer only styles whose element the editor's filter format permits.
- Override core's CKEditor 5 Style plugin and `filter_html` filter to source the list from these entities.
