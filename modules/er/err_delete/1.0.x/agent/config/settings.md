<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config

## Route & form

- Route `err_delete.settings_form` → `/admin/config/err_delete/settings`, title
  *ERR Delete Settings*, form `\Drupal\err_delete\Form\ErrDeleteSettingsForm`,
  `requirements: _permission: 'err delete entities'`, `options._admin_route: TRUE`.
- Menu link `err_delete.admin` (`err_delete.links.menu.yml`) places it under
  *Configuration → Content authoring* (parent `system.admin_config_content`).
- `info.yml` `configure:` points here (`err_delete.settings_form`).

## Form fields — `ErrDeleteSettingsForm`

`ErrDeleteSettingsForm extends ConfigFormBase`; `getEditableConfigNames()` = `err_delete.settings`
(class const `SETTINGS`). `buildForm()`:

- `remove_delete` — checkbox *"Remove original Delete button"*, default = config `replace_delete`.
- `recursive_delete_label` — textfield *"Recursive Delete button label"*, default = config
  `replace_delete_label`.

`submitForm()` writes back through `configFactory->getEditable('err_delete.settings')`:
`replace_delete` ← `remove_delete`, `replace_delete_label` ← `recursive_delete_label`, then
`save()`.

## Config object `err_delete.settings`

Install default (`config/install/err_delete.settings.yml`):

```yaml
langcode: en
replace_delete: true
replace_delete_label: 'Recursive Delete'
```

Schema (`config/schema/err_delete.schema.yml`, type `config_object`):

- `replace_delete` — `boolean`, label *"Replace delete button"*. When TRUE the alter hook removes
  core's Delete action from node edit forms.
- `replace_delete_label` — `label`, label *"Delete button label"*. Text of the recursive-delete
  link; the alter hook falls back to `Recursive Delete` when empty.

## Translation

`err_delete.config_translation.yml` registers mapper `err_delete.settings` (base route
`err_delete.settings_form`, names → `err_delete.settings`), so the button label is translatable
via the Config Translation UI.

## Permission

`err_delete.permissions.yml` defines a single permission `err delete entities`
(title *"Delete Contents with References"*). It gates both the settings route and the
recursive-delete route, and the alter hook only adds the button for users who hold it.
