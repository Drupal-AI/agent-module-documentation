<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Duplicate-search behavior (form alter + AJAX callback)

## Form alter — `anti_duplicates_form_node_form_alter()` (`anti_duplicates.module`)

`hook_form_FORM_ID_alter` for `node_form`. Only acts when the form has a `title` element and the
route has a `node` or `node_type` parameter (i.e. an add/edit form). It resolves the current
`node_type` from those parameters and proceeds when the type is in
`anti_duplicates_content_types` **or** that list is empty. Then it:

- Picks the notice message (`anti_duplicates_message.value`, else a default `t()` string).
- If `anti_duplicates_placement` is falsy (sidebar), adds a `details` element `anti_duplicates` to the
  `advanced` group (weight −100, open).
- Attaches `#ajax` to `title[widget][0][value]`: callback
  `Drupal\anti_duplicates\Form\AntiDuplicatesFormAlter::duplicatesSearch`, event `keyup_debounced`,
  wrapper `dw_container`, throbber progress. Adds class `delayed-input-submit` and `data-delay=500`.
- Adds a hidden `#dw_container` div (`html_tag`) holding the message.
- Attaches library `anti_duplicates/anti_duplicates` and sets
  `drupalSettings.anti_duplicates.disable_form` = `anti_duplicates_form_submission`.

The `keyup_debounced` event and the disable-submit behavior are implemented in the module's JS
(`assets/js/script.js`, library `anti_duplicates.libraries.yml`, depends on `core/jquery`).

## AJAX callback — `AntiDuplicatesFormAlter::duplicatesSearch()` (`src/Form/AntiDuplicatesFormAlter.php`)

Static `#ajax` callback (reachable only through the node form's AJAX submit, so it carries the form's
build ID; there is no standalone route). Steps:

1. Reads the typed title from `$form_state->getValue('title')[0]['value']` and trims it.
2. Gets the current node from the form object (`getEntity()`), asserts `NodeInterface`.
3. Returns an empty `AjaxResponse` early if the current node's type is not in
   `anti_duplicates_content_types` (strict `in_array($type, $contentTypes, TRUE)`). Note: with the
   default config this list is keyed and valued by machine name, so `article`/`page` match; an empty
   list here means **no** type matches and the callback returns nothing.
4. If a title is present, runs one of three `\Drupal::entityQuery('node')` queries by
   `anti_duplicates_search_type`, all with `->accessCheck()` (default TRUE — respects node access) and
   `->condition('type', $currentNode->getType())`, excluding the current node's `nid` when it is not new:
   - **0 — sequence:** `title` LIKE `%` + `str_replace(' ', '%', $title)` + `%`.
   - **1 — exact substring:** `title` LIKE `%title%`.
   - **2 — any word:** splits the title on spaces and ORs a `title LIKE %word%` condition per word
     (`orConditionGroup`).
   Each mode computes a `count()` and loads up to 5 nids (`range(0,5)`) via `Node::loadMultiple()`.
   The LIKE values are passed as query-builder arguments (bound placeholders), not concatenated SQL.
5. Builds the `AjaxResponse`: removes/re-appends `#dw-listing` (`<ul>`), removes `#dw-total`, and — unless
   `count` is 0 and `anti_duplicates_display_not_zero` is off — appends a `#dw-total` span with the count.
6. For each found node, appends a `<li>` with an absolute link
   (`Url::fromRoute('entity.node.canonical', ...)`) to `#dw-listing`.
7. If `anti_duplicates_form_submission` is on and `count > 0`, appends a "Not a duplicate" button
   (`#dw-enable-form`) that the JS uses to re-enable submission; otherwise it removes that button.

The callback returns an `AjaxResponse` of `RemoveCommand`/`AppendCommand` objects; it renders no
Twig template. Only nodes the current user may access are ever counted or listed (`accessCheck()`).
