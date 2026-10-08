<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter: "Rendered entity with context"

Class `EntityReferenceRevisionsEntityContextFormatter`
(`src/Plugin/Field/FieldFormatter/EntityReferenceRevisionsEntityContextFormatter.php`).

- Plugin id: **`entity_reference_revisions_entity_view_context`**
- Label: *"Rendered entity with context"*
- Applies to field type: **`entity_reference_revisions`** only
- Extends: `Drupal\entity_reference_revisions\Plugin\Field\FieldFormatter\EntityReferenceRevisionsEntityFormatter`
  (the ERR module's own "Rendered entity" formatter) and implements `ContainerFactoryPluginInterface`.

## Install / enable

1. `composer require drupal/entity_reference_revisions_context`
2. `drush en entity_reference_revisions_context` (pulls in `entity_reference_revisions`).
3. On the host bundle's **Manage display** (e.g. a content type with a Paragraphs field), set the ERR
   field's **Format** to **"Rendered entity with context"** and pick a view mode in the format settings.

There is no settings form, config object, or schema added by this module. The format-settings row shows
whatever the parent ERR formatter exposes (the referenced view mode). It provides no permissions and no
routes.

## What it renders

`viewElements(FieldItemListInterface $items, $langcode)`:

1. `$elements = parent::viewElements($items, $langcode);` — the ERR core formatter builds the render
   array, honoring the referenced entities' own view access (via `getEntitiesToView()`) and the selected
   view mode. This module does **not** re-query, re-load, or bypass any access check.
2. For each `$delta`, it calls `addPreviousElementContext()`, `addNextElementContext()`,
   `addPositionContext()`, which mutate `$elements[$delta]['#attributes']`.

`findElementBundle($elements, $delta)` resolves an item's bundle from
`$elements[$delta]['#' . $this->getFieldSetting('target_type')]->bundle()` (e.g. `#paragraph`), returning
`FALSE` when the delta does not exist (i.e. before the first or after the last item).

## Attributes emitted (on each item's `#attributes`)

| Attribute | Set by | Meaning |
|---|---|---|
| `data-entity-context-first` = `TRUE` | `addPreviousElementContext()` | No previous item exists (delta-1 missing). |
| `data-entity-context-prev` = `{bundle}` | `addPreviousElementContext()` | Bundle of the previous item (delta-1). |
| `data-entity-context-last` = `TRUE` | `addNextElementContext()` | No next item exists (delta+1 missing). |
| `data-entity-context-next` = `{bundle}` | `addNextElementContext()` | Bundle of the next item (delta+1). |
| `data-entity-context-group` = `{n}` | `addGroupElementContext()` | Increments each time the current bundle differs from the previous item's bundle, so runs of the same bundle share a number. |
| `data-entity-context-position` = `{delta+1}` | `addPositionContext()` | 1-based position in the list. |
| `data-entity-context-odd` = `TRUE` | `addPositionContext()` | Position is odd. |
| `data-entity-context-even` = `TRUE` | `addPositionContext()` | Position is even. |

`addGroupElementContext()` compares `$previous_bundle` (passed in) with the current item's bundle and
increments a `static $entity_group` counter when they differ; the first item (no previous bundle) starts
the first group. Attribute values are entity **bundle machine names** and **integers/booleans** — they
flow through Drupal's `#attributes` rendering (escaped), not raw markup.

## Notes

- This is a drop-in alternative to the ERR "Rendered entity" formatter; everything about how the
  referenced revision itself renders (view mode, access, links) is inherited unchanged.
- The attributes are consumed by your theme's CSS/JS; the module ships none. Typical uses: first/last
  spacing, odd/even striping, adjacency-aware styling via prev/next bundle, and grouping consecutive
  same-bundle paragraphs via the group number.
