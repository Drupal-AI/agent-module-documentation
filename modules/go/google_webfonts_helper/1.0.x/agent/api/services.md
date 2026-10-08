<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services (programmatic download / CSS generation)

All services are in `google_webfonts_helper.services.yml`. There is no drush command, so code
that needs to (re)build a font's files calls these directly.

| Service id | Class | Role |
|---|---|---|
| `google_webfonts_helper.font_manager` | `FontManager` | High-level entry point |
| `google_webfonts_helper.rest_api` | `RestApi` | HTTP client for the gwfh.mranftl.com API |
| `google_webfonts_helper.font_downloader` | `FontDownloader` | Download + unzip the font archive |
| `google_webfonts_helper.style_generator` | `StyleGenerator` | Render + write the `@font-face` CSS |
| `google_webfonts_helper.file_system_manager` | `FileSystemManager` | Paths, dir prep, file discovery |
| `cache.google_webfonts_helper` | (cache bin) | Caches API responses |

## FontManager — the entry point

```php
/** @var \Drupal\google_webfonts_helper\FontManagerInterface $fm */
$fm = \Drupal::service('google_webfonts_helper.font_manager');
$fm->prepare('body_font');        // ensure files+CSS for entity id 'body_font'
$fm->prepare('body_font', TRUE);  // force: wipe, re-download, regenerate
```

`prepare(string $id, bool $force = FALSE)`: loads the `google_webfont` entity, prepares
`<fonts_path>/<id>`, downloads only if fonts are missing (or `$force`), regenerates CSS only if
missing (or `$force`). Returns bool. Also `download(GoogleWebfontInterface)` and
`generateStyle(GoogleWebfontInterface)`.

## RestApi — the external service wrapper

Base URL constant `RestApi::BASE_URL = 'https://gwfh.mranftl.com'` (the google-webfonts-helper
service; see https://github.com/majodev/google-webfonts-helper). Standard `@http_client`
(Guzzle) — TLS verification is left at its secure default.

- `fetchFonts()` → GET `/api/fonts`, cached permanently in the `google_webfonts_helper` bin
  under `fonts`. Returns `[]` on a Guzzle error (logged as a warning).
- `fetchFont(string $font_id, array $query = [])` → GET `/api/fonts/{font_id}`, cached 1h under
  `font.{font_id}`.
- `downloadFont(string $font_id, array $query, string $download_path)` → GET
  `/api/fonts/{font_id}?download=zip&…`, streamed (`sink`) to `$download_path`.

## FileSystemManager — paths

- `getFontDirectory($id)` = `<fonts_path>/<id>` (from `google_webfonts_helper.settings`).
- `getFontStylePathname($id)` = `<fonts_path>/<id>/<id>.css`.
- `getDownloadDirectory()` = `temporary://google-webfonts-helper` (fixed).
- `validateFonts($id)` uses `symfony/finder` to collect `*.ttf|woff|woff2|svg|eot` and returns
  variant→extension→URL. `validateFontStyle($id)` checks the `.css` exists.

## StyleGenerator

`generate(GoogleWebfontInterface $font, string $mode = 'legacy')` renders the
`google_webfonts_helper_style` theme and `file_put_contents()`s the result to the font's
`.css` path. Returns FALSE if no font files are present yet.
