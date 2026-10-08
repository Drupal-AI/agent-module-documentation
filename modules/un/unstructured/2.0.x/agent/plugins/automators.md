<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Automator plugins (FileTo…)

Four plugins in `src/Plugin/AiAutomatorType/`, declared with the `#[AiAutomatorType]` attribute
and extending `ai_automators`' `ExternalBase`. They load only when the **`ai_automators`** module
(from `drupal/ai`) is enabled (a test-dependency of this module). Each takes a **file** input
(`allowedInputs() => ['file']`), calls `unstructured.api`, and writes another field.

| Plugin id | Class | `field_rule` | Writes |
|-----------|-------|--------------|--------|
| `unstructured_io_text_long` | `FileToText` | `text_long` | formatted text + a text `format` |
| `unstructured_io_string_long` | `FileToString` | `string_long` | formatted text (plain value) |
| `unstructured_io_tablefield` | `FileToTable` | `tablefield` | a `tablefield` structure |
| `unstructured_io_images` | `FileToImage` | `image` (`target: file`) | image field items |

`FileToText` and `FileToString` share `FileToTextBase`; `FileToImage` and `FileToTable` are
standalone. All set `needsPrompt() = FALSE`, `advancedMode() = FALSE`.

## FileToTextBase (text & string)

`extraAdvancedFormFields()` adds automator settings:

- `automator_unstructured_elements` — checkboxes of element types to keep (empty = all).
- `automator_unstructured_output_format` — `text` | `markdown` | `html` → selects the matching
  formatter service.
- `automator_unstructured_split` — `none` | `page` | `element` (passed to the formatter).
- `automator_unstructured_strategy` — `auto` | `fast` | `hi_res` | `ocr_only`.
- `automator_unstructured_hires_model` — `default` | `detectron2_onnx` | `yolox` |
  `yolox_quantized` | `chipper` (visible only when strategy = `hi_res`).
- `automator_unstructured_images` — extract images (default TRUE) → adds
  `extract_image_block_types => ['Image','Table']`.
- `automator_unstructured_bypass_unstructured` — default TRUE; if the uploaded file's MIME already
  matches the requested output (`text/plain`→text, `text/markdown`→markdown, `text/html`→html) the
  file contents are used directly and **no API call** is made.

`generate()` iterates the base file field, builds the `$extract` options (strategy, hi_res model,
image block types), calls `unstructuredApi->structure($fileEntity, $extract)`, picks the formatter
by output format, and merges `format($response, $split)` into the values. `verifyValue()` requires a
string. `FileToText::storeValues()` wraps each value as `['value' => …, 'format' => …]` where the
format comes from the field's `allowed_formats[0]` (or the first available `filter_format`).

## FileToTable

`generate()` forces `extract_image_block_types => ['Table']`, then for each result with
`metadata.text_as_html` builds a `tablefield` array via `getTableField()` (splits the HTML on
`</tr>`/`</td>`/`</th>`, `strip_tags`+`trim` per cell, returns `caption`/`rebuild`/`value`).
Settings: strategy + hi_res model only.

## FileToImage

Injects `file_system`, `file.repository`, `token`. `generate()` resolves the target image field's
destination directory from its `uri_scheme` + `file_directory` (token-replaced), forces
`extract_image_block_types => ['Image']`, and for each `type: Image` result base64-decodes
`metadata.image_base64` into a **permanent** managed file (`generateImageFile()`), returning
`target_id`/`alt`/`title` items. Setting: strategy only.

## Operating notes

These run inside the AI Automator pipeline on entity save/processing; access is governed by the
host entity/field and the `ai_automators` configuration, not by any route this module adds. The API
timeout is 600s per call, so hi-res parsing of large PDFs is expected to be slow.
