# Entity PDF — agent index

Renders any content entity in any view mode to a PDF (mPDF 8 by default) via a URL or a bulk
Views action. Markup is driven by an overridable `htmlpdf.html.twig`. Depends on core `node`;
requires the `mpdf/mpdf` library (install with Composer). Provides a rendering-engine plugin type,
a config schema, permissions, a Views/VBO action, and a Display Suite field.

- **Settings form, config keys (filename token, tempDir, custom template, engine, options)** →
  [configure/settings.md](configure/settings.md)
- **Routes, the `entity_pdf.generator` service, controller, VBO action, filename/mpdf hooks** →
  [api/routes-and-service.md](api/routes-and-service.md)
- **The `EntityPdfRenderingEngine` plugin type and how to add an engine** →
  [plugins/rendering-engine.md](plugins/rendering-engine.md)
- **Permissions and the access model** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Routes: `entity_pdf.node` `/node/pdf/{entity}/{view_mode}` (perm `view entity pdf`);
  `entity_pdf.view` `/entity_pdf/{entity_type}/{entity}/{view_mode}` (custom access);
  `entity_pdf.settings` `/admin/config/system/entity_pdf` (perm `administer entity pdf settings`).
- Config `entity_pdf.settings`: `filename`, `tempDir`, `customPdfTemplatePath`, `openInBrowser`,
  `renderingEngine`, `renderingEngineOptions`.
- Plugin type id `entity_pdf_rendering_engine` (manager `plugin.manager.entity_pdf_rendering_engine`).
- Hooks: `hook_mpdf_config_alter()`, `hook_entity_pdf_filename_alter()`.
