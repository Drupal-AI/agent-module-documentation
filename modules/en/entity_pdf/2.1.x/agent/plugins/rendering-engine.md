# Entity PDF — rendering engine plugin type

Entity PDF abstracts the HTML→PDF back-end behind a plugin type so you can swap or add engines.

## The plugin type
- Plugin id: `entity_pdf_rendering_engine`.
- Manager service: `plugin.manager.entity_pdf_rendering_engine`
  (`EntityPdfRenderingEngineManager`, a `default_plugin_manager`).
- Annotation: `@EntityPdfRenderingEngine(id = "...", label = @Translation("..."))`
  (`src/Annotation/EntityPdfRenderingEngine.php`).
- Interface: `EntityPdfRenderingEngineInterface`; base class `EntityPdfRenderingEngineBase`.
- Discovery dir: `src/Plugin/EntityPdfRenderingEngine/`.
- Bundled engine: `RenderingEngineMpdf` (id `entity_pdf_engine_mpdf`, label "MPdf 8") wrapping
  `Mpdf\Mpdf`.

## Interface methods to implement
- `generatePdf(string $output, ?EntityInterface $entity, ?string $filename, ?string $langcode,
  ?BubbleableMetadata $bubbleable): string` — turn HTML into PDF bytes (string).
- `streamPdf(?string $filename): void` — stream the accumulated PDF to the client (downloads).
- `addContent(string $content): void` and `addPage(): void` — append HTML / start a new page
  (used to build multi-entity paged PDFs in `EntityPdfGenerator::streamPdf`).
- `getConfigurableOptions()`, `getRenderingOptions()`, `overrideSettingsForm()`,
  `overrideSettingsFormSubmit()` — expose engine-specific settings on the admin form; values are
  stored under `entity_pdf.settings:renderingEngineOptions.<plugin_id>`.
- `getName()`, `getPluginId()`, `getPrintObject()`.

## How mPDF is built (reference)
`RenderingEngineMpdf::__construct` assembles `$mpdf_config` (`tempDir` from
`generator->getTempDir()`, default font dirs/data, `autoScriptToLang`/`autoLangToFont`), fires
`hook_mpdf_config_alter($mpdf_config)`, instantiates `new Mpdf($mpdf_config)`, and
`SetBasePath($request->getSchemeAndHttpHost())`. `generatePdf()` = `WriteHTML($output)` +
`Output($filename, Destination::STRING_RETURN)`; `streamPdf()` = `Output(..., DOWNLOAD)`.

## Add your own engine (sketch)
```php
// src/Plugin/EntityPdfRenderingEngine/MyEngine.php
#[EntityPdfRenderingEngine(id: 'my_engine', label: new TranslatableMarkup('My Engine'))]
class MyEngine extends EntityPdfRenderingEngineBase {
  public function generatePdf(string $output, ...): string { /* return PDF bytes */ }
  public function streamPdf(?string $filename = NULL): void { /* echo + exit */ }
  public function addContent(string $content): void {}
  public function addPage(): void {}
}
```
Then select it at `/admin/config/system/entity_pdf` (or set
`entity_pdf.settings:renderingEngine = my_engine`).
