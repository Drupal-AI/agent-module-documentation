<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `simple_pdf_to_text` function-call tool

An AI **function call** (tool) that AI agents/assistants built on `drupal/ai` can invoke
to get the plain text of a PDF. Class `PdfToText` in
`src/Plugin/AiFunctionCall/PdfToText.php`.

## Declaration

`#[FunctionCall(...)]` attribute:

- id: `ai_simple_pdf_to_text:simple_pdf_to_text`
- function_name: `simple_pdf_to_text`
- name: *Simple PDF to Text*
- group: `information_tools`
- description: *"This method extracts text from a PDF document given its file ID or
  location. Only one of the parameters is required."*

Context definitions (parameters), both optional individually — exactly one must be
supplied:

| Parameter | Type | Meaning |
|---|---|---|
| `file_id` | string | The Drupal **file entity ID** of the PDF. |
| `file_location` | string | A **URI/URL** (stream wrapper or path) of the PDF. |

The class implements `ExecutableFunctionCallInterface`; the result is returned via
`setOutput()` and read back by the agent with `getReadableOutput()`.

## `execute()` flow (from source)

1. Reads `file_id` and `file_location` context values.
2. If both are empty → outputs *"Either 'file_id' or 'file_location' must be provided."*
3. If both are set → outputs *"Please provide only one …, not both."*
4. If `file_id` is set: loads the file entity via
   `entity_type.manager` → `getStorage('file')->load($file_id)`; on a missing file it
   outputs a not-found message; it then checks `$file->access('view', $this->account)`
   (the current user, injected from `current_user`) and, if denied, outputs a
   permission message; otherwise it resolves `$file_location = $file->getFileUri()`.
5. Parses with `(new Smalot\PdfParser\Parser())->parseFile($file_location)->getText()`
   inside a try/catch; on failure it outputs *"Failed to extract text from the PDF
   document: …"*. On success the extracted text is the output.

## Services injected

`ai.context_definition_normalizer`, `current_user` (as `$account`),
`entity_type.manager`. Constructor + `create()` are standard container injection.

## Operating notes

- Extraction is pure PHP (`smalot/pdfparser`); the tool never shells out and never
  itself calls an AI provider — it only returns the document text to the caller.
- Enable/expose this tool through your agent/assistant configuration in the AI module;
  the module ships only the plugin, no route or UI of its own.
