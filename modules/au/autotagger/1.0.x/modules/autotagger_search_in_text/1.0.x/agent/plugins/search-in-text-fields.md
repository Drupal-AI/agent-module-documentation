<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `search_in_text_fields` plugin — config, pipeline, matching

Single file: `src/Plugin/Autotagger/SearchInTextFields.php`. Annotation
`@Autotagger(id="search_in_text_fields", label=@Translation("Search in Text fields"), configurable=false)`.
Extends `AutotaggerPluginBase`, implements `ContainerFactoryPluginInterface`. `create()` injects
`entity_field.manager`, `entity_type.manager`, and `entity_type.manager->getStorage('node_type')`.

## Configuration (per content type)

`addFormOptions(&$form, $form_state, $form_id)` early-returns unless
`$form_id` is `node_type_add_form` or `node_type_edit_form`. It builds field option lists from
`entityFieldManager->getFieldDefinitions('node', $type)`:

- **Source candidates** (`getSourceFieldsCandidates()`): field types
  `text`, `string`, `text_with_summary`, `string_with_summary`, `text_long`, `string_long`.
  Also offered as sources: `entity_reference` fields targeting `node` or `media` (scans text fields on
  the referenced entity) and `entity_reference_revisions` fields (paragraphs).
- **Destination candidates**: `entity_reference` fields whose `target_type` is `taxonomy_term`.

Form elements added under an `additional_settings` details group titled
`Autotagger : Search in Text fields`:

| Key | Type | Meaning |
| --- | --- | --- |
| `autotagger_source_field` | checkboxes | Fields to scan for term labels. |
| `autotagger_destination_field` | select | The taxonomy_term reference field to fill. |
| `autotagger_tag_on_create_only` | checkbox | Only tag when the node is first created. |

Persistence: `$form['#entity_builders'][] = [$this, 'entityBuilder']`. `entityBuilder()` stores the
three values via `$node_type->setThirdPartySetting('autotagger', 'search_in_text_fields', …)`. This is
covered by the parent module's schema key `node.type.*.third_party.autotagger` (mapping
`search_in_text_fields: type: ignore`).

## Tagging pipeline (on node presave)

`entityPresave(NodeInterface $node)`:
1. Load the node's `node_type`; if not a `ConfigEntityInterface`, return.
2. Read third-party setting `autotagger.search_in_text_fields`; if empty, return (unconfigured types
   are left alone).
3. `$create_only = settings['autotagger_tag_on_create_only']`. Tag if `$node->isNew()` **or** not
   create-only; else skip. Then `tagNode($node)`.

`tagNode(NodeInterface &$node)`:
- Reads `autotagger_source_field` / `autotagger_destination_field` from the setting. **Bails** if
  source or destination is empty, or if `$node->getFieldDefinition($destination)` is falsy (the
  configured field no longer exists) — this guard was added to stop a fatal on a stale/empty
  destination (see the kernel test `testInvalidDestinationField`).
- For each source field present on the node: `entity_reference_revisions` → `processParagraphEntity()`
  (recurses into nested paragraph fields); `entity_reference` → `processReferencedEntity()` (scans the
  referenced entity's text-candidate fields); text/string candidate types → `processTextField()`.
  `processTextField()` pushes each item's raw value array into `$text_array`.
- Concatenates all collected `summary` and `value` strings, each `trim(strtolower(...))`, into one
  `$text` haystack.
- Loads all possible destination terms:
  `getFieldDefinition($destination)->getFieldStorageDefinition()->getOptionsProvider($destination, $node)->getPossibleValues()`
  → `taxonomy_term` storage `loadMultiple()`.
- For each term, if `search($term->label(), $text)` → `tag($node, $destination, $term)`.

`tag()` reads existing `target_id`s of the destination field and `appendItem(['target_id' => $tid])`
only when the term id is not already present (no duplicates; existing manual tags preserved).

## Matching semantics — `search($needle, $haystack)`

- `\Normalizer::normalize(..., FORM_C)` on both (handles accented chars).
- `preg_replace("/[^\p{L}0-9]+/u", " ", …)` collapses every non-letter/digit run to a single space,
  then `strtolower`, then wraps the needle and haystack in leading/trailing spaces.
- Returns `strpos($haystack, $needle) !== FALSE` → **whole-word, case-insensitive, literal substring**
  match. A term "Cat" matches the word "cat" but not "category" (word boundaries are enforced by the
  space-wrapping). No stemming, fuzzy, or semantic matching.

## Caveats

- v1 is **node-only**; the presave hook in the parent is `node_presave`.
- Tagging cost scales with the number of possible terms in the destination vocabularies (every term is
  loaded and tested per save) and with the amount of source text (paragraph recursion).
- The kept but unused config key `autotagger_rebuild_on_submit` appears only in the test fixtures, not
  in the shipped form or logic.
