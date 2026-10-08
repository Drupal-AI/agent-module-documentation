<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role description (role_description) — agent index

Attaches a free-text description to each user role and injects it as the `#description`
under the matching role checkbox on the account form (and on the role_delegation assign
forms), so whoever assigns roles sees what each one means. Descriptions live in one config
object keyed by role machine name. No stable release yet — newest is `1.0.0-rc2`.

- Dependencies: core `user`, core `config_translation`. Core requirement `^10 || ^11`.
- Configure route: `role_description.settings` at `/admin/people/role-description`
  (permission `administer permissions`). No other settings page.
- Defines no permissions of its own, no drush commands, no plugin types. Ships config schema.

Docs:
- **Set / read role descriptions (settings form, config object, schema, drush/PHP)** → [configure/descriptions.md](configure/descriptions.md)
- **Where descriptions are injected (the two form_alter hooks; role_delegation integration)** → [hooks/form-alter.md](hooks/form-alter.md)

Key facts:
- Config object `role_description.settings`, single key `role_description` = map of
  `role_id => description` string. `config/install` ships it empty (`role_description: {}`).
- Settings form: `Drupal\role_description\Form\SettingsForm`, form id `role_description_settings`,
  route `role_description.settings`; excludes the `anonymous` and `authenticated` roles.
- Hooks (in `includes/role_description.form.inc`, included from `role_description.module`):
  `role_description_form_user_form_alter` (BASE_FORM_ID `user_form`),
  `role_description_form_role_delegation_role_assign_form_alter` (FORM_ID).
- Config schema: `config/schema/role_description.schema.yml` +
  `config/schema/role_description.data_types.schema.yml`; translation map
  `role_description.config_translation.yml` (registers config `role_description.settings`).
- Reuses core `administer permissions` — the permission that already governs roles — rather
  than declaring one of its own.
