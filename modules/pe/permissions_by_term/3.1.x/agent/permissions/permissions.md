<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions by Term permissions

`permissions_by_term.permissions.yml` — four, all `restrict access: true`:

| Permission | Gates |
|---|---|
| `show term permission form on term page` | The editable *Permissions* fieldset (allowed users + allowed roles) on the taxonomy **term** edit form. Without it the fieldset is not built at all, so the grants cannot be changed through the UI. |
| `show term permissions on node edit page` | The read-only "Permissions by Term" panel in the node form's advanced sidebar, and the two info controllers `permissions_by_term.access_info_by_content_type` (`/admin/permissions-by-term/access-info-by-content-type/{nodeType}`) and `permissions_by_term.access_info_by_url` (`/admin/permissions-by-term/access-info-by-url`). |
| `show term permissions on user edit page` | The *Permissions → Vocabularies* term selector on the **user** edit form (also requires the `show_terms_in_user_form` setting). |
| `access pbt settings` | The settings form at `/admin/permissions-by-term/settings` (the module's `configure` route). |

The autocomplete route `permissions_by_term.autocomplete_multiple`
(`/permissions-by-term/autocomplete`) uses the core permission `access user profiles`.

```bash
drush role:perm:add editor 'show term permission form on term page'
drush role:perm:add editor 'show term permissions on node edit page'
drush config:get user.role.editor permissions
```

## Core permissions that change behaviour

- **`bypass node access`** — such users always pass `AccessCheck::canUserAccessByNode()`, and
  every role holding it is **auto-added** by `AccessStorage::addTermPermissionsByRoleIds()`
  whenever any role grant is written for a term.
- **`view own unpublished content` / `view any unpublished content`** — checked before the term
  logic for unpublished nodes.
- **`administer permissions`** — `hook_user_update()` only invalidates the module's caches when
  the acting user holds it.
