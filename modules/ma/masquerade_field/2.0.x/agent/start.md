<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Masquerade Field (masquerade_field) — agent index

Adds a **`masquerade_as` entity-reference field to every user account** listing the specific accounts
that user may masquerade as, narrowing the Masquerade module from a site-wide grant to a per-user
allow list. Requires **`masquerade` (`^2.0`)**. Version **2.0.1**, core `^10.4 || ^11`, GPL-2.0-or-later.
No configuration route; no Drush commands.

## Mechanism (read this first)
- Provides a `masquerade_field` **field type** (extends core `EntityReferenceItem`, target = `user`,
  unlimited cardinality) and attaches it as the **base field `masquerade_as`** on the user entity via
  `hook_entity_base_field_info()` (see `src/Hook/MasqueradeFieldHooks.php`).
- Grants masquerade through Masquerade's own extension point: `hook_masquerade_access()` loads the
  current user's `masquerade_as` targets and returns **`TRUE`** when the requested target is listed
  (never returns `FALSE`). Masquerade aggregates as *any TRUE + no FALSE ⇒ allow*, so **a listed
  target is permitted even if the user holds no core masquerade permission**.
- The switch itself is **not** re-implemented here. The formatter/Views links point at Masquerade's
  own route `entity.user.masquerade` (`/user/{user}/masquerade`), which is **CSRF-protected**
  (`_csrf_token: 'TRUE'`) and validated in `SwitchController::switchTo()` →
  `masquerade_switch_user_validate()` → `masquerade_target_user_access()`. This module only feeds the
  access decision and renders the link.

## Plugins provided
- **Field type** `masquerade_field` — `src/Plugin/Field/FieldType/MasqueradeFieldItem.php`
  (default handler `masquerade_field_user`, list class de-duplicates targets on `preSave()`).
- **Formatter** `masquerade_field_default` — `src/Plugin/Field/FieldFormatter/MasqueradeFieldFormatter.php`.
  Extends `EntityReferenceLabelFormatter`; swaps each label's URL to `$target->toUrl('masquerade')`
  **only when** the entity is the current user and they are not already masquerading.
- **EntityReferenceSelection** `masquerade_field_user` —
  `src/Plugin/EntityReferenceSelection/MasqueradeFieldUserSelection.php` (extends core `UserSelection`;
  a TODO to exclude the edited user is still open, see issue 3107746).
- **Views field** `masquerade_link` — `src/Plugin/views/field/MasqueradeLink.php` (extends `EntityLink`;
  `checkUrlAccess()` returns allowed — the real check is in the switch controller).
- **Validation constraint** `ExcludeOriginUser` — blocks setting an account to masquerade as itself.
- **Widget**: reuses core `entity_reference_autocomplete` (registered via `field_widget_info_alter`).

## Permissions (`masquerade_field.permissions.yml`)
- `edit masquerade field` — **`restrict access: true`**. Governs who may *set* the target lists;
  this is effectively the grant of masquerade rights. **Treat as highly sensitive** (see Mechanism).
- `view own masquerade field` / `view any masquerade field` — govern who may *see* a roster.
  Seeing the list is separate from setting it.

## Config / Views
- Optional view `views.view.masquerade_as` — a **"Masquerade as" block** listing the current user's
  targets (access: `view own masquerade field`; argument defaults to current user).
- Config schema for the formatter and Views field settings only. No settings form, no admin page.

## Agent guides
- `agent/fields/masquerade-field.md` — the field, formatter, widget, selection handler, constraint, and field access.
- `agent/api/masquerade-access.md` — how the masquerade grant works via `hook_masquerade_access()` and how core aggregates it.
- `agent/views/masquerade-link.md` — the Views field handler and the bundled block/view.

## Security note for reviewers
The grant flows through `hook_masquerade_access()` returning `TRUE`, which **overrides Masquerade's
role-based checks and its dedicated `masquerade as super user` protection for uid 1**. Whoever can
edit a `masquerade_as` list (permission `edit masquerade field`, or a user editing their own account
form) decides masquerade rights, including toward privileged accounts. CSRF on the switch is enforced
by core Masquerade. Session scope while masquerading is bounded only by the **target's** permissions.
