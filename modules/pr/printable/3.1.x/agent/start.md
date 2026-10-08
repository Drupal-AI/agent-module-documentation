# Printable — agent index

Generates printer-friendly (and PDF, via the `printable_pdf` submodule) versions of content
entities, with per-entity Print/PDF links. Config lives in one object, `printable.settings`.

- **All settings keys, the config route/forms, which entities are printable** →
  [configure/settings.md](configure/settings.md)
- **The two plugin types: `PrintableFormat` (print/pdf) and `PrintableLinkExtractor`
  (none/remove/extract/subscript), and how to add one** →
  [plugins/formats-and-extractors.md](plugins/formats-and-extractors.md)
- **Routes, services, the printable:// stream wrapper, the links block** →
  [api/services-and-routes.md](api/services-and-routes.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Theme hooks and print-specific template suggestions** →
  [theming/theming.md](theming/theming.md)

Key facts:
- Printable URL per entity: `/{entity_type}/{entity}/printable/{format}` — e.g.
  `/node/{nid}/printable/print` and `/node/{nid}/printable/pdf`.
- Config route `printable.configure` → `/admin/config/user-interface/printable` (+ `/print`,
  `/pdf`, `/links`, `/links/pdf` sub-forms). Config object: **`printable.settings`**.
- Default printable entity types: `node`, `comment`, `user` (`printable_entities`).
- PDF output requires the **`printable_pdf`** submodule + `pdf_api` + a toolkit; the tool is
  chosen in `printable.settings.pdf_tool`.
- Permissions: `administer printable`, `view printer friendly versions`.
