# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The module's README lists a few supporting modules to have available:
  - **Entity** (`entity`) — used by the module.
  - **Cache control override** — so the like count can update independently of a
    cached page.
  - **JS Cookie** — required for the 2.x branch.
- **Font Awesome** — Like uses Font Awesome icons. Provide it however you already
  load Font Awesome on your site (for example the Font Awesome module).
- **Antibot** *(optional)* — install it to protect the Like element against
  malicious/automated submissions; Like integrates with it automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/like -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/like -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en like -y
```

## Verify it worked

Go to **Configuration → User interface → Like**
(`/admin/config/user-interface/like`) and confirm the settings form loads and
lists your entity types. Then enable Like for one type, place the Like element on
that bundle's display (see [Configuration](../configuration/index.md)), and view a
piece of content — you should see the Like button and its count.
