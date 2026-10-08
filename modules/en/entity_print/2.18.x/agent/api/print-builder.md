# Generate documents in code

Service `entity_print.print_builder` (`Drupal\entity_print\PrintBuilderInterface`). Get an
engine instance from `plugin.manager.entity_print.print_engine`.

```php
$builder = \Drupal::service('entity_print.print_builder');
$engine  = \Drupal::service('plugin.manager.entity_print.print_engine')
  ->createSelectedInstance('pdf');   // uses the configured engine for the 'pdf' export type

// 1. Stream to the browser (optionally forcing download).
$builder->deliverPrintable([$entity], $engine, $force_download = TRUE, $use_default_css = TRUE);

// 2. Get the rendered HTML only (what the engine would consume).
$html = $builder->printHtml($entity, $use_default_css = TRUE, $optimize_css = TRUE);

// 3. Render and save to disk — returns a URI like public://file.pdf (FALSE on failure).
$uri = $builder->savePrintable([$entity], $engine, 'private', 'invoice-123.pdf');
```

- All three accept an **array** of entities → multiple entities become multiple pages in one
  document.
- `savePrintable()` defaults to the `public://` scheme; pass `'private'` (and your own filename)
  to keep generated files out of the web root.
- Low-level engine API (`PrintEngineInterface`): `addPage($html)`, `send($filename, $force)`,
  `getBlob()` (raw bytes, e.g. to attach to an email), `getPrintObject()` (the underlying
  Dompdf/TCPDF object).
- Filenames are produced by `entity_print.filename_generator` (transliterated); alter via the
  filename event → [../extend/events.md](../extend/events.md).
- A `PrintEngineException` is thrown when generation fails.
