# PDF Preview generator service

Service **`pdfpreview.generator`** → `Drupal\pdfpreview\PDFPreviewGenerator`.

Constructor args (from `pdfpreview.services.yml`): `@config.factory`, `@file_system`,
`@transliteration`, `@image.toolkit.manager`, `@language_manager`.

## Public methods

| Method | Signature | Behavior |
|--------|-----------|----------|
| `getPDFPreview` | `getPDFPreview(File $file): string\|null` | Returns the preview URI, generating it if missing. If a preview exists but is older than the source file (`filemtime`), it is deleted and regenerated. Returns the destination URI on success, `null` on failure. |
| `deletePDFPreview` | `deletePDFPreview(File $file): void` | Deletes the file's preview (if present) and flushes derived image styles via `image_path_flush()`. |
| `updatePDFPreview` | `updatePDFPreview(File $file): void` | When a file's URI or size changed vs `$file->original`, deletes the *original's* preview so a fresh one is generated on next view. |

Internal helpers: `createPDFPreview()` (does the ImageMagick conversion) and `getDestinationURI()`
(computes the target path).

## Destination path (`getDestinationURI()`)

`<default_scheme>://<pdfpreview.settings:path>/<filename><ext>` where:
- `<default_scheme>` = core `system.file:default_scheme`.
- `<filename>` = `<fid>-<transliterated basename of the PDF, ".pdf" stripped>` when `filenames` is
  `human`, else `md5('pdfpreview' . <fid>)` when `machine`. Transliteration uses the current
  language via `@transliteration`.
- `<ext>` = `.png` when `type` is `png`, else `.jpg`.

## Conversion (`createPDFPreview()`)

Uses the **imagemagick** toolkit obtained from `@image.toolkit.manager` (`createInstance('imagemagick')`),
independent of the site's default toolkit. It builds the command via the toolkit argument API:

```
-background white -flatten -resize <size> -quality <quality>
```

with source format `PDF`, source frames `[0]` (first page only), and destination format `PNG`/`JPG`
per config; then calls `$toolkit->save($destination)`. The destination directory is created with
`FileSystemInterface::CREATE_DIRECTORY`. The source is the file's real local path
(`file_system::realpath($file->getFileUri())`).

## Lifecycle hooks (in `pdfpreview.module`)

- `hook_ENTITY_TYPE_update` → `pdfpreview_file_update()` calls `updatePDFPreview()`.
- `hook_ENTITY_TYPE_delete` → `pdfpreview_file_delete()` calls `deletePDFPreview()`.
- `hook_theme` registers the `pdfpreview_formatter` render element.

Previews are otherwise generated **lazily at render time** by the formatter (see
[../fields/formatter.md](../fields/formatter.md)); there is no cron job or queue.

## Example

```php
/** @var \Drupal\pdfpreview\PDFPreviewGenerator $gen */
$gen = \Drupal::service('pdfpreview.generator');
$uri = $gen->getPDFPreview($file);   // e.g. "public://pdfpreview/12-report.png" or NULL
```
