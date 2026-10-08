<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Duplicate-search behavior (form alter + AJAX callback)

## Form alter — `anti_duplicates_form_node_form_alter()` (`anti_duplicates.module`)

`hook_form_FORM_ID_alter` for `node_form`. Only acts when the form has a `title` element and the
route has a `node` or `node_type` parameter (i.e. an add/edit form). It resolves the current
`node_type` from those parameters and proceeds when the type is in `anti_duplicates_content_types`
**or** that list is empty. Then it:

- Picks the introduction message (`anti_duplicates_message.value`).
- Resolves the AJAX triggers: `array_filter(anti_duplicates_ajax_events)`, falling back to
  `['keyup_debounced' => 'keyup_debounced']` when empty.
- Attaches `#ajax` to `title[widget][0][value]`: callback
  `Drupal\anti_duplicates\Form\AntiDuplicatesFormAlter::duplicatesSearch`, `event` = the configured
  triggers joined by a space (e.g. `keyup_debounced blur`), `disable-refocus` TRUE, wrapper
  `dw_container`, throbber progress. Adds classes `anti-duplicates-title` and `delayed-input-submit`
  and sets `data-delay` = `anti_duplicates_debounce_delay` (default 500).
- Adds a hidden `#dw_container` div (`html_tag`) holding the message. If `anti_duplicates_placement`
  is falsy (sidebar), it is wrapped in a `details` element `anti_duplicates` added to the `advanced`
  group (weight −100, open); otherwise it is placed directly under the title field.
- Attaches library `anti_duplicates/anti_duplicates` and sets
  `drupalSettings.anti_duplicates.disable_form` = `anti_duplicates_form_submission` and
  `drupalSettings.anti_duplicates.ajax_events` = the trigger keys.

The `keyup_debounced` trigger (and the `data-delay` debounce) and the disable-submit behavior are
implemented in the module's JS (`assets/js/script.js`, library `anti_duplicates.libraries.yml`,
depends on `core/drupal`, `core/drupalSettings`, `core/jquery`). The JS re-enables the submit buttons
when the author clicks the "Not a duplicate" link or when no results are returned.

## AJAX callback — `AntiDuplicatesFormAlter::duplicatesSearch()` (`src/Form/AntiDuplicatesFormAlter.php`)

Static `#ajax` callback (reachable only through the node form's AJAX submit, so it carries the form's
build ID; there is no standalone route). Steps:

1. Reads the typed title from `$form_state->getValue('title')[0]['value']` and trims it.
2. Gets the current node from the form object (`getEntity()`), asserts `NodeInterface`.
3. Returns an empty `AjaxResponse` early if the current node's type is not in
   `anti_duplicates_content_types` (strict `in_array($type, $contentTypes, TRUE)`). An empty list is
   treated as "all types", so the early return only fires for a non-empty list that excludes the type.
4. If a title is present, runs one of three `\Drupal::entityQuery('node')` queries by
   `anti_duplicates_search_type`, all with `->accessCheck()` (default TRUE — respects node access) and
   `->condition('type', $currentNode->getType())`, excluding the current node's `nid` when it is not new:
   - **0 — sequence:** `title` LIKE `%` + `str_replace(' ', '%', $title)` + `%`.
   - **1 — exact substring:** `title` LIKE `%title%`.
   - **2 — any word:** `preg_split('/\s+/', …)` on the title and ORs a `title LIKE %word%` condition
     per word (`orConditionGroup`).
   Each mode computes a `count()` from a clone of the query, then loads up to `search_result_limit`
   nids (`range(0, $resultLimit)`, skipped when the limit is 0 → all) via `Node::loadMultiple()`.
   The LIKE values are passed as query-builder arguments (bound placeholders), not concatenated SQL.
5. Builds the `AjaxResponse`: removes/re-appends `#dw-listing` (`<ul>`) and removes `#dw-total`.
   Returns early when `count` is 0 (nothing more appended).
6. When `result_count_message.value` is set, appends a `#dw-total` container rendering it as
   `processed_text` (its configured text format) with `@count` replaced by the total.
7. For each found node, appends a `<li>` whose link is built with
   `Link::fromTextAndUrl($node->label(), Url::fromRoute('entity.node.canonical', …))` — the link
   generator escapes the title in both the link text and the `title` attribute. The link opens in a
   new tab (`target="_blank"`, `rel="noopener noreferrer"`).
8. If `anti_duplicates_form_submission` is on and `count > 0`, appends a "Not a duplicate" button
   (`#dw-enable-form`) that the JS uses to re-enable submission; otherwise it removes that button.

The callback returns an `AjaxResponse` of `RemoveCommand`/`AppendCommand` objects; it renders no
Twig template. Only nodes the current user may access are ever counted or listed (`accessCheck()`),
and node titles are output through the escaping link generator / a `processed_text` render array.
