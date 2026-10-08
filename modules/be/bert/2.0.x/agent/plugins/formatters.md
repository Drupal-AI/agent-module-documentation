<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# bert formatter plugin types

BERT defines **two** annotation-based plugin types, each with a manager service, a base class, an
interface, and an alter hook. Both discover plugins under `Plugin/bert/…` in any module.

## 1. List formatters — table cells

- Manager: `plugin.manager.entity_reference_list_formatter`
  (`src/EntityReferenceListFormatterManager.php`, extends `DefaultPluginManager`).
- Subdir `Plugin/bert/EntityReferenceListFormatter`, annotation
  `@EntityReferenceListFormatter(id, label)` (`src/Annotation/EntityReferenceListFormatter.php`),
  alter info `bert_entity_reference_list_formatter`.
- Interface `EntityReferenceListFormatterInterface`: `getCells(EntityInterface $entity): array`
  (row cells) and `getHeader(): array` (header cells).
- Base `EntityReferenceListFormatterPluginBase` (implements `ContainerFactoryPluginInterface`):
  injects `entity.repository`, default `getHeader()` = `[]`, plus `setParentEntity()` /
  `getParentEntity()` — the widget calls `setParentEntity($parent)` before rendering.

Built-ins (`src/Plugin/bert/EntityReferenceListFormatter/`):

| id | Label | Cells |
|---|---|---|
| `title` | Entity title | `#markup` label; header "Title". |
| `title_bundle` | Entity title and bundle | label + bundle label; headers "Title"/"Type". |
| `title_publishing` | Entity title and publishing status | label + Published/Unpublished; throws if the entity isn't `EntityPublishedInterface`. |
| `title_with_edit_link` | Entity title (with edit link) | label as a `#type => link` to the entity's `edit-form` (`target=_blank rel=noreferrer noopener`); falls back to markup if no edit link. |
| `title_bundle_with_edit_link` | Entity title and bundle (with edit link) | as above + bundle cell. |

All resolve the translation via `entityRepository->getTranslationFromContext($entity)` first.

## 2. Label formatters — search-result labels

- Manager: `plugin.manager.entity_reference_label_formatter`
  (`src/EntityReferenceLabelFormatterManager.php`).
- Subdir `Plugin/bert/EntityReferenceLabelFormatter`, annotation
  `@EntityReferenceLabelFormatter(id, label)`, alter info
  `bert_entity_reference_label_formatter`.
- Interface `EntityReferenceLabelFormatterInterface`: `getLabel(EntityInterface $entity): string`.
- Base `EntityReferenceLabelFormatterPluginBase` (injects `entity.repository`, parent-entity
  accessors).
- Used by `BertSelection::createOptions()`, which wraps the returned string in `Html::escape()`.

Built-ins (`src/Plugin/bert/EntityReferenceLabelFormatter/`): `title` (Entity title) and
`title_bundle` (Entity title and bundle → `"label (bundle)"`).

## Adding your own

Drop a class in `your_module/src/Plugin/bert/EntityReferenceListFormatter/Foo.php` (or the label
variant) extending the matching base and carrying the annotation. It appears in the widget's *List
formatter plugin* select (or the handler's *Label formatter plugin* select) automatically.

## Alter hooks (`bert.api.php`)

- `hook_bert_entity_reference_list_formatter_alter(array &$definitions)` — e.g. swap a built-in's
  `['title_bundle']['class']` for your own subclass.
- `hook_bert_entity_reference_label_formatter_alter(array &$definitions)` — same for label
  formatters.

Definitions are cached under keys `bert_entity_reference_list_formatter` /
`bert_entity_reference_label_formatter`; clear caches after adding plugins.
