<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM permissions & access

CRM combines standard entity permissions, dynamically-generated per-bundle permissions, a
"mapped contact" path, and a node_access-style per-contact grant table.

## Permissions (`crm.permissions.yml` + callbacks)
Static permissions:
- `administer crm` (restricted) — the admin permission on every CRM entity type; bypasses all
  per-operation checks.
- `access crm` — reach the `/crm` portal and the contact collection (`collection_permission`).
- Contact: `create any crm contact`, `view any crm contact`, `view any crm contact label`,
  `edit any crm contact`, `delete any crm contact`, and revision perms
  (`view all crm contact revisions`, `view crm contact revision`, `revert…`, `delete…`).
- Mapped contact: `view mapped crm contact`, `edit mapped crm contact`.
- Relationship: `create/view/edit/delete any crm relationship` + revision perms.
- `alter crm user display name`.

Dynamic (`permission_callbacks`):
- `ContactTypePermissions::contactTypePermissions` → per-bundle `create/view any/view any label/
  edit any/delete any <bundle> crm contact`.
- `RelationshipTypePermissions::relationshipTypePermissions` → per-bundle relationship perms.
- `SearchPermissions::searchPermissions` → contact-search permission(s).

## Access-control handlers
- **`ContactAccessControlHandler`** — admin short-circuits to allowed. Otherwise per operation:
  `view label`/`delete` → OR of the "any" + per-bundle permission, else the grant table;
  `view`/`update` → OR of "any"/per-bundle permission, else, if a `crm_user_contact_mapping`
  links this user to this contact, the `view mapped`/`edit mapped` permission, else the grant
  table. Grant fallbacks and mapping checks add the `user` cache context and
  `crm_user_contact_mapping_list` cache tag. `hasUserContactMapping()` runs an
  `accessCheck(FALSE)` existence query by design (it is determining access, not exposing the
  mapping). `viewLabelOperation` is enabled.
- **`ContactMethodAccessControlHandler`** — admin allowed; otherwise the method has no
  permissions of its own: view/update/delete **delegate to the parent `crm_contact`'s** view
  (delete → the contact's `update`). Create is allowed with contact create/edit permissions, or
  anonymously **only** on the `user.register` / `entity.user.edit_form` routes so the IEF widget
  can add methods during registration (`isUserFormContext()`).
- **`RelationshipAccessControlHandler`** — admin allowed; view/update/delete/create gated by the
  matching "any" or per-bundle relationship permission.
- **`MethodDetailAccessControlHandler`** — view allowed to all (non-sensitive labels);
  update/delete require `administer crm`.

## Controllers and PII gating
- `CrmController::accessLandingPage` gates `/crm` on `access crm` OR `administer crm`;
  the portal renders only menu sections whose own access passes.
- `RelationshipController` (per-contact `/relationship` tab) checks contact `view` access first,
  then any-bundle relationship view/create access. When rendering the relationship table it
  **re-checks `view` access on each related contact and each contact-method field** and skips /
  blanks rows the current user may not see — preventing disclosure of a related contact's email,
  phone or address to someone who lacks access to that contact.
- `CommentController::access` requires the comment module, a `comment` field on the contact, the
  contact's `view` access, **and** the core `access comments` permission.

## Per-contact grant API (`ContactAccessGrantStorage`, `crm.api.php`)
`crm_contact_access` table (`crm.install` schema) mirrors core node access:
- `hook_crm_contact_access_records($contact)` — modules return grant rows
  (`realm`, `gid`, `grant_label`, `grant_view`, `grant_update`, `grant_delete`); written on
  contact save/delete (`acquireGrants()` + `write()`; all-zero rows discarded).
- `hook_crm_contact_grants($account, $operation)` — modules return `realm => gid[]` the account
  holds; `access()` joins them against the table with parameterized queries (`view label`
  satisfied by `grant_label` OR `grant_view`).
- `rebuild()` truncates and re-derives grants for every contact; call it from a post-update /
  Drush after enabling a new grant provider. The `crm_user_contact_mapping` realm uses the mapped
  person contact id as the gid.
