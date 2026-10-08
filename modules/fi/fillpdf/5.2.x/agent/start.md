# FillPDF — agent index

Fills uploaded PDF templates (AcroForms) with Drupal entity data, then downloads/saves/redirects to the
result. Filling is delegated to a pluggable **PdfBackend** (FillPDF Service, LocalServer, or pdftk).
Requires core `file`, `options`, `serialization`, `views` + contrib `token`. Global config
`fillpdf.settings` (`configure` = `fillpdf.settings`, `/admin/config/media/fillpdf`); forms managed at
`/admin/structure/fillpdf`.

- **Global settings: backend choice, endpoints/API key, storage schemes, pdftk path/locale** →
  [configure/settings.md](configure/settings.md)
- **FillPdfForm & FillPdfFormField entities: template upload, field mapping, filename, scheme, encryption** →
  [configure/forms.md](configure/forms.md)
- **Generating a PDF: the `/fillpdf` URL params, link manipulator, access rules, services to call** →
  [api/generate.md](api/generate.md)
- **Plugin types you can add: PdfBackend and FillPdfActionPlugin** →
  [plugins/backends-and-actions.md](plugins/backends-and-actions.md)
- **Hooks: pre-form-build alter and populate-context alter** → [hooks/hooks.md](hooks/hooks.md)
- **Permissions: administer pdfs / publish own pdfs / publish all pdfs** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Entities: `fillpdf_form` (template + settings; base fields incl. `file`, `title` filename pattern,
  `scheme`, `pdftk_encryption`, `permissions`, `owner_password`, `user_password`) and `fillpdf_form_field`
  (per-PDF-field mapping). Managed via `InputHelper` (parse on upload) / `OutputHandler` (save).
- Generate route: `fillpdf.populate_pdf` at `/fillpdf`, custom access `FillPdfAccessController::checkLink`.
  Query: `fid` (required), `entity_id`/`entity_ids` (`type:id`), `entity_type`, `download`, `flatten`
  (default true), `sample`.
- Backends (`@PdfBackend`): `fillpdf_service` (XML-RPC remote), `local_server` (HTTP JSON, self-hosted),
  `pdftk` (local `exec`/`passthru`, XFDF). Actions (`@FillPdfActionPlugin`): `download`, `save`, `redirect`.
- Defaults (`config/install`): `allowed_schemes: [private]`, `template_scheme: ''` (site default),
  `remote_protocol: https`, `shell_locale: en_US.UTF-8`. No hardcoded secrets/keys.
- Template uploads are restricted to `.pdf` (widget `FileExtension` validators + `file` base field
  `file_extensions: pdf`) and gated by `administer pdfs`.
