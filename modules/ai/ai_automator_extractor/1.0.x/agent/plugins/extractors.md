<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The extractor automator plugins

## Install & enable

```bash
composer require drupal/ai_automator_extractor
drush en ai_automator_extractor -y
```

Only dependency is the AI module's **`ai_automators`** sub-module (composer requires `drupal/ai`
`^1.0.0-alpha8`). No routes, permissions, config schema, or Drush of its own. All seven plugins live in
`src/Plugin/AiAutomatorType/` and extend `Drupal\ai_automators\PluginBaseClasses\ExternalBase`
(`needsPrompt()` = `advancedMode()` = FALSE). **No AI provider is called** — extraction is pure PHP/regex.

## How to configure (any plugin)

On the target field's AI Automator settings: pick the extractor whose `field_rule` matches the target
field type, set the **source** field (`base_field`) to the field you extract from, and fill any extra
options. Extraction runs on entity save; `verifyValue()` filters results before they are stored.

## The plugins

### Link — `LinkExtractor` (`field_rule: link`)

`generate()` runs
`preg_match_all('/(http|ftp|https):\/\/…/i', $wrapperEntity->value, $matches)` over each source item,
then drops any URL whose extension is in the **Disallowed Extensions** textfield
(`automator_extractor_disallow_extensions`, default `css js jpg jpeg gif tiff png pdf txt mp3 mp4 mov svg`).
`verifyValue()` requires `FILTER_VALIDATE_URL`. `storeValues()` writes each surviving URL as a link item
(clearing `title` when the link field's `title` setting is 0).

### Email — `EmailExtractor` (`field_rule: email`)

`generate()` runs `preg_match_all('/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)/i', …)` and
de-duplicates. `verifyValue()` requires `FILTER_VALIDATE_EMAIL`. `storeValues()` sets the matches on the
target e-mail field.

### Image — `ImageExtractor` (`field_rule: image`, target `file`)

`generate()` regex-matches image URLs (`…(gif|jpg|jpeg|png)`) in the source text. Extra fields
`automator_extractor_offset` and `automator_extractor_amount` (numbers) bound how many are kept.
`verifyValue()` requires a valid URL ending in one of the image field's allowed `file_extensions`.
`storeValues()` **downloads each URL server-side**: `getimagesize($value)` (checked against the field's
`min_resolution`/`max_resolution` via `fitsResolution()`), then
`getFileHelper()->generateImageMetaDataFromBinary(file_get_contents($value), $filePath)`, saving image
entities up to the field cardinality (or the configured amount). Output filename is `basename($value)` via
`createFilePathFromFieldConfig()`.

### File — `FileExtractor` (`field_rule: file`, target `file`)

`generate()` regex-matches URLs ending in the file field's allowed extensions
(`$exts = str_replace(' ', '|', $config['file_extensions'])`). `verifyValue()` requires a valid URL with an
allowed extension. `storeValues()` **downloads each URL server-side** with
`getFileHelper()->generateFileFromBinary(file_get_contents($value), $filePath)` and attaches the resulting
managed files up to the field cardinality.

### RegEx Text — `TextRegExExtractor` (`field_rule: text`)

`allowedInputs()` = `text_long, text, string, string_long, text_with_summary, link`. Extra field
**Regular Expression** (`interpolator_extractor_regex`). `generate()` runs the configured regex over the
source (`htmlspecialchars_decode()`ed `->value`, or `->uri` for link fields) inside a try/catch and stores
each full match (`matches[0]`). `verifyValue()` requires a non-empty string.

### RegEx Text (string) — `StringRegExExtractor` (`field_rule: string`)

Same shape as `TextRegExExtractor` but stores the **first capture group** (`matches[1]`) instead of the
full match — use a regex with a `(…)` group to pull a sub-string into a `string` field.

### RegEx Counter — `RegExCounter` (`field_rule: integer`)

Extra field **Regular Expression** (`automator_extractor_regex`). `generate()` stores the **number of
matches** (`preg_match_all(...)` return, `0` on error) per source item. `verifyValue()` requires numeric.

## Config keys quick reference

| Plugin | Extra config key(s) |
|---|---|
| Link | `automator_extractor_disallow_extensions` |
| Image | `automator_extractor_offset`, `automator_extractor_amount` |
| File | (uses the file field's own `file_extensions`) |
| RegEx Text / RegEx String | `interpolator_extractor_regex` |
| RegEx Counter | `automator_extractor_regex` |

(At runtime the Automators framework exposes these to `generate()` as `$automatorConfig['extractor_*']` /
`$automatorConfig['extractor_regex']`.)

## Notes

- Image/File extractors resolve their target save path from `basename()` of the matched URL via
  `ExternalBase::getFileHelper()->createFilePathFromFieldConfig()` and the field's own storage config.
- The RegEx plugins swallow regex exceptions (empty `catch`), so a malformed pattern yields no
  values / a count of `0` rather than an error.
