<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object, route

## Install / enable

`composer require drupal/entity_field_capitalization` then `drush en entity_field_capitalization -y`.
No dependencies, no libraries. On install nothing is transformed until you configure fields.

## Route & access

- Route `entity_field.capitalization_settings` (`entity_field_capitalization.routing.yml`):
  path `/admin/config/field-capitalization-settings`, `_form:
  \Drupal\entity_field_capitalization\Form\EntityCapitalizationConfigForm`, title
  *"Entity Capitalization Configuration"*, `options._admin_route: TRUE`.
- Requirement: `_permission: 'administer site configuration'` — a **core** permission. The module
  ships **no** `*.permissions.yml`.
- Menu link `entity_field.capitalization_settings` (`entity_field_capitalization.links.menu.yml`):
  title *"Field Capitalization Configuration"*, parent `system.admin_config_ui`.
- This is also the module's `configure` route (data.json `configure`).

## Form — `EntityCapitalizationConfigForm` (`src/Form/EntityCapitalizationConfigForm.php`)

Extends `ConfigFormBase`. `getFormId()` = `entity_capitalization_config_form`.
`getEditableConfigNames()` = `['entity_field.capitalization_config']`. Two fields:

- **`exclude_strings`** — textfield (`#maxlength: 255`, `#size: 64`). Comma-separated strings to leave
  untouched, e.g. `iPod,jQuery`.
- **`entity_and_fields`** — textarea. One line per rule, comma-separated machine names:
  `ENTITY_TYPE,BUNDLE,FIELD_NAME` (e.g. `node,article,title`). Multiple field names may follow the
  bundle on the same line; multiple rules on separate lines.

`submitForm()` saves both values to config and calls `parent::submitForm()`.

## Config object — `entity_field.capitalization_config`

Keys: `entity_and_fields` (string, the multiline rules) and `exclude_strings` (string, the comma
list). Install default `config/install/entity_field.capitalization_config.yml` is effectively empty
(no values). **No config schema** is provided (`config/schema/` does not exist), so the settings are
untyped config.

Example (config export):

```yaml
exclude_strings: 'iPod,jQuery'
entity_and_fields: |
  node,article,title
  taxonomy_term,tags,name
```

With the above, saving an `article` node title-cases its `title`, and saving a `tags` term
title-cases its `name`, while the words `iPod` and `jQuery` stay as written.
