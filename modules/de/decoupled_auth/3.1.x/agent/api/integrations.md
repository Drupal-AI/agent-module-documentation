<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration acquisition & module integrations (hooks in decoupled_auth.module)

## User forms

- `decoupled_auth_form_user_form_alter()` — on the **register** form (for non-`administer users`
  users), if `acquisitions.registration` is on, adds the entity-builder
  `decoupled_auth_form_user_register_form_entity_build` (and a `config:decoupled_auth.settings` cache
  tag). On the **edit** form, for users with `administer users`, adds a "This user has login details"
  checkbox (`not_decoupled`); `mail`/`name`/`pass` become conditionally required via `#states` +
  `decoupled_auth_element_validate_required`, and name/pass are hidden unless the box is checked.
- `decoupled_auth_form_user_register_form_entity_build()` — runs `decoupled_auth.acquisition` with
  `['mail'=>$email, 'decoupled'=>TRUE]` (decoupled matches only) and `behavior` = `BEHAVIOR_FIRST`
  when `behavior_first` is set, else none. On a match: `enforceIsNew(FALSE)`, copies empty fields from
  the acquired record (overriding `uid`, `uuid`, `created`) and adds its roles onto the new account —
  i.e. the registrant is linked to their pre-existing decoupled record. Protected roles (default
  `administrator`) are excluded by the service. The `hook_requirements()` check strongly discourages
  running this without email verification.
- `decoupled_auth_form_user_form_entity_build()` — on edit, `decouple()` when "has login details" is
  unchecked, else `couple()` (and, with Email Registration, generate a random username so the coupled
  account has one).

## Password reset / login (decoupled-aware)

- `UserPasswordFormAlter` (`hook_form_user_pass_alter`) replaces core's `::validateForm` (and
  `user_registrationpassword`'s validator) with decoupled-aware versions. Lookup by email requires
  `exists('name')` (**coupled users only**), then falls back to lookup by name — so a decoupled user
  (no name) cannot request a password. Blocked accounts are rejected.
- `UserLoginFormAlter` (`hook_form_user_login_form_alter`) replaces Email Registration's name-element
  validator; it resolves the entered email to an existing **coupled** account's username
  (`exists('name')`) before core authentication runs.

Because `decouple()` nulls `name` and `pass`, and `isAuthenticated()` requires `isCoupled()`, a
decoupled user has no credentials and cannot log in until deliberately coupled.

## Profile module

- `decoupled_auth_entity_base_field_info()` adds a read-only, unlimited-cardinality
  `profile_<type>` entity-reference base field to `user` for every Profile type.
- `decoupled_auth_profile_type_insert/delete` install/remove those base fields;
  `decoupled_auth_profile_insert/update/delete` call `$owner->updateProfileFields()` to keep the
  reference values current. `decoupled_auth_module_implements_alter()` unsets Profile's own
  `user_view` / `entity_extra_field_info` implementations (now covered by the base fields).

## Simplenews

`decoupled_auth_user_insert()` → `_decoupled_auth_simplenews_user_insert()` replaces core Simplenews'
`user_insert` (unset in `hook_module_implements_alter`). It attaches an existing subscriber (matched by
email via `loadByProperties`) to the new user, but **won't** move a subscriber away from a coupled
account onto a decoupled one — avoiding invalid re-assignment when several users share an email.

## Email Registration

`hook_module_implements_alter()` removes Email Registration's `user_presave` and `form_user_form_alter`
so decoupled users aren't forced to become coupled / get a username. `decoupled_auth_user_presave()`
calls `email_registration_user_presave()` only for coupled users. On the edit form, if Email
Registration is enabled, `decoupled_auth_form_user_form_alter()` calls its handler directly and marks
mail required for coupled users.

## Submodule

`decoupled_auth_crm` (Simple CRM) — a config-only convenience module (empty `.module`) depending on
`decoupled_auth`, `profile`, `address`, `datetime`, `options`, `image`, and shipping the
`simple_crm_users` view. Documented at `modules/de/decoupled_auth/modules/decoupled_auth_crm/3.1.x/`.
