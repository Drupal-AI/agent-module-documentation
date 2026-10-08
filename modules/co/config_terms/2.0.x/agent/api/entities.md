# Config entity types, storage API, admin UI

The module defines two `@ConfigEntityType`s that mirror taxonomy but store as configuration
(exportable, not fieldable, no revisions/translations).

## `config_terms_vocab` (vocabulary)

`Drupal\config_terms\Entity\Vocab implements VocabInterface`.

- `config_prefix`: `config_terms_vocab` → config objects `config_terms.config_terms_vocab.<id>`.
- `admin_permission`: `administer config terms`.
- `config_export`: `label`, `id`, `description`, `weight`, `hierarchy`.
- Handlers: `list_builder` = `VocabListBuilder` (draggable), `storage` = `VocabStorage`,
  forms `default`=`VocabForm` / `delete`=`VocabDeleteForm` / `reset`=`VocabResetForm`,
  `route_provider.html` = `VocabHtmlRouteProvider`.
- Hierarchy constants on `VocabInterface`: `HIERARCHY_DISABLED = 0`, `HIERARCHY_SINGLE = 1`,
  `HIERARCHY_MULTIPLE = 2`. Recomputed automatically from term parents on save
  (`config_terms_check_vocab_hierarchy()`), so it is normally not set by hand.
- Accessors: `getLabel()`, `getDescription()`, `getWeight()`, `getHierarchy()`, `setHierarchy()`.
- `Vocab::preDelete()` cascades: deleting a vocab deletes its top-level terms (children follow).

## `config_terms_term` (term)

`Drupal\config_terms\Entity\Term implements TermInterface`.

- `config_prefix`: `config_terms_term` → config objects `config_terms.config_terms_term.<id>`.
- `admin_permission`: `administer site configuration`; access is actually decided by the custom
  handler `TermAccessControlHandler` (see permissions/permissions.md).
- `config_export`: `id`, `vid`, `label`, `parents`, `description`, `weight`.
- `parents` is a sequence of parent term IDs; `['0']` (string zero) means a root/top-level term.
- Handlers: `list_builder` = `TermListBuilder`, `storage` = `TermStorage`,
  forms `default`=`TermForm` / `delete`=`TermDeleteForm`, `route_provider.html` = `TermHtmlRouteProvider`,
  `access` = `TermAccessControlHandler`.
- Accessors: `getName()` (returns label), `getVid()`, `getWeight()`/`setWeight()`,
  `getParents()`/`setParents()`, `getDepth()`/`setDepth()`, `getDescription()`/`setDescription()`.
- `Term::postDelete()` re-parents or deletes orphaned children.

## Admin UI / routes (all under `administer config terms` unless noted)

| Route | Path | Access |
|---|---|---|
| `entity.config_terms_vocab.collection` | `/admin/structure/config-terms` | `administer config terms` |
| `entity.config_terms_vocab.add_form` | `/admin/structure/config-terms/add` | `_entity_create_access: config_terms_vocab` |
| `entity.config_terms_vocab.edit_form` | `/admin/structure/config-terms/{vocab}/edit` | `_entity_access: config_terms_vocab.update` |
| `entity.config_terms_vocab.delete_form` | `/admin/structure/config-terms/{vocab}/delete` | `_entity_access: config_terms_vocab.delete` |
| `entity.config_terms_vocab.reset_form` | `/admin/structure/config-terms/{vocab}/reset` | `administer config terms` |
| `entity.config_terms_vocab.overview_form` | `/admin/structure/config-terms/{vocab}/overview` | `_entity_access: config_terms_vocab.view` |
| `entity.config_terms_term.add_form` | `/admin/structure/config-terms/{vocab}/add` | `_entity_create_access: config_terms_term:{vocab}` |
| `entity.config_terms_term.edit_form` | `/config-terms/config-term/{term}/edit` | `_entity_access: config_terms_term.update` |
| `entity.config_terms_term.delete_form` | `/config-terms/term/{term}/delete` | `_entity_access: config_terms_term.delete` |

The overview form (`Form\OverviewTerms`) is a tabledrag tree of a vocab's terms (weight + parent
reordering), paged by `config_terms.settings:terms_per_page_admin`, with a "Reset to alphabetical"
action that routes to `VocabResetForm` → `TermStorage::resetWeights()`.

## Storage handler public methods

`VocabStorage` (`\Drupal::entityTypeManager()->getStorage('config_terms_vocab')`):
- `getToplevelTids(array $vids)` — term IDs whose `parents === ['0']` across the given vocabs.
- `getVocabsList()` — `[vid => label]`, sorted by weight then label.

`TermStorage` (`getStorage('config_terms_term')`), implementing `TermStorageInterface`:
- `loadTree($vid, $parent = '0', $max_depth = NULL)` — flat, depth-annotated array of term objects.
- `loadChildren($tid, $vid = NULL)` / `loadParents($tid)` — direct relatives.
- `getTermOptions($vid)` — `[tid => '--label']` (dashes denote depth), for `#options`.
- `resetWeights($vid)` — zero every term weight (alphabetical reset).

Config entities cannot multi-sort in an entity query, so ordering (weight, then name) is done in
PHP inside these methods.

## Procedural helpers in `config_terms.module`

- `config_terms_vocab_get_names()` — list of vocab IDs.
- `config_terms_term_load_multiple_by_name($name, $vocab = NULL)` — case-trimmed name lookup.
- `config_terms_implode_tags($tags, $vid = NULL)` — encode term labels to a tag string.
- `config_terms_check_vocab_hierarchy($vocab, $changed_term)` — recompute + persist a vocab's hierarchy.
- `config_terms_terms_static_reset()` / `config_terms_vocab_static_reset($ids)` — clear entity caches.

## Creating entities in PHP

```php
$vocab = \Drupal::entityTypeManager()->getStorage('config_terms_vocab')->create([
  'id' => 'document_type',
  'label' => 'Document type',
]);
$vocab->save();

$term = \Drupal::entityTypeManager()->getStorage('config_terms_term')->create([
  'id' => 'invoice',
  'vid' => 'document_type',
  'label' => 'Invoice',
  'parents' => ['0'],
]);
$term->save();
```
