# Services / API

## `Drupal\pdfa11y\Pdfa11yAnalyzer` (service id = FQCN)

Orchestrates checks and persists results to `pdfa11y_results`.

| Method | Purpose |
|---|---|
| `analyze(int $fid, string $uri, ?int $mid = NULL): AccessibilityCheckResult[]` | Parse the file and run every enabled check. On parse failure returns a single sentinel result (`_missing_file` / `_io_error` / `_encrypted_pdf` / `_parse_error`). Does **not** write. |
| `analyzeIsolated(int $fid, string $uri, ?int $mid, bool $useFork = TRUE)` | `analyze()` + `storeResults()` inside a forked child (`pcntl_fork`) so an OOM fatal ends only the child (records `_subprocess_failed`). Falls back to in-process when pcntl is absent or `$useFork` is false. |
| `storeResults(int $fid, ?int $mid, array $results): void` | Replace all rows for `$fid` (transactional delete + insert). Drops `not_applicable` results. |
| `getResults(int $fid): AccessibilityCheckResult[]` | Read stored rows keyed by `check_id`. |
| `tooLargeResult()` / `imagePayloadTooLargeResult()` / `subprocessFailedResult()` | Build the corresponding sentinel result arrays (used by the command/queue guards). |

```php
$analyzer = \Drupal::service(\Drupal\pdfa11y\Pdfa11yAnalyzer::class);
$results  = $analyzer->analyze((int) $file->id(), $file->getFileUri(), (int) $media->id());
$analyzer->storeResults((int) $file->id(), (int) $media->id(), $results);
$failed = array_filter($results, fn($r) => !$r->passed());
```

## `Drupal\pdfa11y\PdfParserService`

Wraps `smalot/pdfparser`. **Parsing is local and in-process — no CLI tool, no network call.**

- `parse(string $uri): ?Smalot\PdfParser\Document` — `file_exists()` pre-check, then
  `file_get_contents($uri)` under a 30s `default_socket_timeout`, then `Parser::parseContent()`
  under a 60s `pcntl_alarm` wall-clock guard (no-op without pcntl). Returns NULL on failure.
- `getLastFailureKind(): string` — classifies the last NULL as `missing` / `transient` /
  `permanent` / `encrypted` (constants `FAILURE_*`), so callers route to the right sentinel.
- `getPdfVersion(string $uri): ?string` — reads the `%PDF-x.y` header (first 20 bytes).
- `getRawBytes(string $uri): ?string` / `clearRawBytes()` — cache of the last file's bytes for
  plugins that scan raw bytes.

## `Drupal\pdfa11y\PdfPreflightService`

`getImageStreamBytes(string $uri): ?int` — estimates a PDF's decompressed image payload **without
decompressing images**: walks the cross-reference table with bounded `fseek`/`fread` windows,
reads each image object's dict, and multiplies `/Length` by a per-filter factor (DCTDecode/JPXDecode
×10, CCITTFax/Flate ×8, JBIG2 ×5, …). Returns NULL when the file can't be safely pre-flighted
(encrypted, malformed xref) — the caller then falls through to a normal parse. Used to route
image-heavy files to `_image_payload_too_large` before smalot risks an out-of-memory fatal.

## `AccessibilityCheckResult` (value object)

Readonly: `checkId`, `status` (`pass`/`fail`/`error`/`not_applicable`), `message`, `severity`
(`info`/`warning`/`error`), `fid`, `mid`, `uri`. `passed()` returns true for pass or not_applicable.
`withContext(fid, mid, uri)` returns a copy with file context. Static `getStatusOptions()` /
`getSeverityOptions()` back the Views filters.
