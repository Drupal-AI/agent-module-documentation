<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Permissions — agent index

info.yml name: **Contact Permissions** (`contact_permissions`). Version **3.0.1** (version-dir 3.0.x).
Core `^9 || ^10 || ^11`. Depends on core `contact`. No config entities, no routes of its own, no
services beyond one access check. Type: access-control add-on for core's **personal** contact form.

## What it does

Core Contact gives each user an optional personal contact form at `user/{uid}/contact`, gated globally by
core's `access user contact forms` permission plus the user's own on/off preference. This module layers
role-based permissions on top so an admin can decide **which roles may have a personal contact form** and
**which roles' forms a given user may reach**.

## Permissions provided (`contact_permissions.permissions.yml` + `ContactPermissionsPermissions::permissions`)

- `have a personal contact form` — static. A user (recipient) must have this for their personal contact
  form to exist/be reachable at all.
- `use {role_id} personal contact forms` — one dynamically generated per role via `permission_callbacks`,
  for every role **except** anonymous (`ContactPermissionsPermissions` loads all roles and unsets
  `RoleInterface::ANONYMOUS_ID`). Titled "Use %role_label's personal contact forms". Grants a current user
  the ability to reach the personal contact forms of recipients holding that role, even without core's
  `access user contact forms`.

## Mechanism (two hooks/services)

1. `contact_permissions_form_user_form_alter` (`.module`) — on the user edit form, if the edited account
   does **not** have `have a personal contact form`, sets `$form['contact']['#access'] = FALSE`, hiding
   the "Personal contact form" enable toggle. Users whose role lacks the permission cannot turn one on.
2. `Access\ContactPermissionsContactPageAccess` (service `access_check.contact_personal`, tagged
   `applies_to: _access_contact_personal_tab`) — **replaces** core's checker for the
   `contact_personal_page` route. It extends core `ContactPageAccess` and:
   - calls `parent::access($user, $account)` first ($user = recipient, $account = current user);
   - only if core returned not-allowed *specifically* because `access user contact forms` was missing
     (matched on the reason string), it loops the recipient's roles and allows if the current user holds
     `use {role_id} personal contact forms` for any of them;
   - finally `andIf`s the whole result with "recipient has `have a personal contact form`".
   So a form is reachable only when the recipient's role carries `have a personal contact form` AND the
   current user satisfies core's permission OR a matching per-role permission. Core's earlier denials
   (self-contact, blocked recipient, recipient disabled their form, disabled site default) are preserved.

## Config / usage

No settings form. Everything is done on **People → Permissions**
(`/admin/people/permissions/module/contact_permissions`). Assign `have a personal contact form` to roles
that should be contactable; assign `use ROLE personal contact forms` to roles that should be able to reach
those recipients. Behaviour is exercised end-to-end in `tests/src/Functional/ContactPermissionsTest.php`.

## Files

- `contact_permissions.module` — help + user-form alter.
- `contact_permissions.permissions.yml` / `src/ContactPermissionsPermissions.php` — static + per-role perms.
- `contact_permissions.services.yml` / `src/Access/ContactPermissionsContactPageAccess.php` — access check.
- `tests/` — functional test + a test submodule defining `contactable`/`noncontactable` roles.
