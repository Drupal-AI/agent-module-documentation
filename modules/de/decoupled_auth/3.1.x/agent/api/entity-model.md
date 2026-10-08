<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity model: coupled vs decoupled users

## The class swap

`decoupled_auth_entity_type_build()` (in `decoupled_auth.module`) sets the `user` entity class to
`Drupal\decoupled_auth\Entity\DecoupledAuthUser` and its `storage_schema` handler to
`Drupal\decoupled_auth\DecoupledAuthUserStorageSchema`. `hook_install()` / `hook_uninstall()` in
`decoupled_auth.install` apply the same via `entityDefinitionUpdateManager()` and swap the field
constraints (below). `DecoupledAuthUserStorageSchema::getSharedTableFieldSchema()` sets
`not null = FALSE` on the `name` column of `users_field_data`, so a user row can have a NULL username.

## Coupled / decoupled state (`DecoupledAuthUser`)

- A user is **decoupled** when `name->value === NULL || id() === 0`. Computed in
  `calculateDecoupled()`, refreshed in the constructor, `postLoad()`, and `onChange('name'|'id')`.
- `isDecoupled()` / `isCoupled()` — read the flag.
- `decouple()` — sets the internal flag, and **nulls both `name` and `pass`**. `couple()` — clears
  the flag only (caller must supply a name/pass to make it a real account).
- `isAuthenticated()` returns `parent::isAuthenticated() && $this->isCoupled()` — a decoupled user is
  **never** treated as authenticated. `getRoles()` therefore only adds the `authenticated`/`anonymous`
  locked role when the coupled/anonymous checks pass.
- `updateProfileFields(array $types, $save = TRUE)` — recomputes the `profile_<type>` entity-reference
  base fields from the user's Profile entities (skips the anonymous user). Called from the profile
  insert/update/delete hooks.

## Field constraint swaps

`hook_install()` and `DecoupledAuthUser::baseFieldDefinitions()` both rewrite the `name` and `mail`
base-field constraints:

- `name`: made `setRequired(FALSE)`; core `UserName` constraint replaced by **`DecoupledAuthUserName`**;
  `NotNull` removed.
- `mail`: core `UserMailUnique` → **`DecoupledAuthUserMailUnique`**; core `UserMailRequired` →
  **`DecoupledAuthUserMailRequired`**.

Constraint validators (`src/Plugin/Validation/Constraint/`):

- `DecoupledAuthUserNameConstraintValidator` — extends core; **skips** username validation entirely for
  decoupled users, otherwise defers to core.
- `DecoupledAuthUserMailRequiredValidator` — extends core; requires mail **only** for coupled users.
- `DecoupledAuthUserMailUniqueValidator` — enforces email uniqueness according to
  `unique_emails.mode` (see [../config/settings.md](../config/settings.md)). Coupled users are always
  checked; decoupled users are checked only in the modes/roles that demand it. Uniqueness is scoped by
  an entity query that ORs `exists('name')` (coupled) with the configured role set.

## Views + formatter

- `Plugin/views/field/Decoupled.php` (`user_decoupled`) renders `'Yes'`/`'No'` for "has a web account"
  (`isDecoupled() ? 'No' : 'Yes'`).
- `Plugin/views/filter/Decoupled.php` (`user_decoupled`) filters on `users_field_data.name IS NULL /
  IS NOT NULL`; label "Has web account?". Auto-added to the `user_admin_people` view on install
  (`decoupled_auth_install_update_user_admin_people_view()`), removed on uninstall.
- `Plugin/Field/FieldFormatter/DecoupledUserNameFormatter.php` replaces core `user_name` formatter
  (via `hook_field_formatter_info_alter`) so it renders even when `name` is empty, pulling the user
  straight from `$items->getEntity()`.
