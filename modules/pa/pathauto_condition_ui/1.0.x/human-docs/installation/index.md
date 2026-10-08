# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4||^10||^11`).
- The **Pathauto** module
  ([`pathauto`](https://www.drupal.org/project/pathauto)) — the required
  dependency. Pathauto is a separate contrib project (it in turn requires the
  Token module), so Composer will pull it in for you with the `-W` flag below.

There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pathauto_condition_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Pathauto (and
Token) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/pathauto_condition_ui -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pathauto_condition_ui -y
```

Drupal will enable Pathauto (and Token) at the same time if they aren't already
on.

## Verify it worked

Go to the Pathauto settings area under **Configuration → Search and metadata →
URL aliases**. You should now see the condition‑management UI alongside the
Pathauto pattern settings, where you can add, edit, and remove conditions.
