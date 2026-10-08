<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk-edit redirects (status code and destination)

Redirect's core admin UI edits one redirect at a time. This module adds two Views Bulk
Operations (VBO) actions plus two confirm forms so an operator can change the HTTP status
code, or the destination, of a whole selection of redirects in one submit.

There is **no settings form**. The feature is operated entirely from the redirect listing
(the `url_redirects` View page at `/admin/config/search/redirect`, which carries a
`redirect_bulk_form`). Everything below is gated by the **`administer redirects`**
permission (route requirement) and each action additionally checks per-entity `edit`
access.

## Workflow

1. On the redirect list, tick some redirects and pick one of the two bulk actions.
2. The action's `executeMultiple()` stashes the selected redirect **entities** in the
   current user's private tempstore, then core redirects to the action's
   `confirm_form_route_name`.
3. The confirm form reads them back from tempstore, asks for the new value, and on submit
   writes + saves each redirect. If the tempstore is empty the form bounces back to
   `redirect.list`.

## The two actions

| Action config id | Plugin class | Label | Confirm route | Tempstore collection |
|---|---|---|---|---|
| `redirect_status_action` | `Plugin\Action\EditStatusRedirect` | "Bulk edit redirect type (301, 302, etc.,)" | `entity.redirect.edit_status_code` | `redirect_edit_status_code` |
| `redirect_dest_action` | `Plugin\Action\EditDestRedirect` | "Bulk edit redirect destination (To URL)" | `entity.redirect.edit_dest` | `redirect_edit_dest` |

Both are `@Action(type = "redirect")`, both are installed as `system.action.*` config
(`config/install/`, `dependencies.enforced.module: redirect_extensions`), and both gate
each item with `access($object) => $object->access('edit', $account, …)`.

## The two forms

| Route | Path | Form class | Form id |
|---|---|---|---|
| `entity.redirect.edit_status_code` | `/admin/config/search/redirect/edit/status` | `Form\RedirectEditStatusForm` | `redirect_edit_status_code` |
| `entity.redirect.edit_dest` | `/admin/config/search/redirect/edit/dest` | `Form\RedirectEditDestForm` | `redirect_edit_dest` |

These are standard Drupal `FormBase` forms reached only via POST submit (CSRF-token
protected); a bare GET to the path just rebuilds the form or bounces to `redirect.list`.

**Status form** (`RedirectEditStatusForm`) — a `select` of status codes
`300, 301, 302, 303, 304, 305, 307`; default is Redirect's own
`redirect.settings:default_status_code`. On submit it calls `$redirect->setStatusCode($code)`
then `$redirect->save()` for each, logs to the `redirect` channel, and shows a plural
"Updated N redirects." message.

**Destination form** (`RedirectEditDestForm`) — a required `textfield` `dest`
(`#maxlength 560`) taking an internal path, alias, `<front>`, or a full external URL.
`validateForm()` rejects a destination whose resolved URL equals a selected redirect's own
source (self-redirect / infinite loop). On submit, for each redirect: if
`UrlHelper::isExternal($dest)` it sets the `redirect_redirect` field item 0 directly
(documented workaround for drupal.org/node/2845884), otherwise `$redirect->setRedirect($dest)`;
then `$redirect->save()`. Same log + message as above.

## Notes for integrators

- Redirect entities are read/written; only redirects the operator can `edit` are touched.
- The new value is applied identically to every selected redirect (one status, or one
  destination) — there is no per-row value and no undo through the UI.
- The confirm forms rely on the same tempstore collection names the actions write to, keyed
  by the current user id; a stale/empty store just returns the user to the list.
