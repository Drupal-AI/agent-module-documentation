# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **ConsentX account** — the module is a connector to the ConsentX cloud
  platform.
- An **internet connection** so the site can communicate with ConsentX services.
- No other Drupal modules or PHP libraries are required.

This project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/consentx -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/consentx -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en consentx -y
```

## Verify it worked

After enabling, open the module's settings and connect your ConsentX account (see
[Configuration](../configuration/index.md)). Once connected, the site registers
with ConsentX automatically and the consent banner should appear on the front end
immediately.
