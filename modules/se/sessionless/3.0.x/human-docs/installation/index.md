# Installation

## Requirements

- **Drupal 10, or 11** (`core_version_requirement: ^10 || ^11`).
- No other contrib modules, PHP libraries or third-party Composer packages are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/sessionless -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sessionless -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sessionless -y
```

## After enabling

There is no configuration page — Sessionless is a developer API. Provide its signing
key/material securely through your environment (never commit it), then use the
module's token facilities from your own code. See the "How to use it" section of the
[main guide](../index.md).
