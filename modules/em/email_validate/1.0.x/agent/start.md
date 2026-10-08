<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email extended validation (email_validate) — agent index

Attaches admin-selectable validation **constraints to the core `user` entity `mail` field** to block
disposable, synonym, and unwanted-domain addresses. Package `Security`. Version **1.0.5**. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. No composer.json, **no declared dependencies**,
no permissions of its own, no Drush, no submodules.

- **The five constraints, their validators, and how they attach** →
  [constraints/validation.md](constraints/validation.md)
- **Settings form, config object + schema, routes, bulk user-check** →
  [config/settings.md](config/settings.md)

## What it actually is

- `email_validate.module`: `hook_entity_base_field_info_alter()` reads config
  `email_validate.settings`; for each constraint whose `enable` is truthy it calls
  `$fields['mail']->addConstraint($constraintKey)` on the `user` entity's `mail` base field. So the
  enabled checks run wherever `mail` is validated (registration form, admin user forms, programmatic
  `$account->get('mail')->validate()`).
- Five constraint plugins in `src/Plugin/Validation/Constraint/`, all extending
  `EmailConstraintBase` (a plain Symfony `Constraint` subclass, not annotated with settings):
  `GoogleEmailConstraint`, `YandexEmailConstraint`, `BlockEmailDomainConstraint`,
  `DomainMxRecordConstraint`, `TemporaryEmailConstraint`, each with a matching `*Validator`.
- Two admin forms/routes (both `_permission: administer site configuration`): the settings form
  `EmailValidateForm` and the bulk `UserValidationForm`.
- Config schema `email_validate.settings` (one config object). No install config; all constraints
  ship disabled (`enable: 0`) by their schema defaults / first save.

## Routes

- `email_validate.settings` → `/admin/config/people/email_validate` (`EmailValidateForm`).
- `email_validate.users_validation` → `/admin/config/people/email_validate/users_validation`
  (`UserValidationForm`, bulk batch re-check of existing accounts).
