# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Block** module (standard on most sites) so you can place the generated
  component blocks.

There are no contrib dependencies and no third‑party Composer or PHP libraries.
Your own components will, of course, bring whatever front‑end libraries they need
(declared in each component's `libraries` block).

## Install with Composer

From the project root:

```bash
composer require drupal/js_component -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/js_component -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en js_component -y
```

There are no submodules. After enabling, define your first component in a
`*.js_component.yml` file and clear caches so it is discovered — see
[Configuration](../configuration/index.md).
