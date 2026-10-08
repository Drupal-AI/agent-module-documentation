<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trash bin listing, forms, actions & integrations

## The trash listing

`Drupal\trash\Controller\TrashController::listing()` renders `/admin/content/trash` and
`/admin/content/trash/{entity_type_id}`. It defaults to `node` (or the first enabled type),
404s when no type is enabled or the requested type is not enabled, and shows an auto-purge
countdown message when auto-purge is on. For each enabled type it renders either a dynamically
built View (when the type has a `views_data` handler — via `TrashViewBuilder`, reusing a saved
`trash_<type>` view if one was exported) or a fallback `#type => table`. Rows expose per-entity
restore/purge operation links; the fallback loader uses an entity query with `accessCheck(TRUE)`
and `->exists('deleted')`.

![Trash bin listing](../../../../../../../screenshots/trash/3.1.x/trash-listing.png)

## Confirmation forms

- Single: `EntityRestoreForm` / `EntityPurgeForm` (`ContentEntityConfirmFormBase`,
  `WorkspaceSafeFormInterface`), reached via the entity's `restore` / `purge` link templates
  and the routes added by `Routing\RouteSubscriber` (`_entity_access` requirement). They handle
  translations (offering access-filtered "other translations to also restore", re-checked on
  submit) and call the type's handler `restoreFormAlter()` / `purgeFormAlter()`.
- Bulk: `EntityRestoreMultipleForm` / `EntityPurgeMultipleForm` (`ConfirmFormBase`) read the
  selection from `PrivateTempStore` keyed by the current user + entity type, drop entities that
  were purged meanwhile, and re-check `access('restore'|'purge')` per entity/translation in
  `submitForm()`.

## Bulk actions

`entity:restore_action` (`RestoreAction`) and `entity:purge_action` (`PurgeAction`) extend
core `DeleteAction`, one derivative per enabled type (`TrashRestoreActionDeriver` /
`TrashPurgeActionDeriver`). Each overrides `access()` to check the `restore` / `purge`
operation and routes to the matching multiple-confirm form via its tempstore. Action config
entities are created for enabled types by `trash_post_update_create_trash_actions()`.

## Other plugins

- Views field `trash_operations` (`Plugin/views/field/TrashOperations`, extends
  `EntityOperations`) — the operations column in the generated trash views.
- Field formatter `trash_label` (`Plugin/Field/FieldFormatter/TrashLabelFormatter`, extends
  core `StringFormatter`) — a label formatter with a `show_entity_id` setting used in trash
  listings.
- Search: `Plugin/Search/TrashNodeSearch` (extends core `NodeSearch`) and search_api processor
  `Plugin/search_api/processor/TrashStatus` — keep trashed content out of search results.
- Queue worker `trash_entity_purge` — see [configure/settings.md](../configure/settings.md).
- Local-task derivative `TrashLocalTasks` — adds the per-type Trash tab and the Restore/Purge
  operation tabs on entities.
