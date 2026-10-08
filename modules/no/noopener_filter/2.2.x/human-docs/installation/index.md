# Installation

## Requirements

Noopener Filter is deliberately lightweight. It needs only **Drupal 8, 9, 10, or
11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`) — the module depends on
`drupal/core` and nothing else. There are no third-party Composer or PHP library
requirements and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/noopener_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/noopener_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en noopener_filter -y
```

Enabling the module does not change anything on its own — you still need to turn
on the filter for the text formats you want to protect, and (optionally) enable
the global link-alter option. See [Configuration](../configuration/index.md) for
both steps.
