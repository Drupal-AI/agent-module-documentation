<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin UI, routes & database schema

## Install / enable

`drush en custom_configuration -y`. No dependencies (contrib **Domain** is optional — install it
first if you want per-domain values). Enabling runs `custom_configuration_schema()` in
`custom_configuration.install`, which creates the `custom_configuration` table. On an install that
predates the options/domain/langcode columns, `custom_configuration_update_8319()` adds them and
the unique key (`drush updb`).

## Routes (all `_permission: 'administer site configuration'`)

Defined in `custom_configuration.routing.yml`:

| Route | Path | Form class |
|---|---|---|
| `custom_configuration.configuration_form` | `/admin/config/system/custom_config` | `Form\ConfigurationForm` (Add) |
| `custom_configuration.configuration_list` | `/admin/config/system/custom_config/configuration_list` | `Form\CustomConfigurationList` (List) |
| `custom_configuration.edit_configuration_form` | `/admin/config/system/editConfig/{custom_config_id}` | `Form\EditConfigurationForm` |
| `custom_configuration.delete_configuration_form` | `/admin/config/system/deleteConfig/{custom_config_id}` | `Form\DeleteConfigurationForm` |

`configure` in the `.info.yml` points at `custom_configuration.configuration_list`. Menu link
(`custom_configuration.links.menu.yml`) sits under *Configuration → System*
(`system.admin_config_system`); local task tabs (`custom_configuration.links.task.yml`) expose
Add and List. There are **no module-specific permissions** — everything uses core
`administer site configuration`.

## Add form — `ConfigurationForm` (extends `ConfigFormBase`)

Fields: **Configuration Key Name** (`key`, maxlength 50, required — an AJAX blur callback
`showMachineName()` previews the derived machine name), **Configuration Value** (`value`,
textarea, required), **Optional Value 1–4** (`optional_value[value_1..4]`, `#tree`, optional
textareas), **Configuration Status** (`status`, Active `1` / Inactive `0`, default Active). A
**Language** multi-select appears only when the site has >1 language; a **Domain** multi-select
appears only when the Domain module is enabled. `validateForm()` serializes the optional values
and calls `ConfigurationHelper::checkDuplicateItems()` — a machine-name + domain + language clash
sets an error on `key`. `submitForm()` calls `ConfigurationHelper::createConfiguration()` and
shows the returned status message.

## List form — `CustomConfigurationList`

`buildForm()` calls `ConfigurationHelper::getConfigList()` (no args → all rows) and renders a
`#type => table` with columns Config Name, Machine Name, Value (truncated to
`$cahracterLimit = 100` chars), Lang, Domain, Status (ACTIVE/INACTIVE), and Edit/Delete links
(`Link::createFromRoute`). Language/domain codes are humanized via `getLanguageName()` /
`getDomainName()`. Empty state links to the Add form.

## Edit form — `EditConfigurationForm`

Loads the row by the `{custom_config_id}` route param (`getConfigList(['id' => $configId])`),
pre-fills the same fields (machine name shown read-only in a hidden field + markup), unserializes
the optional values (`allowed_classes => FALSE`) for the four optional textareas, and offers
**Update Configuration** / **Cancel** buttons. `validateForm()` re-runs the duplicate check
(excluding the current id via `config_id`). `submitForm()` calls
`ConfigurationHelper::updateValue()` and, on success, redirects to the list; Cancel just redirects
to the list.

## Delete form — `DeleteConfigurationForm`

Loads the row's `custom_config_name` by id, shows an "Are you sure…" confirm-style message with
**Delete Configuration** / **Cancel** submit buttons. On the Delete action it calls
`ConfigurationHelper::deleteValue($configId)` and redirects to the list.

## Database table `custom_configuration` (from `hook_schema`)

Fields: `custom_config_id` (serial PK), `custom_config_name` (varchar 50), `custom_config_machine_name`
(varchar 50), `custom_config_value` (text), `custom_config_options` (text — PHP-serialized array
of `value_1..4`), `custom_config_domains` (varchar 150, comma-wrapped e.g. `,default,`),
`custom_config_langcode` (varchar 150, comma-wrapped e.g. `,en,`), `custom_config_status`
(small int; 1 = Active), `custom_config_updated_date` / `custom_config_created_date` (int
timestamps). **Unique key** `machine_name_domain_langcode` on
(`custom_config_machine_name`, `custom_config_domains`, `custom_config_langcode`) — the same
machine name may repeat across different domain/language combinations but not within one.

## Machine-name generation

`ConfigurationHelper::createMachineName()` lowercases + trims the key, strips characters outside
`[a-zA-Z0-9_ ]`, collapses whitespace/underscores, converts remaining separators to `_`, and caps
at 50 chars. Callers pass the human key name; the machine name is derived automatically.
