# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/twigsuggest -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/twigsuggest -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twigsuggest -y
```

That is all the setup there is. The module has no configuration form and no
permissions — the extra template suggestions become available immediately. From
here, turn on Twig debugging to see the new suggestions and create the matching
`.html.twig` files in your theme, as described in the
[overview](../index.md#how-to-use-it).

The module installs itself at a high weight (100) on purpose, so its suggestions
run after other modules' and take precedence.
