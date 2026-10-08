<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration codes (regcode) — agent index

Adds a **registration code** field to the core user-register form and gates account creation on a
valid, active, unexpired code. Codes live in a plain DB table (`regcode`), not entities. Package
`Registration`. Depends on core **`views`** (`test_dependencies: rules`). Core `^10.3 || ^11`.
License GPL-2.0-or-later. Version 2.0.1. One permission: **`administer registration codes`**.

## What it provides (from source)

- **Service `registration_code`** → `Drupal\regcode\RegistrationCode` implements
  `RegistrationCodeInterface` (autowired; interface is also aliased as a service id). Methods:
  `load()`, `validateCode()`, `consumeCode()`, `save()`, `clean()`, `generate()`,
  `deleteAction()/activateAction()/deactivateAction()`, `getVocabTerms()`. See
  [api/service.md](api/service.md).
- **Registration-form integration** in `regcode.module`:
  `regcode_form_user_register_form_alter()` adds the `regcode` textfield (an extra field, see
  `regcode_entity_extra_field_info()`); element validator `regcode_code_element_validate()` and
  submit handler `regcode_user_register_form_submit_handler()`. `?regcode=XYZ` pre-fills the field.
- **Three admin forms** under `/admin/config/people/regcode` (all `_permission: 'administer
  registration codes'`): create/generate (`regcode.admin_create`,
  `RegcodeAdminCreateForm`), bulk clean (`regcode.admin_manage`, `RegcodeAdminManageForm`),
  settings (`regcode.admin_settings`, `RegcodeAdminSettingsForm`, a `ConfigFormBase`). The code
  **list** is the View `views.view.regcode` (route `view.regcode.page_admin`). See
  [config/settings.md](config/settings.md).
- **Drush 12+ commands** (`RegcodeDrushCommands`): `regcode:validate`, `regcode:consume`,
  `regcode:generate`.
- **Extension points**: `hook_regcode_used()`, `hook_regcode_load()`, `hook_regcode_presave()`
  (documented in `regcode.api.php`); event `RegcodeUsedEvent` (name `regcode.code_used`, also a
  Rules event via `regcode.rules.events.yml`); tokens `[regcode:*]` (`regcode.tokens.inc`);
  Views data + a VBO-actions alter (`regcode.views.inc`).
- **Config object** `regcode.settings` (schema in `config/schema/`, defaults in `config/install/`).
- **Schema**: `regcode_schema()` in `regcode.install` — table `regcode`
  (`rid, uid, created, lastused, begins, expires, code, is_active, maxuses, uses`; unique key on
  `code`).

## Key facts

- A code object is a `\stdClass` from the DB row — **not** a config/content entity. `load()` /
  `validateCode()` return `object|false` / `int|object`; integer returns are the
  `RegistrationCodeInterface::VALIDITY_*` error codes (`NOT_EXISTING=0`, `NOT_AVAILABLE=1`,
  `TAKEN=2`, `EXPIRED=3`).
- The field is **required** unless `regcode_optional` is TRUE **or** the current user has
  `administer users` (admins can create accounts without a code).
- The base module does **not** assign roles or permissions itself; role/group assignment is left to
  reacting modules via `hook_regcode_used()` / `RegcodeUsedEvent`.
- All `regcode_*()` procedural functions in `regcode.module` (`regcode_load_single`,
  `regcode_code_validate`, `regcode_save`, …) are **deprecated in 2.0.0, removed in 3.0.0** — use
  the `registration_code` service.

Docs: [api/service.md](api/service.md) · [config/settings.md](config/settings.md)
