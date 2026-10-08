<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ai.txt — settings, generation modes, and serving

## Install / enable
`composer require drupal/aitxt` then enable `aitxt`. No dependencies beyond Drupal core `^10.1 || ^11`.
Requires **Clean URLs** (runtime requirement error otherwise) and that no literal `ai.txt` file exists in
the Drupal webroot — a real file on disk is served by the webserver instead of the module's `/ai.txt`
route (runtime requirement warning). See README for `.htaccess` / Fast-404 `exclude_paths` workarounds.

On install (`aitxt_install()`) the config value `aitxt.settings:content` is seeded from the first readable
of: `sites/default/default.ai.txt`, then the module's bundled `ai.txt`, else empty string.

## Configuration UI
Route `aitxt.admin_settings_form` → `/admin/config/search/aitxt`, permission **`administer aitxt`**.
Form class `\Drupal\aitxt\Form\AiTxtAdminSettingsForm` (extends `ConfigFormBase`, form id
`aitxt_admin_settings`, editable config `aitxt.settings`). Standard config-form CSRF token applies.

## Config object `aitxt.settings` (schema in `config/schema/aitxt.schema.yml`)
| key | type | meaning |
|-----|------|---------|
| `content` | string | The literal text served at `/ai.txt`. |
| `manual` | boolean | `true` = use `content` verbatim; `false` = regenerate `content` from the toggles below. |
| `allow_text`, `allow_images`, `allow_audio`, `allow_video`, `allow_code` | boolean | Per media-type allow toggles used when `manual` is false. |

## Two modes (`AiTxtAdminSettingsForm::submitForm`)
- **Manual** (`manual` checked): the `content` textarea is saved as-is. CRLF is normalized to `\n`;
  lines are trimmed and empty lines dropped.
- **Generate** (`manual` unchecked): builds `content` from the five allow toggles. Starts with
  `User-Agent: *`, then emits `Allow: <glob>` for each extension in the allowed categories and
  `Disallow: <glob>` for the rest, drawing the globs from the `\Drupal\aitxt\Extensions` constants
  (`TEXT`, `IMAGES`, `AUDIO`, `VIDEO`, `CODE` — e.g. `*.pdf`, `*.png`, `*.mp3`, `*.mp4`, `*.php`).
  A final catch-all line is appended: `Allow: /` or `Disallow: /`.

Note: the generated file is written into `content` at save time, so switching to Manual afterwards lets
you hand-edit the last generated result.

## Serving `/ai.txt`
Route `aitxt.content`, path `/ai.txt`, `_access: TRUE` (intentionally public), `_disable_route_normalizer: TRUE`.
`AiTxtController::content()` reads `aitxt.settings:content`, merges any lines returned by
`hook_aitxt()` implementations (`module_handler->invokeAll('aitxt')`), trims/filters, joins with `\n`, and
returns them through an `HtmlResponse` built from a `['#plain_text' => $content]` render array with
`content-type: text/plain`.

## Caching
The served response carries cache tag **`aitxt`** and cache context `url.site`. Saving the settings form
calls `Cache::invalidateTags(['aitxt'])`, so edits take effect immediately. A `hook_aitxt()` provider that
changes its output should invalidate the `aitxt` tag itself.
