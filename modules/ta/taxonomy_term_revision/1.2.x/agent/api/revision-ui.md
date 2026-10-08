<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revision UI: routes, controller, forms

The module adds a **Revisions** local task to every taxonomy term
(`taxonomy_term_revision.links.task.yml` → `entity.taxonomy_term.revisions`, base route
`entity.taxonomy_term.canonical`) and four routes that back it. All routes constrain
`{taxonomy_term}` and `{id}`/`{revision_id}` to `\d+` and load `{taxonomy_term}` as an
`entity:taxonomy_term` parameter.

## Routes (`taxonomy_term_revision.routing.yml`)

| Route name | Path | Backing | Access requirement |
|---|---|---|---|
| `taxonomy_term_revision.all` | `/taxonomy/term/{taxonomy_term}/revisions` | `TermRevisionController::getRevisions` | `_permission: view term revision list` |
| `taxonomy_term_revision.view` | `/taxonomy/term/{taxonomy_term}/revision/{revision_id}` | `TermRevisionController::revisionShow` (title `revisionPageTitle`) | `_entity_access: taxonomy_term.view` |
| `taxonomy_term_revision.revert` | `/taxonomy/term/{taxonomy_term}/revisions/revert/{id}` | `TermRevisionRevertForm` | `_permission: revert term revision` |
| `taxonomy_term_revision.delete` | `/taxonomy/term/{taxonomy_term}/revisions/delete/{id}` | `TermRevisionDeleteForm` | `_permission: delete term revision` |

`all`, `revert`, `delete` set `_admin_route: TRUE`.

## Controller — `TermRevisionController` (extends `ControllerBase`)

Service deps (`create()`): `database`, user storage, `taxonomy_term` storage, `entity.repository`,
`taxonomy_term` view builder, `date.formatter`.

- **`getRevisions(RouteMatchInterface)`** — renders a `#type: table` (header CHANGED / USER /
  OPERATIONS / LOG MESSAGE). Reads directly from the DB via `fetchTaxonomyRevisionData()`:
  `SELECT revision_id, revision_created, revision_default, revision_user, revision_log_message
  FROM {taxonomy_term_revision} WHERE tid = :tid ORDER BY revision_id DESC`. For the default
  revision the row shows "Current Revision"; other rows link the date to
  `taxonomy_term_revision.view` and render `Revert | Delete` operation links **only for users
  holding `revert term revision` / `delete term revision`** respectively (per-row permission check
  via `currentUser()->hasPermission()`). Returns `{'#markup': 'No revisions available'}` if the term
  is not a `TermInterface`, the `taxonomy_term_revision` table is absent, or there are no rows.
- **`revisionShow(RouteMatchInterface)`** — `loadRevision($revision_id)`, resolves the contextual
  translation via `entity.repository`, and returns the term view builder's render array (with
  `#cache` unset). Uses the `taxonomy_term.full` view mode (`_entity_view` default).
- **`revisionPageTitle(RouteMatchInterface)`** — title callback: the loaded revision's `getName()`,
  `#allowed_tags` limited to `Xss::getHtmlTagList()`.

## Revert form — `TermRevisionRevertForm` (`ConfirmFormBase`)

Form id `term_revision_revert_form`. Deps: `database`, `logger.factory`, `datetime.time`,
`entity_type.manager`, `current_user`, `date.formatter`. `buildForm(...$taxonomy_term, $id)` stores
the revision id and term id. `submitForm()` loads `taxonomy_term` storage `loadRevision($id)`, sets a
log message `"Copy of the revision from <formatted date>"`, stamps current user + request time +
changed time, then `setNewRevision()`, `isDefaultRevision(TRUE)`, `save()` — i.e. it re-saves the old
revision as a **new current** revision (non-destructive rollback). Logs
`taxonomy_term_revision` info `Term reverted tid %tid revision_id %trid`, shows a status message, and
redirects (raw `RedirectResponse`) to `taxonomy_term_revision.all`. Question: "Do you want to revert
to this revision?"; cancel URL → the revisions list.

## Delete form — `TermRevisionDeleteForm` (`ConfirmFormBase`)

Form id `term_revision_delete_form`. Deps: `database`, `logger.factory`, `entity_type.manager`.
`submitForm()` calls `taxonomy_term` storage `deleteRevision($id)`, verifies the revision is gone
(`loadRevision($id) == NULL`), logs `Term revision deleted tid %tid revision_id %trid`, messages, and
redirects to `taxonomy_term_revision.all`. Question: "Do you want to delete this revision?".

## Operating it

- List a term's revisions: visit `/taxonomy/term/{tid}/revisions` (needs `view term revision list`).
- Revert: `/taxonomy/term/{tid}/revisions/revert/{revision_id}` (needs `revert term revision`).
- Delete: `/taxonomy/term/{tid}/revisions/delete/{revision_id}` (needs `delete term revision`).
- Count stored revisions: `drush sqlq "SELECT COUNT(*) FROM taxonomy_term_field_revision"`.
