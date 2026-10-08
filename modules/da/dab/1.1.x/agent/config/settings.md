<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DAB settings — component types & CSS extension

## Install & enable
```
composer require drupal/dab      # pulls league/commonmark ^2.4
drush en dab -y                  # requires core sdc module
```
No `config/install` and no `config/schema` ship with the module; the settings object is created on
first save of the form.

## Route & access
- Route `dab.components_types_configuration` — path `/admin/dab/components/settings`,
  `_form: Drupal\dab\Form\ConfigureComponentsTypesForm`, requirement `_permission: 'administer dab components'`.
- Exposed as a `Settings` local task and a `dab.settings` menu link under the DAB admin menu.

## Config object
`ConfigureComponentsTypesForm::CONFIG_NAME = 'dab.component_type.config'` (editable config; no schema).
Two keys:

- **`component_types`** — textarea, one entry per line `machine_name|Label`. Read by
  `AddComponentForm::getComponentTypesOptions()`: when set, it is `trim()`-ed, `explode("\r\n", …)`-ed and
  each line split on `|` into option `[machine_name => Label]`. When empty, a hard-coded default set is used:
  `atoms`, `molecules`, `organisms`, `templates`, `pages`, `other`. (Note: splitting on the literal `\r\n`
  means the list only parses correctly with CRLF line endings.)
- **`css_extension`** — textfield, default `.css`, validated by `#pattern`
  `^\.(css|scss|sass|less|styl|pcss)$`. Consumed by `ComponentFileManager::createCssFile()`: it always
  writes `<name>.css`, and additionally writes `<name><css_extension>` when the configured extension differs
  from `.css` (so a Sass/PostCSS source file is generated next to the plain `.css`).

## Behaviour
`buildForm()` seeds defaults from the current config; `submitForm()` saves both values back to
`dab.component_type.config`. Changing `component_types` immediately changes the group `#options` offered by
the Add/Edit component form and the group buckets used across the component list and menu deriver.
