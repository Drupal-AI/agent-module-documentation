<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The viewer — attachment, detection & rendering

The entire viewer is client-side JavaScript. The PHP side only decides **when** to attach it and
supplies configuration.

## Attachment (PHP)

`dblog_json_viewer_page_attachments(&$attachments)` (`dblog_json_viewer.module`):

- Runs on every page, but only acts when `\Drupal::routeMatch()->getRouteName() === 'dblog.event'`
  **and** the current user has `access site reports` **or** `administer site configuration`.
- When both hold, it attaches library `dblog_json_viewer/dblog-json-viewer` and populates
  `$attachments['#attached']['drupalSettings']['dblogJsonViewer']` with `buttonTexts` and
  `settings` (searchDelay, enableDebugLogs, apiPatterns, sectionPatterns) from
  `dblog_json_viewer.settings` (see [../config/settings.md](../config/settings.md)).

Library `dblog-json-viewer` (`dblog_json_viewer.libraries.yml`): CSS `css/dblog-json-viewer.css`;
JS `js/jsonview.js` then `js/dblog-json-viewer.js` (deferred); depends on `core/drupal`.
`js/jsonview.js` is a bundled UMD build of the pgrabovets/json-view library exposing
`window.jsonview` (`create`, `render`, `renderJSON`, `expand`, `collapse`, `toggleNode`, …).

## The `JSONViewer` class (`js/dblog-json-viewer.js`)

Instantiated on DOM ready. Key flow:

- `isValidPage()` — only proceeds when `location.pathname` contains
  `/admin/reports/dblog/event/` and starts with `/admin/`.
- `getTargetElement()` — the message cell:
  `document.querySelector('table.dblog-event > tbody > tr:nth-child(6) > td')`.
- `initializeJSONView()` — stores `state.originalContent = tdElement.innerHTML`, runs
  `extractJSONFromContent()`, and either renders the viewer (`setupJSONViewer`) or shows a
  "no JSON found" fallback (`showNoJSONFound`).

### Detection pipeline

1. `stripHTMLTags(html)` — sets `div.innerHTML = html` and returns `div.textContent`, i.e. the
   cell's text with HTML entities decoded back to raw characters.
2. `extractMultipleJSONSections(text)` — first tries **position-based** extraction
   (`extractAPILogSections`): finds each `sectionPattern` used as `Label:`, then for each section
   takes the substring from the label to the next label and extracts the first balanced `{…}` via
   `findMatchingBrace()`. Falls back to **regex** extraction (one `Label\s*:\s*({…})` regexp per
   configured `sectionPattern`). If more than one section parses, they are returned as a combined
   object.
3. Otherwise `findAllJSONObjects(text)` collects every balanced `{…}` block, parses each with
   `tryParseJSON()`, sorts by `getComplexityScore()` (nested-key count ×10 + serialized length),
   and takes the best; `extractLargestJSONBlock()` is a fallback that scores with
   `calculateJSONScore()` (key count, `apiPatterns` matches, array sizes, string size).
4. `parseNestedJSONStrings(obj)` — recursively (`depth ≤ 10`) re-parses any string value that looks
   like JSON (`{…}`/`[…]`), unwrapping double-encoded JSON.
5. `tryParseJSON()` runs `cleanJSONString()` first, which un-escapes `&quot; &lt; &gt; &amp;` and
   collapses whitespace before `JSON.parse`.

### Rendering & UI

- `renderViewer()` builds a buttons row (search box + clear, prev/next, expand/collapse, view
  toggle, copy JSON, copy raw, fullscreen), a `#json-view` container, and a `#raw-json` container.
  The raw container is filled with `<pre>` wrapping `state.originalContent`. The tree is rendered
  by `jsonview.renderJSON(state.jsonObject, jsonContainer)` when `window.jsonview` exists (a
  `JSON.stringify` `<pre>` fallback runs only if the library is missing).
- Search (`handleSearch`) debounces by `settings.searchDelay`, walks `.json-string/.json-key/
  .json-value` nodes, highlights `textContent` matches, and supports prev/next navigation with
  auto-expand.
- `toggleExpandCollapse`, `toggleView`, `toggleFullscreen` (adds `json-fullscreen` /
  `json-fullscreen-active` classes; ESC exits), and `copyJSON` / `copyRawContent`
  (`navigator.clipboard.writeText` with a `document.execCommand('copy')` textarea fallback).

## What it does NOT do

- No routes of its own for the viewer, no AJAX/server round-trips, no DB writes, no outbound HTTP.
- It only reformats content that core's dblog event page already placed in the message cell; it is
  active solely on `dblog.event` for reports-capable users.
