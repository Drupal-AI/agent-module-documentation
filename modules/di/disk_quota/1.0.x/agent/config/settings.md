<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disk Quota — settings, route & permissions

## Install / enable

`composer require drupal/disk_quota` then `drush en disk_quota`. Depends on core `user` and `file`
(both always present). Optionally enable `drupal/markdown` so the help page renders formatted.
Uninstall (`drush pmu disk_quota`) removes the `disk_quota.settings` config and, per the README,
per-user overrides are cleaned up.

## Admin route & form

- Route **`disk_quota.admin`** → `admin/config/people/accounts/disk-quota`, title "Storage Quota
  Settings", `_admin_route: true`. Exposed as a local task ("Storage Quota") under the user
  account-settings form (`disk_quota.links.task.yml`, base route `entity.user.admin_form`).
- Form class `Drupal\disk_quota\Form\DiskQuotaSettingsForm` (extends `ConfigFormBase`, id
  `disk_quota_settings_form`), editable config `disk_quota.settings`. Injects `config.factory`
  and `entity_type.manager`.
- Route access requirement: `_permission: 'administer user roles disk quota'`. **Note:** this exact
  permission string is not defined in `disk_quota.permissions.yml` (which defines
  `administer user roles storage quota`), so in practice only user 1 (who bypasses access checks)
  reaches the form. Treat the two strings as the same intent when reasoning about access; the
  route string is what actually gates the page.

### Form sections (`buildForm`)

1. **Roles** fieldset: one textfield per user role, key `role_<rid>`. Value entered as a size
   string ("512", "80 KB", "50 MB"); shown via `ByteSizeMarkup::create()`. Validated by
   `disk_quota_form_quota_validate` (rejects non-scalar input).
2. **Quota by File Type** fieldset: `disk_quota_file_types` checkboxes — `images`, `videos`,
   `documents`. If none chosen, all file types count toward quota.
3. **Default values** fieldset: `disk_quota_warning_percentage` number field (min 1, max 100,
   required, suffix `%`).

### Submit (`submitForm`)

- Each `role_<rid>` value → `Bytes::toNumber()` → stored as **int bytes** in config.
- Checked file types → `array_keys(array_filter(...))` → `file_types` sequence.
- Warning field → int → `warning_percentage`. Then `$config->save()`.

## Config object `disk_quota.settings`

Schema `config/schema/disk_quota.schema.yml` (`config_object`):

| key | type | notes |
| --- | --- | --- |
| `file_types` | sequence[string] | subset of `images`/`videos`/`documents`; empty = track all files |
| `quota_by_type` | boolean | in schema + install (`false`), **never read by shipped code** |
| `warning_percentage` | integer (Range 1–100) | default `70` |
| `role_<rid>` | integer (bytes) | written by the form; **not present in schema** |

Install defaults: `file_types: []`, `quota_by_type: false`, `warning_percentage: 70`.

## Permissions (`disk_quota.permissions.yml`)

Static:
- `view own storage quota` — see own usage on the user page.
- `edit own storage quota` — edit own per-user override.
- `edit any storage quota` — edit any user's override; also lets you see any user's usage field.
- `create storage quota` — checked by `disk_quota_can_user_create_disk_quota()` (helper; not gating
  any shipped route/form directly).
- `administer user roles storage quota` — intended admin permission for role limits.

Dynamic (`DiskQuotaPermissions::permissions()`, registered via `permission_callbacks`): one
`edit {role_id} role storage quota` per user role, so quota-editing can be delegated per role.
`disk_quota_can_user_edit_disk_quota()` grants form access when the current user has `edit any`,
or `edit own` on their own account, or `edit <role> role storage quota` for any role the target
user holds.
