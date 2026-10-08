# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1 or newer**.
- The **Token** module (`drupal/token`, `^1.17`) — Composer installs it for you.
- Core's **Field**, **Filter**, and **Text** modules, which are part of a standard
  Drupal install.

Optionally, the **Token Filter** module pairs well with Smart Trim's "Replace
tokens before trimming" option if you want tokens rendered inside filtered text.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_trim -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_trim -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_trim -y
```

Smart Trim ships **no submodules**. Once enabled, the **"Smart trimmed"** format
becomes available on the **Manage display** screen for supported fields — there's
nothing else to turn on. Continue with [Configuration](../configuration/index.md).
