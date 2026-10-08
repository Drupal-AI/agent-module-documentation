<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The generator service, route & cron

## Service `llms_txt_generator.file_generator`

Class `Drupal\llms_txt_generator\Service\LlmsFileGenerator` implements
`LlmsFileGeneratorInterface`. Constructor deps: `config.factory`, `file_system`, `logger.factory`,
`file.repository`, `module_handler`, `request_stack`. File URI is the fixed constant
`LlmsFileGenerator::LLMS_TXT_URI = 'public://llms.txt'` (never request-derived — no path traversal).

```php
$gen = \Drupal::service('llms_txt_generator.file_generator');
```

- **`generateLlmsFile($suppress_empty_warning = FALSE): bool`** — writes the config's
  `llms_txt_content` verbatim to `public://llms.txt`. Returns FALSE (and logs) if `enable_file` is
  FALSE, if content is empty/whitespace, or on a write/permission failure. It ensures `public://`
  exists (`prepareDirectory(... CREATE_DIRECTORY)`), deletes any existing file, then writes via
  `file.repository`'s `writeData(... EXISTS_REPLACE)`. **Note the interface declares this method
  with no argument** but the implementation adds the optional `$suppress_empty_warning`.
- **`getLlmsFileContent(): string|false`** — returns the file's contents; if the file is missing it
  attempts a `generateLlmsFile()` first, else returns FALSE.
- **`getDefaultTemplateContent(): string`** — reads `templates/default-template.md` and substitutes
  `{site_name}`, `{site_url}` (request scheme+host), `{date}`. Used to seed config on install and by
  the form's reset button. Purely template-driven — reads no site content.

## Route `llms_txt_generator.content` → `/llms.txt`

Controller `LlmsTextGeneratorController::content()` (`_access: 'TRUE'`, public):

1. If `enable_file === FALSE` → `Response('', 404)`.
2. Else `getLlmsFileContent()`; if FALSE, fall back to the `llms_txt_content` config value.
3. If the result is empty after `trim()` → 404.
4. Otherwise a `CacheableResponse` with `Content-Type: text/plain; charset=UTF-8`,
   `X-Robots-Tag: noindex`, `Cache-Control: public, max-age=3600`, cache tag
   `config:llms_txt_generator.settings`, cache context `url.site`.

So the served body is the physical file when present, otherwise the raw config text — both are the
same admin-authored string. (Observed live: `HTTP/2 200`, `text/plain`, `x-robots-tag: noindex`.)

## Lifecycle hooks (`.module` / `.install`)

- **`hook_install`** — seeds `llms_txt_content` from the template (only if empty), sets
  `enable_file = TRUE`, then writes the file (`generateLlmsFile(TRUE)`, warning suppressed).
- **`hook_uninstall`** — deletes `public://llms.txt` if present and deletes the config object.
- **`hook_cron`** — a **self-heal only**: if `public://llms.txt` already exists it does nothing;
  if it is missing and `enable_file` is TRUE it regenerates it and logs a notice. Cron never
  refreshes an existing file from changed config — edits reach the file only through the form submit
  or an explicit `generateLlmsFile()` call.
