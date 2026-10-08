# Revisions & route/task providers

## Revisionable base
Extend `Drupal\entity\Revision\RevisionableContentEntityBase` instead of core's version — it
fixes revision URL route parameters (adds `{entity_type}_revision`) so revision links resolve.

## Route providers (entity annotation `handlers.route_provider`)
- `DefaultHtmlRouteProvider` — canonical, add-page/add-form, edit, delete, collection routes
  from the entity's link templates, plus a **duplicate** route.
- `AdminHtmlRouteProvider` — same, but renders create/edit/delete forms on the **admin theme**.
- `RevisionRouteProvider` — `version-history`, `revision`, `revision-revert`,
  `revision-delete` routes (respects the `_entity_access_revision` check).
- `DeleteMultipleRouteProvider` — a `/delete-multiple` bulk delete confirmation route.

## Revision UI pieces
- `RevisionOverviewController` — the version-history table.
- `RevisionRevertForm` / core delete form — revert or delete a single revision.
- `RevisionableContentEntityForm` — entity form with a "Create new revision" checkbox + log.
- Views fields `entity_link_revision`, `entity_link_revision_revert`.

## Menu providers
- `DefaultEntityLocalTaskProvider` — generates local task tabs (View/Edit/Delete/Revisions).
- `EntityCollectionLocalActionProvider` — generates the "Add" local action on collections.
- Wired through `entity.links.task.yml` / `entity.links.action.yml` derivers.

## Revision access on custom routes
Add `_entity_access_revision: 'entity.view revision'` (etc.) to a route requirement — served
by the `access_checker.entity_revision` service.
