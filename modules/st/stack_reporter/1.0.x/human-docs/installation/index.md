# Installation

## Requirements

- **Drupal 9.4 or higher** (through 11) — `core_version_requirement: ^9 || ^10 || ^11`.
- **PHP 8.0 or higher**.
- No other module dependencies.
- **Optional, for Node.js reporting:** PHP's `exec()` function must be enabled and
  Node.js must be installed and reachable on the server. Without those, the Drupal
  and PHP versions are still reported but the Node version is not.

Note: this module is not currently covered by Drupal's security advisory policy, so
review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/stack_reporter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/stack_reporter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stack_reporter -y
```

Or enable **Stack Reporter** from the Extend page (`/admin/modules`).

## Verify it worked

Go to **Configuration → System → Stack Reporter**
(`/admin/config/system/stack-reporter`) and set an API key (see
[Configuration](../configuration/index.md)). Then call
`/api/v1/stack-reporter?apikey=your_api_key` and confirm you get back a JSON
document with the Drupal and PHP versions. Calling it without the key should be
refused.
