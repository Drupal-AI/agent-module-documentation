<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Simple PDF to Text (ai_simple_pdf_to_text) — agent index

Converts a PDF to plain text **on the server** with the pure-PHP `smalot/pdfparser`
library — no `pdftotext`/Ghostscript, no shell-out. Package **AI Tools**. Version
**1.0.0-alpha3**. Core `^10 || ^11`. License GPL-2.0-or-later.

Depends (via composer/functionally) on **`drupal/ai`** and, for the automator plugins,
the **`ai_automators`** submodule of AI. Requires the PHP library **`smalot/pdfparser`
`^2.12`**. No routes, no permissions, no config, no services, no hooks, no Drush.

## What it provides

- **Two AI Automator type plugins** (need `ai_automators`) →
  [plugins/automators.md](plugins/automators.md)
  - `simple_pdf_to_text_text_long` (`FileToText`) — fills a `text_long` field.
  - `simple_pdf_to_text_string_long` (`FileToString`) — fills a `string_long` field.
  - Both extend `FileToTextBase` (`generate()` parses each referenced file with
    `Smalot\PdfParser\Parser::parseFile(...)->getText()`).
- **One AI function-call tool** (needs `ai`) →
  [plugins/function-call.md](plugins/function-call.md)
  - `simple_pdf_to_text` (`PdfToText`, id `ai_simple_pdf_to_text:simple_pdf_to_text`,
    group `information_tools`) — extracts text given a `file_id` **or** a
    `file_location`.

## Mechanism (from source)

- All extraction goes through `Smalot\PdfParser\Parser::parseFile($uri)->getText()`.
  Pure PHP; the module never invokes `exec`/`proc_open`/Symfony Process.
- The automators read the **managed file entity's own URI**
  (`$entityWrapper->entity->getFileUri()`) from the configured base field, so the input
  is an editor-uploaded, access-gated file.
- The module does **not** call any AI provider itself; it only returns a string. What
  happens to that string is up to the consuming automator chain or agent.

## Files

- `src/Plugin/AiAutomatorType/FileToTextBase.php` — base automator (`generate()`).
- `src/Plugin/AiAutomatorType/FileToText.php` — `text_long` rule + `storeValues()`.
- `src/Plugin/AiAutomatorType/FileToString.php` — `string_long` rule.
- `src/Plugin/AiFunctionCall/PdfToText.php` — the `simple_pdf_to_text` function call.
