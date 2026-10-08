<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Rendered Entity Ajax Formatter"

## Install & enable

```bash
composer require drupal/entity_reference_ajax_formatter
drush en entity_reference_ajax_formatter -y
```

No dependencies beyond Drupal core. No sub-modules, no permissions of its own, no Drush commands.

## Enable it on a field

Plugin id **`entity_reference_ajax_entity_view`**, label *"Rendered Entity Ajax Formatter"*. Applies
to **`entity_reference`** and **`entity_reference_revisions`** fields
(`@FieldFormatter` annotation in `EntityReferenceAjaxFormatter.php`).

UI path: *Structure → (bundle) → Manage display* → set the reference field's format to **Rendered
Entity Ajax Formatter** → click the gear to set the options below. Example for an article node
entity-reference field: `/admin/structure/types/manage/article/display`.

Config / Drush equivalent (view display component `settings`):

```yaml
# core.entity_view_display.node.article.default
content:
  field_related:
    type: entity_reference_ajax_entity_view
    label: hidden
    settings:
      view_mode: teaser   # inherited from the core rendered-entity formatter
      link: false         # inherited
      number: 3
      sort: 0
      load_more: true
      max: 12
```

## Formatter settings

From `defaultSettings()` (merged over the parent `EntityReferenceEntityFormatter` defaults):

| Setting key | Default | Meaning |
|---|---|---|
| `number` | `6` | How many referenced entities to render in the initial output (and per Load-More batch). Required. |
| `sort` | `0` | Display-only ordering (does not change stored order). See the sort table below. |
| `load_more` | `FALSE` | Append an AJAX "Load More" link that fetches the next batch and swaps it inline. |
| `max` | `0` | Hard cap on total entities loadable via Load More. `0` = unlimited (all references). Only relevant/visible when `load_more` is on. |
| `view_mode` | (parent) | View mode used to render each referenced entity (inherited from core). |
| `link` | (parent) | Inherited "Link label to the referenced entity" toggle. |

`sort` values (index into the option list in `settingsForm()` / `settingsSummary()` / the `switch`
in `viewElements()`):

| Value | Order |
|---|---|
| `0` | Field default order (no reordering) |
| `1` | Random (`shuffle()`; uses `printed` de-dupe so Load-More batches don't repeat) |
| `2` | Date Modified ascending (`getChangedTime()` `usort`) |
| `3` | Date Modified descending |
| `4` | Date Created ascending (`getCreatedTime()` `usort`) |
| `5` | Date Created descending |

Entities lacking `getChangedTime()`/`getCreatedTime()` are left in their existing relative order
(the comparators return `0`).

### The `max` validator

`settingsMaxValidate()` (an `#element_validate` on the `max` element) requires that, when
`load_more` is enabled and `max` is non-zero, `max` be **greater than** `number` — otherwise it sets
a form error ("Max must be greater than the initial load number… You can set to 0 [for] no limit").
`max = 0` always passes (unlimited).

`settingsSummary()` adds lines to the Manage-display summary: "Loading N", the chosen sort label,
and (when Load More is on) "Load more button enabled" plus "Maximum entities to load: N".

## How rendering works (`viewElements()`)

1. Reads the current-route parameters `start` (offset, default `0`) and `printed` (a `-`-joined
   list of already-shown entity ids, used only for random sort de-duplication).
2. Calls the parent `getEntitiesToView($items, $langcode)` — so **core's referenced-entity view
   access filtering applies** to the reference targets — then reorders that array per `sort`.
3. Iterates the entities, skipping until `start` (or, for random sort, skipping ids already in
   `printed`), stops once `number` elements are built or the `max`/`start` bound is hit, and renders
   each via `entityTypeManager->getViewBuilder(...)->view($entity, $view_mode, …)`. Core's
   recursive-render protection (`RECURSIVE_RENDER_LIMIT`, inherited) is enforced.
4. When `load_more` is set and `count($items) > number + start` and `max` is not yet reached, it
   appends a container (`id = ajax-field-{target_entity_type}-{host_entity_id}-{field_name}`,
   classes `text-align-center ajax-field-entity-ref`) holding a `#type => 'link'` titled
   "Load More" with class `use-ajax`, pointing at route
   `entity_reference_ajax_formatter.ajax_field` with the next `start`, the accumulated `printed`,
   and the field's `view_mode`/`langcode`. It attaches `core/drupal.ajax`.

The AJAX endpoint that answers that link is documented in
[../api/ajax-endpoint.md](../api/ajax-endpoint.md).

## Notes

- The formatter's constructor sets the field `label` to `hidden` when the current route is the ajax
  route, so the re-rendered batch doesn't repeat the field label.
- Config schema exists only for the **formatter settings**
  (`field.formatter.settings.entity_reference_ajax_entity_view` in `config/schema/`); there is no
  site-wide settings form and no `config/install`.
