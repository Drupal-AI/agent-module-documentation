<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Copy Layout Builder section — agent index

Adds **Copy**/**Paste** links to Layout Builder sections to duplicate a whole section
(layout + settings + blocks + inline content) within or across pages. Depends on
`layout_builder`. No settings UI (`configure: null`), no config schema, no Drush, no plugins.
Its only setup is one permission.

- **The `copy paste sections` permission: what it gates and how to grant it** →
  [permissions/copy-paste.md](permissions/copy-paste.md)
- **How copy/paste works internally (pre-render links, private tempstore buffer, deep cloning
  of inline blocks & paragraphs, routes)** → [api/mechanism.md](api/mechanism.md)

Key facts:
- Enable = `drush en lb_copy_section` + grant permission **`copy paste sections`** to a role.
- Copy/paste is UI-only (Layout Builder editing); the copy buffer is the current user's
  **private tempstore** (collection `lb_copy_section`, key `copied_section`).
- Routes: `lb_copy_section.copy` and `lb_copy_section.paste` (both require the permission and
  `_layout_builder_access: view`).
