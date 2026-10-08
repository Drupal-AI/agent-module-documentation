# Installation

## Requirements

- **Drupal 11.1 or 12** (`core_version_requirement: ^11.1 || ^12`).
- Core's **Help** (`help`) module — the Help Topics system this module extends.
- Core's **Filter** (`filter`) module — used to render topic bodies through a text
  format.
- Optional: core's **Configuration Translation** module, if you want your topics to
  be translatable.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_help -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_help -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_help -y
```

Core's Help and Filter modules are enabled as dependencies if they aren't already.

## Set the permission

Grant the **administer config help** permission to the roles that should manage
help topics, at **People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Go to **Configuration → Development → Configurable Help**
(`/admin/config/development/config-help`) and confirm the topic collection loads
with an option to add a topic. Create a test topic, mark it top-level, and check it
appears on **/admin/help**. See [Configuration](../configuration/index.md) for the
full field-by-field walkthrough.
