# Flipbook — agent index

Renders an uploaded PDF as an interactive page-flip "book" using bundled JS (pdf.js, three.js,
`3dflipbook.min.js`). Defines a custom `flipbook` content entity (name + cover image + PDF file),
a one-toggle settings form, five permissions, and Views field templates. Depends on core
`options`, `file`, `image`. Config UI route `flipbook.chooseform` (`/admin/config/choosepdfstyle`).
All viewer assets ship in-module — no CDN, no external library.

- **The `flipbook` entity (base fields, routes, listing) and the one settings toggle
  (popup vs inline)** → [configure/entity.md](configure/entity.md)
- **The five permissions, the access handler, and a permissions.yml typo gotcha** →
  [permissions/permissions.md](permissions/permissions.md)
- **Rendering: templates, asset libraries, `drupalSettings`, preprocess, Views field integration** →
  [theming/render.md](theming/render.md)

Key facts:
- Entity type `flipbook`, base table `flipbook`, admin route `flipbook.settings`,
  canonical `/flipbook/{flipbook}`, collection `/admin/structure/flipbook/list`.
- Required fields: `flipbook_cover` (image, png/jpg) and `flipbook` (file, `.pdf` only).
- Settings: `config.flipbook_chooseconfig` key `pdf.choice` (0 = inline library
  `flipbook/flipbook_nopopup`, 1 = popup library `flipbook/flipbook`).
- `hook_entity_predelete` deletes the cover + PDF files when a flipbook is deleted.
