<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Cleanup — scan / analyze / clean pipeline

Two services do the work: `Service\ContentCleanupAnalyzer` (detect + store) and
`Service\ContentCleanupProcessor` (transform + apply). Both take `@database`, `@entity_type.manager`,
`@config.factory`, `@datetime.time` (the processor also takes the analyzer).

## Detection — `ContentCleanupAnalyzer`

- `scanContent(int $limit)` — loads the configured `scan_content_types` node bundles via an entity query
  (`->accessCheck(FALSE)`, sorted by `changed`, ranged to `$limit`), and for each node calls `analyzeNode()` then
  `replaceStoredIssues()`. Returns `scanned`/`issues`/`remaining` counts. Reached from the `scan` controller page.
- `analyzeNode($node)` — iterates the node's `text`, `text_long`, `text_with_summary` fields and runs
  `analyzeHtml()` on each value, tagging results with the node's id/bundle/label.
- `analyzeHtml($html, $field_name)` — runs the enabled rules and returns issue arrays. Detectors:
  `hasBrokenHtml()` (unclosed `<...` or an unbalanced tag stack, void tags excluded), `preg_match('/\sstyle\s*=/i')`
  for inline styles, `hasHeadingJump()` (heading level increases by >1), `<img>` without `alt`, empty
  `p`/`div`/`span` wrappers, and `<font|center|strike>` for deprecated markup. Each issue carries a fixed
  `message`, `suggestion`, `severity` and integer `score` (all module-defined literals, not user/remote data).
- `replaceStoredIssues()` — deletes the node's open rows from `ai_content_cleanup_issue`, then inserts the fresh
  detected issues (parameterized `insert()`; entity id/bundle/field come from the node).
- Read helpers: `getIssueRows()`, `getIssue()`, `getDashboardData()`, `getReportData()`, `getRecentHistory()`,
  `getIssuesByType()`. `decorateIssueRecord()` calls `loadEntityLabel()` to show the referenced entity's label.
  When the tables are empty these fall back to hard-coded sample rows so the UI is never blank.

## Transformation — `ContentCleanupProcessor::cleanHtml()`

Given an HTML string and the `enabled_rules`, applies (in order):

| Rule | Transform |
|---|---|
| `broken_html` | `repairHtml()` — wraps in `<div>`, `DOMDocument::loadHTML()` with `LIBXML_HTML_NOIMPLIED\|NODEFDTD` (errors suppressed), re-serializes child nodes. |
| `inline_styles` | `preg_replace('/\sstyle=("\|\').*?\1/i', '', ...)`. |
| `deprecated_markup` | strips `<font\|center\|strike>`, maps `<b>`→`<strong>`, `<i>`→`<em>`. |
| `accessibility` | adds `alt=""` to `<img>` tags that lack `alt`. |
| `empty_elements` | removes empty `<p\|div\|span>` (whitespace/`&nbsp;`/`<br>` only). |
| `heading_hierarchy` | `normalizeHeadings()` — clamps each heading to at most `last+1`, starting at `heading_start_level`. |

Returns `original`, `cleaned` (trimmed), `applied` (labels), `issues_fixed` (before/after analyzer counts) and a
heuristic `confidence`. This is deterministic string processing — there is no LLM/network call.

## Applying to a node — `ContentCleanupProcessor::cleanNode()`

Reached only via route `ai_content_cleanup.apply` (`administer ai content cleanup` + `_csrf_token`), called from
`AiContentCleanupController::applyChanges()`:

1. Iterates the node's `text`/`text_long`/`text_with_summary` fields; for each non-empty one takes the first item's
   value array, runs `cleanHtml()` on `value['value']`, and (if changed) `$node->set($field_name, $value)` —
   **preserving the item's other keys, including `format`**, so the stored text format is retained.
2. If anything changed: `setNewRevision(TRUE)`, sets a revision log message, `$node->save()`, and
   `recordHistory('auto_clean', 'node', nid, fixed, confidence)`.
3. `recordHistory()` inserts into `ai_content_cleanup_history` and marks the node's `ai_content_cleanup_issue`
   rows `fixed` (both parameterized).

`applyChanges()` shows a status/warning message and redirects back to the node editor. The cleaned value is stored
in the field and rendered later through that field's **text format** on display (the cleanup does not itself add a
new rendering path).

## Editor & bulk pages

- `editor($node)` — extracts the first text field value (or a built-in demo string when no node) and passes the
  `cleanHtml()` result to the template. The Twig template prints `editor.original` / `editor.cleaned` inside
  `<pre>{{ ... }}</pre>`, so the markup is **auto-escaped by Twig** and shown as literal text, not rendered.
- `bulk()` — a multi-step wizard driven by `step`/`operation` query args. Its final "Process" step does **not**
  batch-apply changes in this release; the template states that individual node changes are applied from the editor
  so revisions can be reviewed. So the only content mutation path is the CSRF-protected, admin-gated `.apply` route.

## DB tables (`ai_content_cleanup.install`)

- `ai_content_cleanup_issue` — `id`, `entity_type`, `entity_id`, `bundle`, `field_name`, `issue_type`, `severity`,
  `message`, `suggestion`, `status` (open/fixed), `score`, `created`, `changed`; indexed on entity/issue_type/
  status/severity.
- `ai_content_cleanup_history` — `id`, `operation`, `entity_type`, `entity_id`, `issues_fixed`, `confidence`,
  `status`, `created`.

All queries use the DB API's parameterized builders (`select/insert/update/delete` with `condition()`), and stored
issue text is module-generated, not attacker markup.
