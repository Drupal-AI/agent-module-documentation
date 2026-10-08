<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: default "Provide a menu link" per content type

## Install / enable

`drush en menu_link_by_default -y`. Core-only; pulls in `menu_ui` and `node` (info.yml `dependencies`). No libraries, no `composer require` beyond core. Core `^10.2 || ^11 || ^12`.

## Where the setting lives

There is **no dedicated admin route** (`configure` is null). The control is a checkbox added to the **node type edit form**, inside core Menu UI's **"Menu settings"** vertical-tab, at `/admin/structure/types/manage/{type}` (permission `administer content types`):

> **Enable "Provide a menu link" by default when creating new content of this type.**

It is added by `MenuLinkByDefaultHooks::formNodeTypeFormAlter()` as `$form['menu']['enable_menu_link_by_default']` (`#type => checkbox`). A `#states` rule hides it unless at least one **Available menus** box is checked (`input[name^="menu_options"]`), so it only appears once the type can place content in a menu.

![Menu settings section of the Article content type edit form, showing the "Enable Provide a menu link by default" checkbox](../../../../../../../screenshots/menu_link_by_default/1.1.x/node-type-menu-setting.png)

## How it is stored (config)

Persisted as a node-type **third-party setting**, not a standalone config object. The entity builder `menu_link_by_default_node_type_form_builder()` (in `menu_link_by_default.module`, registered via `$form['#entity_builders'][]`) calls `$type->setThirdPartySetting('menu_link_by_default', 'enable_menu_link_by_default', $value)`.

- Config key: lives in `node.type.{type}` under `third_party_settings.menu_link_by_default.enable_menu_link_by_default` (boolean).
- Schema: `node.type.*.third_party.menu_link_by_default` → `enable_menu_link_by_default: boolean` in `config/menu_link_by_default.schema.yml`.
- It exports/imports with the content type's config, so it deploys via config sync.

Set it programmatically:

```php
$type = \Drupal::entityTypeManager()->getStorage('node_type')->load('article');
$type->setThirdPartySetting('menu_link_by_default', 'enable_menu_link_by_default', TRUE);
$type->save();
```

## What it changes on the node form

`MenuLinkByDefaultHooks::formNodeFormAlter()` (hook `form_node_form_alter`) runs on new node add forms only, and does nothing unless:

- `$form['menu']['#access']` is truthy (the current user may use the menu widget), and
- `$node->isNew()` and the form operation is `default`.

When the bundle's third-party setting is TRUE it sets, on that build:

- `$form['menu']['#open'] = 1` — expands the collapsed "Menu settings" details, and
- `$form['menu']['enabled']['#default_value'] = 1` — pre-checks core's "Provide a menu link" checkbox.

That is the whole effect: it flips defaults. It does **not** create a menu link, choose a parent menu, or set the link title — core Menu UI still owns link creation, the parent selector (the content type's own "Default parent link"), and all access. Editors can still uncheck the box per node. Existing-node edits and non-`default` operations (e.g. revision forms) are untouched.

## Ordering

Both `#[Hook(...)]` implementations declare `order: new OrderAfter(modules: ['menu_ui'])`, and `menu_link_by_default_module_implements_alter()` (`#[LegacyModuleImplementsAlter]`) re-appends this module's `form_alter` last, so its defaults win over Menu UI's. The service `Drupal\menu_link_by_default\Hook\MenuLinkByDefaultHooks` is autowired (`menu_link_by_default.services.yml`) with `EntityTypeManagerInterface`.

## Operate it

1. Enable the module.
2. Edit a content type; under **Menu settings**, ensure a menu is checked under **Available menus**, then tick the module's checkbox and save.
3. Add new content of that type — the Menu settings section is open and "Provide a menu link" is pre-selected.
