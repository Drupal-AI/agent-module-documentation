<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Field Defaults

Two things to configure: the **global setting** (config object `field_defaults.settings`) and
the **per-field UI** that actually triggers an update.

## Global setting — `field_defaults.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `retain_changed_date` | integer (0/1) | `1` | When on, the entity's original *changed*/updated timestamp is preserved during a bulk default update (see [api/processor.md](../api/processor.md)). |

- Configure route: `field_defaults.field_defaults_settings_form` →
  `/admin/config/system/field_defaults/settings` (menu: *Configuration → System → Field
  defaults settings*). The form (`SettingsForm`, a plain `FormBase`, **not** a
  `ConfigFormBase`) has one checkbox, "Retain original entity updated time", bound to
  `retain_changed_date`. Route permission: `access configuration pages`.
- Read/write from Drush:
  ```bash
  drush cget field_defaults.settings retain_changed_date
  drush cset field_defaults.settings retain_changed_date 0 -y
  ```
- Config schema: `field_defaults.settings` is a `config_object` with the single integer key
  `retain_changed_date`.

## Permission

`administer field defaults` (`restrict access: TRUE`, description "Administer default values
on content entities"). It gates the **"Update existing content"** section that the module adds
to a field's edit form. Without it, the field edit form is unchanged.

## Per-field UI — where an update is triggered

`hook_form_field_config_edit_form_alter()` adds an **"Update existing content"** details group
under *Structure → (entity type) → Manage fields → (field) → Edit*, inside the Default value
area. Fields shown (form values live under `default_value_input.field_defaults`):

| Control | Key | Effect |
|---|---|---|
| "Overwrite existing *(lang)* content with the selected default value(s)" | `update_defaults` (checkbox) | Run the bulk update for the field's own language when the form is saved. |
| "Additionally Update entities of the following languages:" | `update_defaults_lang` (checkboxes) | Only shown when the bundle **and** field are translatable; also update the selected translations. |
| "Keep existing values" | `no_overwrite` (checkbox) | Only write the default where the field is currently **empty**; do not clobber existing data. |

On save, `_field_defaults_ui_submit()` calls
`\Drupal::service('field_defaults.processor')->processFieldForm($fieldConfig, $fieldDefaults,
$fieldValues)` (with the field's just-saved default value) and runs the batch synchronously.
The update uses the field's own configured default value — set/adjust the field's **Default
value** first, then tick "Overwrite existing content" and Save.

For a non-UI / scriptable path use the Drush command → [drush/commands.md](../drush/commands.md).
