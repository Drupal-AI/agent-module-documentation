<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Link by Default (menu_link_by_default) — agent index

Defaults core Menu UI's **"Provide a menu link"** widget to **on/open** on new node forms, for content types you opt in per bundle. Version **1.1.0** (dir `1.1.x`). Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later. Depends on core **`menu_ui`** and **`node`**.

- **Where the setting lives, how the default is applied, config schema, operating it** →
  [configure/menu-default.md](configure/menu-default.md)

## What it actually is

- A hooks-only module. No routes, no permissions, no Drush, no plugins, no config UI route (`configure` is null).
- One service: `Drupal\menu_link_by_default\Hook\MenuLinkByDefaultHooks` (`menu_link_by_default.services.yml`, `autowire: true`), holding the two `#[Hook]` implementations.
- Config: a node-type **third-party setting** `menu_link_by_default.enable_menu_link_by_default` (boolean), schema `node.type.*.third_party.menu_link_by_default` in `config/menu_link_by_default.schema.yml`. No standalone config object.

## Mechanism (from source)

- `formNodeTypeFormAlter()` (`#[Hook('form_node_type_form_alter', OrderAfter menu_ui)]`) adds a checkbox `enable_menu_link_by_default` inside the form's `menu` element; `#states` hide it unless a menu option is checked. Persisted by entity builder `menu_link_by_default_node_type_form_builder()` in the `.module` file via `NodeType::setThirdPartySetting()`.
- `formNodeFormAlter()` (`#[Hook('form_node_form_alter', OrderAfter menu_ui)]`) runs only when `$form['menu']['#access']` is truthy and the node `isNew()` under the `default` operation; if the bundle's third-party setting is on it sets `$form['menu']['#open']` and `$form['menu']['enabled']['#default_value']` to 1.
- `.module` keeps thin `#[LegacyHook]` wrappers plus `hook_module_implements_alter()` (`#[LegacyModuleImplementsAlter]`) that moves this module's `form_alter` last so it overrides Menu UI's defaults.
- It only flips default state — it does not create a link, set a parent, or pre-fill the title. Core Menu UI still owns link creation and access.
