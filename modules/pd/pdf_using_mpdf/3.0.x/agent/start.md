# PDF using mPDF — agent index

HTML-to-PDF for nodes and arbitrary HTML using the bundled `mpdf/mpdf` library. Adds a
`node/{node}/pdf` route (a "Generate PDF" node tab), a global settings form at
`admin/config/user-interface/mpdf` (`configure: pdf_using_mpdf.admin_form`), and a
`pdf_using_mpdf.conversion` service. Depends on core `file`. No Drush, no plugin types.

- **All global settings keys, output modes, watermark/password/template/CSS, tokens** →
  [configure/settings.md](configure/settings.md)
- **The `pdf_using_mpdf.conversion` service — `convert($html,$settings,$context)`** →
  [api/service.md](api/service.md)
- **Alter hooks `hook_mpdf_html_alter()` / `hook_mpdf_settings_alter()`** →
  [hooks/hooks.md](hooks/hooks.md)
- **Permissions: `administer mpdf settings` + dynamic `generate <type> pdf`** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `pdf_using_mpdf.settings` (single nested `pdf_using_mpdf` key). Schema
  `pdf_using_mpdf.settings`.
- The node route renders the node in the configured view mode, runs `hook_mpdf_settings_alter`
  then `hook_mpdf_html_alter`, then streams/saves via `ConvertToPdf`.
- Output modes (`pdf_save_option`): `0` browser inline, `1` download dialog, `2` save to a file
  scheme folder.
- `render_anonymous` (default false) renders the node as the anonymous user before conversion.
- Generation is gated by the per-type `generate <type> pdf` permission (not `restrict access`).
