# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`) — RIP works
  across a very wide range of core versions, which is handy since you often reach for it right
  before or after a major upgrade.

There are no module dependencies and no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/rip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rip -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rip -y
```

There is no configuration to do. Head to the [main page](../index.md#how-to-use-it) for how
to run the cleanup with Drush or the `/admin/people/rip` form. Access to that form is
governed by core's **Administer permissions** permission.

## Uninstall when you're done

RIP is a one-shot maintenance tool. After you have cleaned up your roles and exported
configuration, you can remove it:

```bash
drush pmu rip -y
```
