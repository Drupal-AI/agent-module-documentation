# Mechanics & extension points

The module has no config and no API to call — it works by swapping Core handlers/plugins
at build time. Enabling or disabling it turns the extended permission checks on/off with no
data or field changes. Everything below lives in `taxonomy_access_fix.module` + `src/`.

## What it replaces (`hook_entity_type_alter`)

- `taxonomy_term` **access** handler → `TermAccessControlHandler`
  (extends Core `TermAccessControlHandler`). Adds a per-bundle `view label` operation and a
  `select` operation; maps `view`/`select`/`view label`/`update`/`delete` to the module
  permissions (see permissions doc). `viewLabelOperation = TRUE`.
- `taxonomy_vocabulary` **access** handler → `VocabularyAccessControlHandler`. Handles
  `reorder_terms`, `reset all weights`, `view label`, and augments `view` /
  `access taxonomy overview` so overview access = Core create-term access OR any
  edit/delete/reorder/reset permission for the vocabulary.
- `taxonomy_vocabulary` **list_builder** → `VocabularyListBuilder`: hides vocabularies the
  user cannot `view`, and removes weight/sorting UI for non-`administer taxonomy` users.
- `taxonomy_vocabulary` **reset form** class → `VocabularyResetForm`: if the cancel URL
  (overview page) is inaccessible, redirects to `<front>` instead. Supply a `destination`
  query param to override.

**Guard:** if the existing access handler is NOT Core's expected class (i.e. another module
already replaced it), the alter throws `LogicException` rather than risk wrong access
results. Same guard applies to the selection plugin below.

## Entity reference selection (`hook_entity_reference_selection_alter`)

Replaces the `default:taxonomy_term` selection plugin **class** with `TermSelection`
(extends Core's) — not a new plugin — so no field reconfiguration is needed. It:
- Filters `getReferenceableEntities()` by the `select` term operation (and prunes children
  of unselectable parents).
- Rewrites the entity query in `entityQueryAlter()`: removes Core's hard `status = 1`
  condition and rebuilds per-vocabulary published/unpublished conditions from
  `select terms in <vid>` / `select unpublished terms in <vid>` / `select any (unpublished)
  term`. Users with `administer taxonomy` are detected by the presence of the status
  condition and left untouched.
- Re-validates newly typed/auto-created terms against the `select` operation on submit.

## Term-overview form alter (`hook_form_taxonomy_overview_terms_alter`)

For non-`administer taxonomy` users: removes the weight column / tabledrag / Save button
unless they can reorder, and injects a "Reset to alphabetical" link when they can reset
(Core would otherwise only show it to users with term-update permission).

## Reset-form route (`RouteSubscriber`, event subscriber)

`entity.taxonomy_vocabulary.reset_form` route: on Drupal 10.1+ Core already uses
`_entity_access: taxonomy_vocabulary.reset all weights` (left as-is). On Drupal 10.0/9 it
rewrites the route's `_permission: administer taxonomy` requirement to that entity-access
check — throwing `LogicException` if the requirement is unexpected.

## Drupal 7 migration (`hook_migrate_prepare_row`)

During a `d7_user_role` migration, for every source `add terms in <vocab>` permission it
adds `reorder terms in <vocab>`, `view terms in <vocab>` and
`view unpublished terms in <vocab>` so D7 term-adders keep equivalent access.

## Overriding it

There is no service to decorate. To change behavior, subclass the relevant handler and set
it in your own `hook_entity_type_alter` (running after this module) — but note the
`LogicException` guards expect Core's classes, so a second replacement must be coordinated.
