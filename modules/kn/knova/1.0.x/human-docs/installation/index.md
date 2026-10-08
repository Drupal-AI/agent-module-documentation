# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 7.4 or higher.**
- Core's **Config** and **User** modules (`config`, `user`) — part of core and
  enabled automatically as dependencies.
- An **OpenAI API key** with available credits.

No extra Drupal modules, JavaScript frameworks, or PHP libraries are required.
**Token**, **Path**, and **Views** are optional enhancements — Knova works fully
without them.

## Install with Composer

From the project root:

```bash
composer require drupal/knova -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/knova -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en knova -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Services → Knova
Settings**. If the settings page loads, the module is installed — continue to
[Configuration](../configuration/index.md) to add your OpenAI API key and enable
the widget. (The widget will not appear on the front end until it is enabled and a
key is set.)
