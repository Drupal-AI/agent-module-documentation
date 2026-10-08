<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Link Styles — agent index

Adds named CSS-class "styles" to CKEditor 5 links. One CKEditor 5 plugin,
`ckeditor_link_styles_linkStyles`, configured **per text format** (no global settings page,
no permissions, no Drush commands). Styles become Link **manual decorators** — checkboxes in
the Link balloon — not entries in the Styles dropdown. Requires the core Link button
(`ckeditor5_link`) on the format.

- **Configure link styles on a format** (line syntax, stored config shape, drush) → [configure/ckeditor_link_styles.md](configure/ckeditor_link_styles.md)
- **The CKEditor 5 plugin: id, element subset, decorators, how it works** → [plugins/ckeditor_link_styles.md](plugins/ckeditor_link_styles.md)
