# Installation

## Requirements

Menu Item Extras builds on core modules only:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Block** (`block`), **Menu Link Content** (`menu_link_content`), and
  **Text** (`text`) modules. Drupal enables these automatically as dependencies when
  you turn on Menu Item Extras.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_item_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_item_extras -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_item_extras -y
```

As soon as it's enabled, menu links become fieldable — each link gains a body field
and a view‑mode selector on its edit form. Head to
[Configuration](../configuration/index.md) to add your own fields and set up per‑menu
view modes.

## Optional demo submodule

Menu Item Extras ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **MIE Demo Base** | `mie_demo_base` | A worked mega‑menu example — sample menu, fields, view modes, and templates — so you can see a rich menu set up end to end and copy the pattern. |

Enable it only if you want the demo content:

```bash
drush en mie_demo_base -y
```

## Uninstalling later

Because the module stores extra field data on your menu links, an uninstall validator
blocks removal until that data is cleared. Clear it from the UI at
`/admin/modules/uninstall/extra_data/menu_item_extras`, per‑menu at
`/admin/structure/menu/manage/{menu}/clear`, or with Drush:

```bash
drush menu-item-extras-clear-extra-data main
```

(replacing `main` with the menu's machine name).
