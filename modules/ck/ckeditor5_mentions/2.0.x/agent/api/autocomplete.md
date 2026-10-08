<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete endpoint & editor integration

## Endpoint
`ckeditor5_mentions.annotations` → `GET /ckeditor5/api/annotations`
(`ckeditor5_mentions.routing.yml`), `_permission: mention users`, `_format: json`.
Handler: `src/Controller/MentionAutocompleteController::annotation()`.

Query params: `query` (search term, required — empty ⇒ `[]`), `id` (mention_feed id,
required — empty ⇒ `[]`), `limit` (optional, cast to int, default 10).

Flow in `annotation()`:
1. Loads the feed by `id` (`MentionFeed::loadMultiple([$id])`); reads `marker`,
   `entity_type`, `entity_bundle`, `feed_items`.
2. Builds an entity query on `entity_type` storage with `accessCheck(TRUE)` and
   `range(0, $limit)`. Adds a `published = TRUE` condition when the entity type has a
   published key, and a bundle condition when `entity_bundle` is set.
3. Match condition: for `entity_type === 'user'` an OR group of `name CONTAINS` /
   `mail CONTAINS`; otherwise `label CONTAINS` when the type has a label key.
4. Loads matches and appends `['id' => $marker . $entity->label(), 'link' => '']` per
   entity (skipping id 0 / anonymous).
5. If the feed has `feed_items`, appends static items whose string starts with `marker`
   and matches the search term.
6. Returns an `AjaxResponse` of the result list (JSON array of `{id, link}`).

Note: `annotation()` queries entities directly and does **not** call
`MentionDataProvider::getPrivilegedEditors()`; result scope is bounded by the entity
query's `accessCheck(TRUE)` and the published/bundle conditions.

## MentionDataProvider (helper service)
`src/DataProvider/MentionDataProvider.php`, service
`ckeditor5_mentions.data_provider.mentions`. `getPrivilegedEditors(string $query, int
$users_limit = 10)` pages active users whose `name CONTAINS $query` (accessCheck TRUE,
`status = 1`) and keeps only those with the `to be mentioned` permission. Present in the
container but not used by the 2.0.0 endpoint.

## Client integration
`hook_element_info_alter()` adds `MentionsIntegration::process` to the `text_format`
element `#process` chain. `src/Element/MentionsIntegration::processElement()` (service
`ckeditor5_mentions.element.mentions_integration`) runs only when the form object is an
entity form and the current user has `mention users`; it collects enabled feeds per editor
from `settings['plugins']['ckeditor5_mentions_mention']['mention_feeds_enabled']` and
attaches to `drupalSettings`: `annotations_url`, `dropdown_limit`, and
`ckeditor5Premium.mentions` / `mention_feeds_enabled` / `active_editors`.

JS: `js/ckeditor5_plugins/mentionsIntegration/src/mentionsIntegration.js` registers the
CKEditor 5 `MentionsIntegration` plugin whose `getFeedItems(queryText)` AJAX-GETs
`/ckeditor5/api/annotations?query=…` and resolves the mention dropdown with the returned
list. CKEditor 5's core Mention feature renders the picked item and stores it as
`<span class="mention" data-mention>` (the element allowed by the plugin's `elements`).
Library wiring: `ckeditor5_mentions.libraries.yml` (`mention-integration`),
`hook_library_info_build()`, `ckeditor5_mentions.ckeditor5.yml`.

## Other utilities
`src/Utility/MentionsHelper::getMentions($body)` extracts `#`-marked tokens from a body via
regex (server-side helper). `MentionSettings` returns hardcoded defaults (marker `#`,
min chars 1, list length 4). `HtmlHelper` / `Html` are DOM helpers for collaboration markup.
