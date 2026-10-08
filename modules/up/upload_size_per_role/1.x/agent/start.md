<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Upload Size Per Role (upload_size_per_role) — agent index

Overrides the per-field "Maximum upload size" on `file`-type fields **per user role**. Version dir **1.x** (installed 1.0.2). Package `UNHCR`. `core_version_requirement: ^10 || ^11`. No dependencies, no composer.json, no submodules.

## How it works (one hook + one form)
- `upload_size_per_role.module` — `hook_form_alter()`: on any `EntityFormInterface` form, reads the `upload_size_per_role.settings:mapping` config, resolves the size for the current user's roles for each mapped field, caps it at PHP `upload_max_filesize`, rewrites the widget `#description`, and sets the widget's **real upload validators** (`#upload_validators['FileSizeLimit']['fileLimit']` and legacy `#upload_validators['file_validate_size'][0]`) so the limit is enforced on submit.
- `src/Form/UploadSizePerRoleSettingsForm.php` (`UploadSizePerRoleSettingsForm extends ConfigFormBase`) — builds a per-entity-type table of every `file` field × every user role, saves numeric MB values into `upload_size_per_role.settings:mapping`.

## Config / routes / services
- Config object: `upload_size_per_role.settings` (key `mapping`). **No `config/schema` and no `config/install` ship** (`provides_config_schema: false`).
- Route: `upload_size_per_role.mapping` → `/admin/config/media/upload-size-per-role`, permission **`administer site configuration`** (`configure` route).
- Menu link: `upload_size_per_role.admin_settings` under `system.admin_config_media`.
- Services used (core): `config.factory`, `entity_field.manager`, `entity_type.manager`. Provides no services, plugins, permissions, or drush commands of its own.

## Solution docs
- [agent/config/settings.md](config/settings.md) — settings form, the `mapping` config shape, and how the per-role limit is resolved and enforced.
