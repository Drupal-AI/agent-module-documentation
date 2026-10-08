# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/betasite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/betasite -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en betasite -y
```

## Submodules — enable only what you need

Beta Site ships several optional submodules. Turn on only the ones you want with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Toggle Block** | `betasite_toggle_block` | A block (and an AJAX `/beta-link` endpoint) that switches a visitor between the standard and beta version of the current page. |
| **Switches** | `betasite_switches` | Its own routes and permissions for additional switching controls. |
| **Layout Builder** | `betasite_layout_builder` | Layout Builder support for beta content. |
| **Menu Breadcrumb** | `betasite_menu_breadcrumb` | Breadcrumb handling aware of beta paths. |
| **Menu Trail by Path** | `betasite_menu_trail_by_path` | Sets the active menu trail based on the path. |

For example, to add the toggle control:

```bash
drush en betasite_toggle_block -y
```

Each submodule requires the base Beta Site module, which is already present once
you have installed it above.
