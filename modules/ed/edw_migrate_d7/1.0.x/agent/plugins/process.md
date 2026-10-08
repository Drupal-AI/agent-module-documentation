<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Process plugins

All classes are in `src/Plugin/migrate/process/`. Reference by `id` under a migration's `process`.

## `fid_download` (`FidDownload.php`)

`FidDownload extends` core `Download`. Downloads a file from an HTTP(S) URL into the local file
system and returns the **saved file entity's ID** (not the URI). `transform()`:
- returns NULL for empty input or when `$row->isStub()`;
- optionally rewrites the source URL: `str_replace('public:/', configuration['replace_public'], …)`;
- derives a filename from `pathinfo()`, strips a leading `download.aspx?d=`, truncates the basename
  to 30 chars, re-appends the extension; destination = `configuration['destination'] . '/' . filename`;
- reuses an existing file if `getDestinationFilename()` returns falsey;
- streams the response body to the destination via Guzzle (`httpClient->get($source, guzzle_options)`
  with `guzzle_options['sink']` set to the open stream); a request exception is caught and
  **silently ignored**;
- creates a permanent `File` entity (`uid = 1`) and returns `$file->id()`.

Config keys: `destination` (dir), `replace_public` (optional), `guzzle_options` (optional Guzzle
options array, e.g. `auth`). Inherits `file_exists` handling from core `Download`.

## `paragraph_generate` (`ParagraphGenerate.php`)

`ParagraphGenerate extends ProcessPluginBase`. `transform()` creates and saves a
`Drupal\paragraphs\Entity\Paragraph` of bundle `configuration['bundle']` from the incoming array of
values, and returns `['target_id' => id, 'target_revision_id' => revisionId]` for a paragraph
reference field. Typically fed by a preceding `sub_process`. **Requires the `paragraphs` module**
(not a declared dependency).

## `deepest_value` (`DeepestValue.php`)

`DeepestValue extends ProcessPluginBase`. `transform()` loops `while (is_array($value)) $value =
reset($value);` — returns the first scalar at the deepest level of an arbitrarily nested array.
Useful when nesting depth varies per row. No configuration.

## `strip_inline_styles` (`StripInlineStyles.php`)

`StripInlineStyles extends ProcessPluginBase`. `transform()` removes inline CSS from markup:
- with no `styles` config: a single regex strips whole `style="…"` / `style='…'` attributes;
- with a `styles` array (or scalar): runs `preg_replace` per named property to drop that declaration.

Config key: `styles` (optional array of CSS property names). Operates on migration source markup.
