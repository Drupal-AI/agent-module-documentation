<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — files_url_replacer

## Route & permission
- Form: `/admin/config/files_url_replacer` (`FilesUrlReplacerSettingsForm`).
- Permission: `administer files_url_replacer settings` (restricted).

## Settings (config `files_url_replacer.settings`)
| Key | Type | Meaning |
| --- | --- | --- |
| `active` | bool | Master on/off switch for URL replacement. |
| `url` | string | External base URL to serve public files from (validated valid + external). |
| `check` | bool | If TRUE, only replace when the file does **not** exist locally. |

## Behaviour
- Only `public://` scheme files are rewritten; `.css` and `.js` are excluded.
- `generateString()` rewrites relative URLs; `generateAbsoluteString()` rewrites absolute ones.
- With `check` on, `checkIfExists()` returns FALSE (skip rewrite) when the local file exists; for `public://styles/...` it strips the style/scheme/derivative path segments and re-checks the source file.
- Saving calls `$kernel->invalidateContainer()` so the `file_url_generator` swap is rebuilt.

## Operational notes
- Intended for dev/test environments cloned from production without the files directory.
- The target `url` must be a valid **external** URL or the form rejects it.
- Multilingual: a configured `language.negotiation` URL prefix is stripped from the base URL before replacement.
