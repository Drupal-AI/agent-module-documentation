<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# InbuiltImageGenerator service

`image_creating_engine.services.yml` registers two ids, **both** pointing at
`Drupal\image_creating_engine\Service\InbuiltImageGenerator`:

- `image_creating_engine.generator`
- `image_creating_engine.wkhtml_generator`

Constructor args: `file_system`, `entity_type.manager`, `logger.factory`, `config.factory`,
`renderer`, `tempstore.private`, `file_url_generator`.

## `generateImage($html, $css, array $options = [])`

1. `checkDependencies()` — locate `wkhtmltoimage` (`findWkhtmlPath()` checks
   `/usr/bin`, `/usr/local/bin`, `/opt/bin`, `/bin`, then `which`) and run `--version`; returns
   NULL if missing/unusable.
2. Options: `width` (default 0), `height` (default 0), `format` (`png`/`jpg`/`jpeg`, else `png`),
   `quality` (default 94).
3. Output to `public://dynamic_image_generator/generated/image_<uniqid>.<fmt>`.
4. `generateImageWithWkhtml()`:
   - `buildCompleteHtml()` wraps the HTML/CSS in a full `<html>` doc.
   - writes it to `tempnam(sys_get_temp_dir(),'wkhtml_').'.html'`.
   - builds the command: `escapeshellarg($wkhtml_path)` `--width N --height N --format png|jpg`
     [`--quality N`] `--log-level error` `escapeshellarg($temp_html)` `escapeshellarg($output_path)`
     `2>&1`, and runs it with `shell_exec()`.
   - success = output file exists and non-empty; temp HTML is unlinked.
5. On success creates a permanent managed `File` and returns
   `['uri','file','url','width','height','format','generator'=>'wkhtmltoimage','success'=>TRUE]`.

The parent module consumes the returned `file` directly (no re-download) when building the
`dynamic_image` media entity.

## Notes

- All variable command arguments (binary path, temp-HTML path, output path) go through
  `escapeshellarg()`, and the HTML/CSS payload travels via a temp file rather than argv.
- The bundled `WkhtmlImageGenerator` class is an alternate implementation with extra flags
  (`--enable-local-file-access`, `--disable-javascript`, ...) and a `testInstallation()` method
  used by the parent's `/admin/config/content/dynamic-image-generator/test-wkhtml` diagnostic; it
  is not the class instantiated by either registered service id in 1.1.2.
- No config, routes or permissions are defined by this submodule; behaviour is driven entirely by
  the parent module's `api_provider = inbuilt` setting and per-call `$options`.
