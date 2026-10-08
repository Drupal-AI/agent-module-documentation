<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Entity Reference patterns

A pattern is a `entity_reference_pattern` config entity that rewrites the labels shown for one
entity type in entity-reference autocompletes and select/checkbox option lists, using a Token
string. Manage them at `/admin/config/search/entity-reference-patterns` (route
`entity.entity_reference_pattern.collection`, the `configure` route, permission
`administer entity reference pattern`). The list is a draggable table
(`Controller\EntityReferencePatternListBuilder`); add/edit/duplicate/delete open in modal dialogs.

## Config entity

- Type id `entity_reference_pattern`, `config_prefix: pattern` → config object name
  **`entity_reference_patterns.pattern.<id>`**. Class `Entity\EntityReferencePatternEntity`.
- `config_export` (stored keys): `id`, `label`, `type`, `pattern`, `selection_criteria`, `weight`
  (plus the usual `uuid`, `langcode`, `status`, `dependencies`).

| Key | Type | Meaning |
|---|---|---|
| `id` | string | Machine name. |
| `label` | label | Admin name shown in the patterns list. |
| `type` | string | Target entity type id (e.g. `node`, `user`, `taxonomy_term`, `media`). Only fieldable entity types are offered. |
| `pattern` | string | Token string rendered as the label (min 1 token required by the form). |
| `selection_criteria` | mapping | `{bundles: {bundle_id: bundle_id, ...}}`. Empty = applies to every bundle of `type`. |
| `weight` | integer | Order among patterns of the same type; lightest wins. |
| `status` | boolean | Only enabled (`status: 1`) patterns are applied. |

Schema: `config/schema/entity_reference_patterns.schema.yml`, key `entity_reference_patterns.pattern.*`.

## Form fields (`Entity\Form\PatternEditForm`)

| Field | Widget | Notes |
|---|---|---|
| Pattern type | select | Every entity type implementing `FieldableEntityInterface`. AJAX-reloads the rest of the form. |
| Autocomplete label pattern | textfield | `#token_types` = the chosen type (plus `term` for `taxonomy_term`); `#min_tokens: 1`; token-tree help link below it. |
| Bundle checkboxes | checkboxes | Only shown for types with a bundle key. Checked bundles → `selection_criteria['bundles']`; leave empty to match any bundle. |
| Label | textfield | Admin label. |
| ID | machine_name | Locked after creation. |
| Enabled | checkbox | Maps to `status`. |

New patterns are saved with `weight = 0`; reorder them by dragging in the list. The duplicate form
(`PatternDuplicateForm`) pre-fills a copy via `createDuplicate()`.

## Create/read via drush or PHP

```php
\Drupal::entityTypeManager()->getStorage('entity_reference_pattern')->create([
  'id' => 'node_by_title_author',
  'label' => 'Node: title + author',
  'type' => 'node',
  'pattern' => '[node:title] by [node:author:name]',
  'selection_criteria' => ['bundles' => ['article' => 'article']],
  'weight' => 0,
  'status' => TRUE,
])->save();
```

```bash
drush cget entity_reference_patterns.pattern.node_by_title_author
drush cr   # rebuild caches so the altered autocomplete route/labels take effect
```

Patterns are plain config, so they export/import with the site (`drush cex` / `drush cim`).

## Which pattern applies

`EntityReferencePatternEntity::loadByTargetType($type)` loads the enabled patterns for a type, sorted
by `weight` ascending (statically cached per request). `findMatchingPattern($type, $bundle)` returns
the first one whose `selection_criteria['bundles']` is empty or contains `$bundle` — so the
lightest-weight matching pattern wins, and a pattern with no bundle criteria matches every bundle.
Tokens are resolved with `Token::replace($pattern, [$entity_type_id => $entity], ['clear' => TRUE])`,
so unresolvable tokens render empty rather than erroring; if the whole pattern renders empty the code
falls back to the entity's default label.

## How patterns are applied at runtime

- **Live autocomplete suggestions.** `Routing\EntityReferencePatternRouteSubscriber` repoints core's
  `system.entity_autocomplete` route `_controller` at
  `Controller\EntityAutocompleteController::handleAutocomplete`, which uses the service
  `entity_reference_patterns.autocomplete_matcher` (`EntityReferencePatternMatcher`, extends core
  `EntityAutocompleteMatcher`). Its `getMatches()` token-renders each suggestion label; with no
  enabled patterns for the type it defers to the core matcher.
- **Existing / default value.** `hook_element_info_alter` (OO hook
  `Hook\EntityReferencePatternsHooks::elementInfoAlter`) sets the `entity_autocomplete` element's
  `#value_callback` to the module's `Element\EntityAutocomplete`, whose `getEntityLabels()` renders
  the value already stored in a reference field from the pattern. `getEntityLabels()` respects
  `view label` access (`- Restricted access -` otherwise).
- **Select / checkbox / radio widgets.** `hook_options_list_alter`
  (`EntityReferencePatternsHooks::optionsListAlter` → service `entity_reference_patterns.module`,
  `EntityReferencePatterns::optionsListAlter()`) rewrites the option labels the same way, so dropdown
  presentations match autocomplete. It no-ops when the context has no `fieldDefinition`.
- **Hiding the id.** Library `entity_reference_patterns/entity_reference_patterns.autocomplete`
  (`js/entity_reference_patterns.js`) strips the trailing ` (id)` from the visible input value while
  keeping the real `value (id)` in `data-real-value`, and overrides the autocomplete select handler so
  only the label shows. The stored field value is unchanged — this alters presentation only.

`ParamConverter\EntityReferencePatternConverter` (service `paramconverter.entity_reference_pattern`)
upcasts the `{entity_reference_pattern}` route slug on the edit/duplicate/delete routes.
