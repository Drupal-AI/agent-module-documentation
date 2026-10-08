# Installation

## Requirements

Menu Force is lightweight and has no third-party libraries:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Menu UI** module (`menu_ui`) enabled — this is a hard dependency (it
  provides the *Menu settings* Menu Force makes mandatory), and Drupal enables it
  automatically when you turn on Menu Force.

There are no Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_force -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_force -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_force -y
```

Enabling the module doesn't change anything on its own — no content type becomes
menu-mandatory until you turn the requirement on. See the
[overview](../index.md#how-to-use-it) for how to enable it per content type on the
**Menu settings** tab.

## Submodule — enable only if you need it

Menu Force ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Menu Force Taxonomy Menu UI** | `menu_force_taxonomy_menu_ui` | Extends the same "menu placement is mandatory" behavior to taxonomy terms. It works together with the contrib [Taxonomy Menu UI](https://www.drupal.org/project/taxonomy_menu_ui) module, so install and enable that too if you use this. |

Enable it with:

```bash
drush en menu_force_taxonomy_menu_ui -y
```
