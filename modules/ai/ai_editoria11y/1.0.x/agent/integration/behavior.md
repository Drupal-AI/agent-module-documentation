<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Front-end integration (js/ai-editoria11y.js)

Library `ai_editoria11y/integration` (deps: `core/drupal`, `core/once`, `core/drupalSettings`,
`editoria11y/editoria11y`, `ai_ckeditor/ai_ckeditor`). Attached by
`ai_editoria11y_element_info_alter()` → `_ai_editoria11y_text_format_after_build()` only when the
user has `use ai editoria11y`, the element's active format is ckeditor5, and that format has the
`ai_editoria11y_fix` plugin enabled. `drupalSettings.aiEditoria11y` carries `enabled`,
`buttonLabel` and `dialogUrl` (`Url::fromRoute('ai_ckeditor.dialog')`).

## Button injection

`Drupal.behaviors.aiEditoria11y` (once per `body`) listens for Editoria11y's `ed11yPop` event and
runs `injectAiFixButton(event)`:
- Reads `detail.result.test` (issue type), `detail.result.content` (description; string or DOM in
  Editoria11y 3.x beta2+), and `detail.result.element`.
- Skips unless `enabled` and `isTestSupported(test)` — the supported set `SUPPORTED_TESTS` covers
  image (MISSING_ALT, IMAGE_DECORATIVE, ALT_PLACEHOLDER, ALT_FILE_EXT, SUS_ALT, various
  LINK_IMAGE_*, IMAGE_ALT_TOO_LONG…), link (LINK_NEW_TAB, LINK_EMPTY, LINK_EMPTY_NO_LABEL, LINK_URL,
  LINK_STOPWORD, QA_PDF), heading (HEADING_EMPTY, HEADING_LONG, HEADING_SKIPPED_LEVEL,
  QA_BLOCKQUOTE), text/table (QA_FAKE_LIST, QA_FAKE_HEADING, QA_UPPERCASE, TABLES_MISSING_HEADINGS,
  TABLES_EMPTY_HEADING, TABLES_SEMANTIC_HEADING) and embed (EMBED_*) tests.
- Requires a CKEditor context (`detectEditorContext()` walks up from `contenteditable` to a
  `.ck-editor__editable` and resolves the CKEditor 5 instance).
- Appends a `.ed11y-ai-fix-button` into the tooltip's shadow-root button bar.

## Click → dialog

On click it captures the element's clean HTML from `editor.getData()`
(`getElementHtmlFromData()` / `findNthTagInHtml()`), marks the element with a unique
`data-ai-ed11y-target` id, builds the issue context (`getIssueContext()` — tag, text, outerHTML,
attributes, parent tag, ±500 chars surrounding HTML, ±50 chars surrounding text), closes the
tooltip, and calls `openAiFixDialog()` → `Drupal.aickeditor.openDialog(dialogUrl, saveCallback,
dialogSettings, additionalData)`. `additionalData` posts `plugin_id`, `editor_id`,
`ed11y_issue_type`, `ed11y_issue_description`, `ed11y_context` (JSON).

## Streaming preview & diff

`overrideAiRequestHandler()` monkey-patches `Drupal.AjaxCommands.prototype.aiRequest`: for
`plugin_id === 'ai_editoria11y_fix'` it runs `handleAiRequest()` instead of the default, which
`fetch()`es `…/api/ai-ckeditor/request/{editor_id}/{plugin_id}` (same-origin, `X-Requested-With`),
reads the streamed body, stores it in the hidden `ai_raw_response` field, and calls
`updatePreview()`:
- While streaming: shown as escaped text in a `<pre>` (`escapeHtml()`).
- On completion: `buildDiffView(originalHtml, fixedHtml)` renders a before/after diff — text
  content, key attributes (alt/title/href/aria-*/role/scope/headers/target/rel) and tag changes are
  compared and shown escaped; table/list structural changes are shown as rendered previews. It then
  enables the Save button.

## Applying the fix

The dialog's save callback → `handleDialogSave()` → `applyFix()` → `applyFixViaSetData()`:
maps the marked DOM element to its CKEditor view/model element and replaces it with the fixed HTML
via `editor.model.change` + `insertContent` (so undo history is kept). For `imageInline` /
`imageBlock` it only updates the `alt` attribute (to avoid flipping inline↔block). Markers are then
cleaned up and `rerunCheck()` calls `Drupal.Ed11y.refresh()` to re-scan.

## Notes

- The AI suggestion is generated from, and previewed in, the editing user's own browser/session;
  applied content passes through the text format's filters on save. The provider call itself is
  handled by the `ai_ckeditor` endpoint, not by this module.
