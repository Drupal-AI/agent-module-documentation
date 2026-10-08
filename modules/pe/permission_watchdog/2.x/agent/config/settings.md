<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — which roles are watched

## Install / enable

`drush en permission_watchdog -y`. No composer deps beyond core. The permission report needs core
**Views** (enabled on standard installs); the view ships in `config/optional` so it is installed
automatically when both modules are present. On install, `config/install/permission_watchdog.settings.yml`
seeds `all_roles: true`, `roles: {}` — i.e. **all roles are monitored by default**.

## Settings form

- Route: `permission_watchdog.settings` → path `/admin/config/people/permission-watchdog`
  (also linked under the People admin index via `permission_watchdog.links.menu.yml`).
- Access: permission **`administer permission_watchdog configuration`** (`restrict access: true`).
- Class: `Drupal\permission_watchdog\Form\SettingsForm` (extends `ConfigFormBase`,
  form id `permission_watchdog_settings`).

Fields (`buildForm()`):
- `all_roles` — checkbox, "Track all roles for changes to permissions".
- `roles` — checkboxes of role labels, visible only when `all_roles` is unchecked
  (`#states` visible when `all_roles` not checked). **Admin roles are excluded** from the options —
  `array_filter($roles, fn(RoleInterface $role) => !$role->isAdmin())` — because admin roles hold all
  permissions implicitly and store nothing to diff against.

Validation (`validateForm()`): if `all_roles` is on, `roles` is forced to `[]`; if `all_roles` is off
and no role is selected, sets an error "At least one role must be selected".
Submit (`submitForm()`): stores `all_roles` and the array-values of the checked `roles`.

## Config object & schema

`permission_watchdog.settings` (`config/schema/permission_watchdog.schema.yml`):
- `all_roles` — boolean.
- `roles` — sequence of strings (role ids to track).

## Status report requirement

`permission_watchdog_requirements('runtime')` (`.install`) reports on `admin/reports/status`:
- `all_roles` true → OK, "monitoring all roles".
- no roles and not all → **ERROR**, "isn't monitoring any roles" with a "Configure now" link.
- some roles but not all → **WARNING**, encourages monitoring all roles.

`all_roles` is read everywhere through `filter_var(..., FILTER_VALIDATE_BOOLEAN)`.
