# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **REST** module (`rest`), which Drupal enables automatically as a
  dependency when you turn on Mautic API.
- A reachable **Mautic** instance and its **API credentials** (Mautic's API access
  must be enabled on the Mautic side).

Note this module is **not covered by Drupal's security advisory policy** — weigh
that before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/mautic_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mautic_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mautic_api -y
```

Drupal will enable core's **REST** module at the same time if it isn't already on.

## Verify it worked

Because Mautic API is a connectivity layer, the real test is adding a connection:
head to [Configuration](../configuration/index.md), create a Mautic connection with
valid credentials, and confirm Drupal can authenticate to your Mautic instance.
Other Mautic modules (such as Commerce Mautic) will then be able to use that
connection.
