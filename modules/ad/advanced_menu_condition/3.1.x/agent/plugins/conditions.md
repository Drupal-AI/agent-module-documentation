<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The two menu-trail condition plugins (and the Drush cleanup)

## Install & enable

```bash
composer require drupal/advanced_menu_condition
drush en advanced_menu_condition -y
```

No module dependencies (PHP `^8.1`, core `^10 || ^11`). No routes, no permissions, no config objects,
no install/schema config. The plugins appear wherever core Condition plugins are offered — most
commonly a block's **Visibility** tab (Block layout) or a Layout Builder section/block.

## Plugin: `advanced_menu_position` (`MenuPosition`)

`src/Plugin/Condition/MenuPosition.php`, `@Condition(id = "advanced_menu_position", label =
"Advanced menu position")`. Extends `ConditionPluginBase`, `ContainerFactoryPluginInterface`.

Injected services (`create()`): `menu.active_trail` (`MenuActiveTrailInterface`),
`menu.parent_form_selector` (`MenuParentFormSelectorInterface`), `plugin.manager.menu.link`
(`MenuLinkManagerInterface`).

Config key: `$configKey = 'menu_position'`. `defaultConfiguration()` returns `['menu_position' => '']`.

### `buildConfigurationForm()`

Renders one element: a `#type => 'select'`, `#multiple => TRUE` field titled *"Menu parent"* whose
`#options` are `['' => '- None -'] + menuParentFormSelector->getParentSelectOptions()` (all menu
links, keyed `menu_name:plugin_id`). `#default_value` is the stored selection; a `#attributes` style
makes the box tall. `submitConfigurationForm()` saves `form_state->getValue('menu_position')`.

### `evaluate()`

- Returns **TRUE** (no restriction) when the selection is empty.
- For each selected id, splits on `:` — `parts[0]` is the menu name; collects the selected ids.
- For each referenced menu it fetches `menuActiveTrail->getActiveTrailIds($menu)`.
- Returns **TRUE** if any selected id, reduced to `parts[1] . ':' . parts[2]`, is in that menu's
  active trail ids — i.e. the selected link is the active link **or an ancestor** of it (inheritance
  to children). Otherwise **FALSE**.

`summary()` → *"The selected menu items are either active or in the active trail."*

## Plugin: `advanced_menu_position_not` (`NotMenuPosition`)

`src/Plugin/Condition/NotMenuPosition.php`, `@Condition(id = "advanced_menu_position_not", label =
"Advanced Menu position - Hide")`. Extends `MenuPosition`; overrides `$configKey =
'not_menu_position'`. `evaluate()` returns TRUE when nothing is selected, otherwise
`!parent::evaluate()` — hiding the block on the selected trails. `summary()` → *"The selected menu
items are neither active nor in the active trail."*

Because it extends `MenuPosition`, the form and services are inherited; only the config key, negation
and summary differ. Both plugins honor the standard condition **negate** toggle from the base class.

## Configuring on a block (example)

1. *Structure → Block layout*, place or edit a block.
2. In **Visibility**, open **Advanced menu position** (show) or **Advanced Menu position - Hide**.
3. Select one or more menu items. Selecting a parent covers all descendants (trail match).
4. Save. The condition is stored in the block's `visibility` config, e.g.:

```yaml
# block.block.<id>
visibility:
  advanced_menu_position:
    id: advanced_menu_position
    menu_position:
      - 'main:standard.front_page'
    negate: false
```

No config schema is shipped for these keys, so strict schema tooling may warn; the condition still
saves and evaluates.

## Drush cleanup command

`src/Commands/AdvancedMenuConditionCommands.php` (registered in `drush.services.yml` as
`advanced_menu_condition.commands` with `@config.factory`, `@config.storage`):

- Command **`advanced-menu-condition:cleanup`** (alias **`amc-cleanup`**). Prompts for confirmation,
  then iterates every config name from `configStorage->listAll()` and, per config: removes
  `advanced_menu_condition` from `dependencies.module`, and unsets `advanced_menu_position` /
  `advanced_menu_position_not` from both `visibility` and `conditions`. Saves changed configs and
  logs a per-config notice plus a total count.

`advanced_menu_condition.install` `hook_uninstall()` runs this command automatically via
`Drush::processManager()->drush(... 'amc-cleanup', ['-y'])`, so uninstalling the module first strips
its references from configuration (requires Drush to be present).

## Operating notes

- Visibility follows menu structure, not URLs — reorganizing a menu updates where blocks appear
  without editing conditions.
- Use the plain plugin to *show* on a branch, the `_not` plugin to *hide* on a branch; combine both
  for precise targeting.
- Evaluation reads only the core active trail; there is no request/query input involved.
