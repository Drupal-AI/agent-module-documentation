# Entity PDF — routes, service, action, hooks

## Routes (entity_pdf.routing.yml)
- `entity_pdf.node` — `GET /node/pdf/{entity}/{view_mode}`, `{entity}` bound as `entity:node`.
  Controller `PdfEntityController::view`. Requirement: `_permission: 'view entity pdf'`.
- `entity_pdf.view` — `GET /entity_pdf/{entity_type}/{entity}/{view_mode}`, `{entity}` bound as
  `entity:{entity_type}`. Same controller. `_custom_access: PdfEntityController::access`.
- `entity_pdf.settings` — the admin form (see configure doc).

`view_mode` defaults to `full`. README example: `/entity_pdf/node/5/pdf`.

## Controller (`PdfEntityController`)
- `view(EntityInterface $entity, Request $request, $view_mode, $langcode)`:
  `getFilename()` → `renderEntity()` → `generatePdf()`, then returns a `CacheableResponse` with
  `Content-Type: application/pdf` and `Content-disposition: inline|attachment; filename="…"`.
  Disposition is `inline` when `openInBrowser` OR `?inline=1`, else `attachment`.
- `access($account, $entity, $view_mode)`: `AccessResult::allowedIf($account->hasPermission('view
  entity pdf') || $account->hasPermission('view '.$type.'.'.$bundle.'.'.$view_mode.' pdf'))`.

## Service `entity_pdf.generator` (`EntityPdfGenerator`)
Args: `@config.factory @plugin.manager.entity_pdf_rendering_engine @file.repository
@module_handler @entity_type.manager @renderer @token`. Public methods:
- `getFilename($entity, $langcode, $bubbleable): string` — token-replaces the `filename` config;
  invokes `hook_entity_pdf_filename_alter($filename, $entity, $langcode)`.
- `getTempDir(): string` — `DRUPAL_ROOT . '/' . tempDir`.
- `renderEntity($entity, $view_mode, $langcode, $bubbleable): string` — builds the entity view,
  wraps it in `#theme => 'htmlpdf'` (`title`, `content`, `base_url`, `langcode`), renders to HTML
  inside a `RenderContext`, bubbling cacheability.
- `generatePdf($html, $entity, $filename, $langcode, $bubbleable): string` — delegates to the
  active engine's `generatePdf()`.
- `streamPdf(array $entities, $view_mode, $langcode): void` — concatenates multiple entities into
  one paged PDF and streams it (used by the bulk action).
- `getRenderingEngine()` / `getRenderingEngines()` — resolve engine plugins.

## Bulk action (`Plugin/Action/EntityPdfDownload`, id `entity_pdf_download_action`, type `node`)
Configurable `view_mode` (`full`/`pdf`). `executeMultiple()` sends a `StreamedResponse` calling
`generator->streamPdf()`. Its `access()` mirrors the controller: `view entity pdf` OR
`view node.<bundle>.<view_mode> pdf` — again no entity `view` check. Use via Views "Bulk
operations" on nodes.

## Display Suite field
`Plugin/DsField/Node/NodePDFLink` — outputs a link to the node's PDF on selected view modes
(nodes only), when Display Suite is installed.

## Hooks the module invites
- `hook_mpdf_config_alter(array &$mpdf_config)` — modify the mPDF config array (fonts, margins,
  page size, tempDir, `autoScriptToLang`/`autoLangToFont`) before the `Mpdf` object is built.
- `hook_entity_pdf_filename_alter(&$filename, $entity, $langcode)` — change the output filename.
