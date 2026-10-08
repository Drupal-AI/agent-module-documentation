<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# alr — configuration & settings form

## Install / enable
Core-only, no dependencies. `drush en alr -y`. No install hook, no default config shipped (`alr.settings` is created on first form save).

## Route, form, access
- Route `alr.admin_settings_form` (`alr.routing.yml`): path `/admin/config/alr-configuration`, `_form: \Drupal\alr\Form\ALRConfigurationForm`, requirement `_permission: 'administer site configuration'`.
- Menu link `alr.admin_settings_form` (`alr.links.menu.yml`) under `system.admin_config_system`, weight 100 → appears on `/admin/config` System as "Login/Logout module config settings".
- Note: `alr.info.yml` sets `configure: alr.info.admin_settings_form`, a non-existent route id, so the "Configure" gear on the Extend page is broken; use the menu link or path.

## Form: `ALRConfigurationForm` (`src/Form/ALRConfigurationForm.php`)
- Extends `ConfigFormBase`; `getFormId()` = `alr_configuration_form`; editable config = `alr.settings` (const `CONFIG_SETTINGS`).
- `create()` injects `config.factory`, `path.validator`, `entity_type.manager`. (`pathValidator` is stored but never used.)
- `getUserRoles()` loads all `user_role` entities via entity type manager and removes `RoleInterface::ANONYMOUS_ID`; returns `id => label`.
- `buildForm()` renders two `#type => details` sections, each a `#type => table` (`login`, `logout`) with columns Role / Redirect URL / Weight, `#tabledrag` order on group `draggable-weight`. Per role row: `role` (`#markup` label), `redirect_url` (`#type => textfield`, default from `login.<rid>.redirect_url` / `logout.<rid>.redirect_url`), `weight` (`#type => weight`). Caption states the path "should either be valid internal starting with / or external starting with http or https"; blank = no redirect for that role.
- `submitForm()` calls parent then saves `login` and `logout` from `$form_state` into `alr.settings`.

## Config object `alr.settings`
No schema file ships. Shape written by the form:
```yaml
login:
  <role_id>:
    redirect_url: '/dashboard'   # or '' (no redirect)
    weight: '0'
logout:
  <role_id>:
    redirect_url: 'https://example.com/bye'
    weight: '0'
```
Read at runtime via `alr_get_config('login')` / `alr_get_config('logout')` in `alr.module`, which return `\Drupal::config('alr.settings')->get($key)` or `[]`.

## Operate
1. Grant `administer site configuration` to the operator (already an admin-level permission).
2. Visit `/admin/config/alr-configuration`, fill a redirect path per role for login and/or logout, optionally reorder rows, Save.
3. Export `alr.settings` with `drush config:export` to move rules between environments.
