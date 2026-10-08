<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The blocklist admin UI (asm_ui)

## Enable

`ddev drush en asm_ui -y` (pulls in `asm`). No config to import; the UI is wired at runtime.

## How the routes exist

asm_ui defines **no** `*.routing.yml`. Instead `asm_ui_entity_type_alter()` (in `asm_ui.module`)
mutates the `asm_email_blocked` entity type to add the handlers and link templates. Drupal then
auto-generates the CRUD routes from those link templates via the assigned route provider
`EmailBlockedHtmlRouteProvider` (extends core `AdminHtmlRouteProvider`).

Generated routes and their paths:

| Route | Path | Form / handler |
| --- | --- | --- |
| `entity.asm_email_blocked.collection` | `/admin/config/people/mail-blocked` | list builder |
| `entity.asm_email_blocked.add_form` | `/admin/config/people/mail-blocked/add` | `EmailBlockedForm` |
| `entity.asm_email_blocked.canonical` / `.edit_form` | `/admin/config/people/mail-blocked/{asm_email_blocked}` | `EmailBlockedForm` (canonical is overridden to the edit form) |
| `entity.asm_email_blocked.delete_form` | `/admin/config/people/mail-blocked/{asm_email_blocked}/delete` | core `ContentEntityDeleteForm` |

`EmailBlockedHtmlRouteProvider::getCanonicalRoute()` returns `getEditFormRoute()`, so visiting an
entity's canonical URL lands on its edit form (there is no separate read-only view page).

## Access

All routes come from `AdminHtmlRouteProvider`, which applies `_entity_access` requirements
(`asm_email_blocked.view` / `.create` / `.update` / `.delete`). The entity type declares no custom
access handler, so the default content-entity access handler resolves those to the entity's
`admin_permission = "administer asm email blocked"` (defined in `asm.permissions.yml`,
`restrict access: true`). Net effect: **all** blocklist pages require that one restricted
permission. asm_ui itself declares no permission.

## Menu / action links

- `asm_ui.links.menu.yml`: `entity.asm_email_blocked.collection` → title "Emails Blocked",
  parent `user.admin_index` (the People admin index), weight 10.
- `asm_ui.links.action.yml`: "Add email" action link on the collection, pointing at
  `entity.asm_email_blocked.add_form`.

## List builder — `EmailBlockedListBuilder`

Extends `EntityListBuilder`. Header: **ID, Mail, Reason, Created**. `buildRow()` renders the
`reason` field (label hidden) and formats `created` via the injected `date.formatter` service
(`createInstance()` injects `date.formatter` alongside the entity storage). `render()` wraps the
parent table and appends a `#markup` line "Total emails blocked: @total" computed from
`getStorage()->getQuery()->accessCheck(FALSE)->count()->execute()` — a display-only count on an
already admin-gated page.

## Add/edit form — `EmailBlockedForm`

Extends core `ContentEntityForm` (so the `email` + `reason` widgets, validation, and CSRF token
come from core). `save()`:
- on `SAVED_NEW`: status "New email blocked %label has been created." + notice to the `asm`
  logger channel;
- on `SAVED_UPDATED`: status "The email blocked %label has been updated." + notice;
- then `$form_state->setRedirect('entity.asm_email_blocked.collection')`.

The `email` field's `UniqueField` constraint (from the entity) rejects a duplicate address at
validation time. Delete uses the unmodified core `ContentEntityDeleteForm` (a confirm form with
CSRF), so removals are not one-click GETs.
