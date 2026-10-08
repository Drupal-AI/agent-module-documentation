<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, permissions & install

## Install / enable

Standard module install (`ddev drush en entity_tasks -y`). No dependencies beyond Drupal core
(`^10 || ^11`), no external libraries, no Composer requirements, no submodules, no Drush commands.
Nothing is configured automatically: the block must be placed and the toolbar mode chosen.

## Permissions (`entity_tasks.permissions.yml`)

- **`access entity tasks`** ("Use entity tasks") — required for the block to render
  (`EntityTasksBlock::build()`) and for the toolbar integration to appear
  (`ToolbarService::buildToolbarConfiguration()`).
- **`administer entity tasks configuration`** ("Administer the entity tasks view mode") — required
  for the settings route below.

## Settings form

- Route `entity_tasks.config` (`entity_tasks.routing.yml`): path `/admin/config/entity-tasks`,
  `_form => EntityTasksConfigForm`, requirement `_permission: 'administer entity tasks configuration'`.
- Menu link `entity_tasks.config` under `system.admin_config_ui`
  (`entity_tasks.links.menu.yml`); the module's `configure` key points here.
- Class `EntityTasksConfigForm` — `src/Form/EntityTasksConfigForm.php`, extends `ConfigFormBase`
  (so submissions carry a core form/CSRF token).

### Config object `entity_tasks.config`

- Editable name constant `ENTITY_TASKS_CONFIG_NAME = 'entity_tasks.config'`.
- Single field **`display_mode`** — a required `select` with options:
  - `-1` → *Disabled*
  - `classic` → *Classic*
  - `expanded` → *Expanded*
  - `dropdown` → *Dropdown*
  - default value `classic` when unset.
- `submitForm()` iterates `$form_state->getValues()`, skips the standard form keys
  (`submit, form_build_id, form_id, form_token, op`) and any array values, and `set()`s the rest,
  then `save()`s.

No `config/schema/*` or `config/install/*` ships with the module (`provides_config_schema` is
false); the config object is created on first save (or the classic-mode fallback in
`ToolbarService::getCorrectDisplayMode()`).

## Themes & libraries

- `hook_theme()` in `entity_tasks.module` decodes `entity_tasks.themes.yml`, registering hooks
  `entity_tasks_block` (vars `content`, `left`) and `entity_tasks_dropdown` (var `links`).
- Libraries (`entity_tasks.libraries.yml`): `block` (CSS + `entity-tasks.tabs-block.js`, depends on
  `core/drupalSettings`), `toolbar` (CSS), `dropdown` (CSS + `entity-tasks.dropdown.js`).
