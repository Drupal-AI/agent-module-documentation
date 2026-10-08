<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, links & permissions

The module ships **no `event.routing.yml`**. Content-entity routes are generated from the `event`
entity's `links` templates by the custom route provider
`Drupal\event\EventHtmlRouteProvider` (extends core `AdminHtmlRouteProvider`); `event_type` routes
come from core `DefaultHtmlRouteProvider`.

## `event` link templates → routes

| Link / route | Path |
|--------------|------|
| `entity.event.add_page` | `/event/add` |
| `entity.event.add_form` | `/event/add/{event_type}` |
| `entity.event.canonical` | `/event/{event}` |
| `entity.event.collection` | `/admin/content/events` |
| `entity.event.edit_form` | `/event/{event}/edit` |
| `entity.event.delete_form` | `/event/{event}/delete` |
| `entity.event.version_history` | `/event/{event}/revisions` |
| `entity.event.revision` | `/event/{event}/revisions/{event_revision}/view` |
| `entity.event.revision_revert` | `/event/{event}/revisions/{event_revision}/revert` |
| `entity.event.revision_delete` | `/event/{event}/revisions/{event_revision}/delete` |
| `entity.event.translation_revert` | `/event/{event}/revisions/{event_revision}/revert/{langcode}` |

CRUD routes (canonical/edit/delete/add) are gated by entity access via
`EventAccessControlHandler` (see [entities/event.md](../entities/event.md)). `Event::urlRouteParameters()`
injects the `{event_revision}` parameter for the revert/delete revision links.

### Revision routes (added by `EventHtmlRouteProvider::getRoutes()`)

| Route | Handler | `_permission` requirement |
|-------|---------|---------------------------|
| version_history | `EventController::revisionOverview` | `access event revisions` |
| revision (view) | `EventController::revisionShow` | `access event revisions` |
| revision_revert | `EventRevisionRevertForm` | `revert all event revisions` |
| revision_delete | `EventRevisionDeleteForm` | `delete all event revisions` |
| revision_revert_translation | `EventRevisionRevertTranslationForm` | `revert all event revisions` |

**Accuracy caveat:** the version-history and single-revision routes require a permission named
`access event revisions`, but `event.permissions.yml` does **not** define that permission (it
defines `view all event revisions`). Because the requirement names a non-existent permission, these
two routes fail closed — only user 1 (who bypasses access checks) can reach them. Grant/rename would
require a code fix. The revert/delete revision permissions exist and work.

`getSettingsFormRoute()` in the provider only adds an `event.settings` route when the entity type
has **no** bundle entity type; `event` has `event_type`, so **no settings route is generated** and
`EventSettingsForm` (a placeholder form printing static markup) is effectively unrouted. `data.json`
`configure` is therefore `null`.

## `event_type` routes (core provider)

`/admin/structure/event` (collection), `/admin/structure/event/add`,
`/admin/structure/event/manage/{event_type}/edit`, `.../delete`. `admin_permission` is
`administer site configuration`.

## Menu / task / action links

- `event.links.menu.yml`: "Event types" under `system.admin_structure`; an "Event" add link; and
  a derived menu-links block (`event.menu_links`) via the `MenuLinks` deriver — the deriver only
  emits toolbar links when the `admin_toolbar` module is installed, adding "Add event type",
  "Events", "Add event", and one link per event type.
- `event.links.task.yml`: local tabs on the canonical route (View / Edit / Revisions / Delete) and
  an "Events" tab under `system.admin_content`.
- `event.links.action.yml`: "Add Event type" (on the type collection) and "Add Event" (on the
  event collection).

## Permissions (`event.permissions.yml`)

`add event entities`, `administer event entities` (`restrict access: true`),
`delete event entities`, `edit event entities`, `view published event entities`,
`view unpublished event entities`, `view all event revisions`, `revert all event revisions`,
`delete all event revisions`.

## Views

`config/optional/views.view.events_admin.yml` ships an example admin events listing view
(`events_admin`) with a page display at `admin/content/events` (fields: name, type, author, status,
changed date, plus entity operations; exposed name/type/status/language/created filters). It is
imported on install when its dependencies are met. `EventViewsData` (`src/Entity/EventViewsData.php`)
supplies the Views integration for the `event` tables.
