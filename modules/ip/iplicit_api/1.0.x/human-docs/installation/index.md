# Installation

## Requirements

- **Drupal 10.3 or later, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.2 or later.**
- The **Key** module (`key`) version 1.19 or later — Composer installs it for you.
- An **Iplicit account with API access** (base URI, domain, username, and an API
  key issued by Iplicit).

## Install with Composer

From the project root:

```bash
composer require drupal/iplicit_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/iplicit_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iplicit_api -y
```

Drupal enables the Key module at the same time if it is not already on.

## Verify it worked

Go to **Configuration → Web services → Iplicit API**
(`/admin/config/services/iplicit`). If the settings form loads, the module is
installed. It will not connect to anything until you complete the steps in
[Configuration](../configuration/index.md).
