# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Domain** module (`domain`) and **Domain Access** (`domain_access`).
- Core's **Custom Menu Links** module (`menu_link_content`) — enabled
  automatically as a dependency.

There are no third-party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_menu_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_menu_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_menu_access -y
```

This also enables `domain`, `domain_access`, and `menu_link_content` if they are
not already on.

## Submodules

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Domain Menu Access — Menu Block** | `domain_menu_access_menu_block` | Integration with the contributed **Menu Block** module, so domain-filtered menus also work when rendered as Menu Block blocks. |

Enable it only if you use the Menu Block module:

```bash
drush en domain_menu_access_menu_block -y
```

## Verify it worked

Edit any menu link under **Structure → Menus** once you have added its menu to the
participating list (see [Configuration](../configuration/index.md)). You should
see a *Domain* section with the per-domain visibility checkboxes, and the menu
overview table should show a new *Domains* column.
