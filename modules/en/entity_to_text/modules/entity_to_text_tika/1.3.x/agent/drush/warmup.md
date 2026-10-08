<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush e2t:t:w — OCR cache warmup

Class `Drupal\entity_to_text_tika\Commands\OcrLocalFileCacheWarmup`
(`modules/entity_to_text_tika/src/Commands/OcrLocalFileCacheWarmup.php`), registered in
`drush.services.yml` (tag `drush.command`). Constructor args: `@database`, `@entity_type.manager`,
`@entity_to_text_tika.extractor.file_to_text`, `@entity_to_text_tika.storage.local_file`.

Command **`entity_to_text:tika:warmup`**, alias **`e2t:t:w`**. Generates OCR text for managed files and
stores it via `LocalFileStorage`, so future reads use the cache instead of calling Tika. Uses langcode
`eng+fra` for warmed files.

## Behaviour (from `warmup()`)

- Raises the DB `wait_timeout` to 70s (Tika client timeout is 60s) to avoid "MySQL server has gone away".
- Queries the `file` entity storage with `accessCheck(FALSE)` (CLI/admin batch), paged 100 at a time
  (`LIMIT_PAGER = 100`), with a Symfony `ProgressBar`.
- Default MIME filter: `application/pdf`, `image/jpeg`, `image/png`, `image/tiff`, `application/msword`,
  the OpenXML Word/Excel types, and `application/vnd.ms-excel`.
- For each file: if a cached OCR exists and `--force` is not set, it is skipped; otherwise it calls
  `FileToText::fromFileToText($file, 'eng+fra')` and saves the result (empty results saved only with
  `--save-empty-ocr`).

## Options

- `--fid` — warm a single file id (bypasses the MIME filter).
- `--filemime` — MIME type(s) to process (defaults above).
- `--filesize-threshold` — skip files larger than N bytes (default NULL).
- `--save-empty-ocr` — store an empty `.ocr.txt` for unprocessable files to avoid retrying (default FALSE).
- `--stop-on-failure` — stop on first error, e.g. Tika down (default FALSE).
- `--force` — rewrite existing OCR files (default FALSE).
- `--no-progress` — suppress the progress bar (default FALSE).
- `--dry-run` — iterate without processing (default FALSE).

## Examples

```bash
drush e2t:t:w                          # warm files lacking an .ocr file
drush e2t:t:w --force                  # reprocess everything
drush e2t:t:w --fid=2                  # warm only file id 2
drush e2t:t:w --filemime=application/pdf
drush e2t:t:w --filesize-threshold=1000000
```

Best run after a fresh install, after adding an OCR language, or during file migrations; it can be
resource-intensive.
