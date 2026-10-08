<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Automator plugins (PDF → text field)

Two [AI Automators](https://www.drupal.org/project/ai) type plugins that copy the text
of a PDF (held in a file field) into a text field on the **same entity**. They require
the `ai_automators` submodule of `drupal/ai` to be enabled.

## Install & enable

```bash
composer require drupal/ai_simple_pdf_to_text   # pulls smalot/pdfparser + drupal/ai
drush en ai_simple_pdf_to_text ai_automators -y
```

## The plugins

| Plugin id | Class | `field_rule` (target field type) |
|---|---|---|
| `simple_pdf_to_text_text_long` | `FileToText` | `text_long` |
| `simple_pdf_to_text_string_long` | `FileToString` | `string_long` |

Both are declared with the `#[AiAutomatorType(...)]` attribute, label **"Simple PDF to
Text"**, and extend `FileToTextBase` (which extends
`Drupal\ai_automators\PluginBaseClasses\ExternalBase`).

`FileToTextBase` config knobs: `needsPrompt()` = FALSE, `advancedMode()` = FALSE,
`allowedInputs()` = `['file']` (so it binds to a file base field).

## How to configure (UI)

1. On a content type, add a **File** field that accepts PDFs (the "base field").
2. On the same content type, add a **Text (formatted, long)** field (→ use the
   `_text_long` plugin) **or** a **Text (plain, long)** field (→ `_string_long`).
3. Edit that text field, open **AI Automators**, enable it, and choose **Simple PDF to
   Text**. Set the base field to the PDF file field.
4. On node save the automator fills the text field with the PDF's text.

## Mechanism (from source)

- `FileToTextBase::generate()` iterates `$entity->{$automatorConfig['base_field']}`,
  and for each referenced file entity calls
  `(new Smalot\PdfParser\Parser())->parseFile($fileEntity->getFileUri())->getText()`,
  collecting one string per file. Input is the managed file's own URI — an
  editor-uploaded, access-controlled file, not a request- or config-supplied path.
- `FileToText::storeValues()` wraps each string as
  `['value' => $text, 'format' => $format]`, where `getTextFormat()` picks the field's
  first `allowed_formats` setting, else the first available `filter_format`. So the
  stored text is subject to the chosen text format on render (normal Drupal filtering).
- `FileToString` inherits the base `storeValues()` (plain string, no format).
- `verifyValue()` accepts any string.

## Notes / caveats

- Pure PHP: no `pdftotext`/Ghostscript, no shell-out. Extraction quality is basic
  (no OCR, layout can be lost) — for richer parsing the maintainers suggest Unstructured.
- Large or many PDFs are parsed synchronously on entity save; size inputs accordingly.
- The module provides **no** config object or schema of its own; all settings live in
  the AI Automator configuration on the field.
