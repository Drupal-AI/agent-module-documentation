# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Drupal Commerce** (`drupal/commerce`, version **2.x or 3.x**) — this module extends
  Commerce, so it must be installed. Composer pulls it in as a dependency.
- The **Token** module (`drupal/token`), used for the token replacement in subjects and
  bodies; installed as a dependency.
- No PHP library requirements.

### Optional companions

The module suggests two modules for extra capability (install only if you want the
feature):

- **Advanced Queue** (`drupal/advancedqueue`) — use it as the backend for **queued**
  email sending. Without it, queued emails fall back to Drupal's core queue, processed on
  cron.
- **Commerce Recurring** (`drupal/commerce_recurring`) — adds a "Payment declined" email
  event for subscriptions.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Commerce and Token if they aren't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/commerce_email -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_email -y
```

Grant the **Administer commerce_email** permission to the roles that should manage store
emails, then head to [Configuration](../configuration/index.md) to create your first
email definition. There are no submodules.
