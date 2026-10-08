<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Several **core modules** that the module depends on and enables automatically:
  Views, Block, Comment, Link and Options.
- The **Pathauto** contrib module (`drupal/pathauto`), used for the stable
  documentation URLs. Composer pulls it in for you with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Pathauto and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api -y
```

Enabling `api` will also enable its dependencies (Views, Block, Comment, Link,
Options and Pathauto) if they are not already on.

## Next steps

Enabling the module does nothing visible on its own — you have to define a Project
and a Branch and parse it before any documentation appears. Follow the workflow in
the [main guide](../index.md): configure parsing at
`/admin/config/development/api`, run the wizard, add branches, parse them (with
cron/queue running), and grant `access API reference` to the roles that should
read the docs.
