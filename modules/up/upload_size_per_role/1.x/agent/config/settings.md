<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & enforcement — upload_size_per_role

## Install / enable
`drush en upload_size_per_role -y`. No dependencies, no composer requirements. Ships only `.info.yml`, `.module`, `.routing.yml`, `.links.menu.yml`, and one form class.

## Settings form
- Route `upload_size_per_role.mapping` → `/admin/config/media/upload-size-per-role`, permission `administer site configuration`, `_admin_route: TRUE`. Reachable from the Media group of admin config (`upload_size_per_role.admin_settings` menu link).
- Class `Drupal\upload_size_per_role\Form\UploadSizePerRoleSettingsForm` (`ConfigFormBase`), form id `upload_size_per_role_settings_form`, editable config `upload_size_per_role.settings`. Injects `config.factory` + `entity_field.manager`; also uses the static `entity_type.manager`.
- `buildForm()` enumerates all fieldable entity types, keeps every field storage whose `getType() == 'file'`, and renders one `#type => table` per entity type. Each row is a field/bundle pair; columns are one `#type => number` (`#min => 1`, `#max => uploadMax`) cell per user role. `uploadMax = Bytes::toNumber(ini_get('upload_max_filesize')) / 1024 / 1024` (MB). Values are entered **in MB** (form `#prefix`).
- `submitForm()` saves `$form_state->getValue('mapping')` verbatim into `upload_size_per_role.settings:mapping`.

## The `mapping` config shape
`mapping` is a table keyed by row index; each row is an assoc array whose per-role cell keys are `"{entity_type}_{bundle}_{field_name}_{role_id}"` → integer MB (empty string when unset). Example cell key: `node_article_field_attachment_editor`. There is **no config schema file**, so these values are untyped config (numeric strings from the number element).

## How the limit is resolved and enforced (`hook_form_alter`)
For every form whose form object is an `EntityFormInterface`:
1. Derive `row_key = "{entity_type}_{bundle}_"` from the edited entity; collect all `mapping` cells whose key starts with `row_key` and is non-empty.
2. For each of the **current user's roles**, match cells whose key ends with that role id, deriving the field id back out; store the size in `field_list[field_id]` (last matching role wins — see note).
3. Clamp each `field_list` value to `uploadMax` (PHP `upload_max_filesize`).
4. Rewrite `$form[field]['widget'][0]['#description']` by `preg_replace('/\d+/', size, …)`.
5. Set the **server-side validators** when present:
   - `#upload_validators['FileSizeLimit']['fileLimit'] = Bytes::toNumber("{size} MB")` (Drupal ≥10.3 validator-plugin form).
   - `#upload_validators['file_validate_size'][0] = Bytes::toNumber("{size} MB")` (legacy form).

Because the size is recomputed from config + `currentUser` roles on every form build and written into the widget's real `#upload_validators`, the limit is enforced by core managed-file validation on submit (it is not a client-side hint, and is not read from any tamperable request value). The value can be **larger** than the field's stored `max_filesize` (that is the module's purpose for trusted roles), always bounded by PHP's `upload_max_filesize`.

## Operational notes
- Leave a field's own core "Maximum upload size" **empty** for any field you override; the description-rewrite regex replaces every digit in the description, so a stored default can be mangled (the project README warns of this).
- A field/role left blank in the matrix is not added to `field_list`, so that field keeps its own default limit for that user.
- The role resolution in step 2 uses an if/else that both branches assign, so it is effectively "last matching role wins" rather than a strict max across a user's roles — assign consistent values if a field is mapped for multiple roles a user may hold.
