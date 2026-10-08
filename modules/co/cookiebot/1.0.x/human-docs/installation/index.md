# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **JS Cookie** module (`drupal/js_cookie` ^1.0 || ^2.0) — the only
  dependency, pulled in by Composer.
- A **Cookiebot account** with a Domain Group ID (CBID). You create this in the
  Cookiebot (Usercentrics) Manager; the module needs it to load the service. The
  consent UI, scanning and blocking run on Cookiebot's servers.

## Install with Composer

From the project root:

```bash
composer require drupal/cookiebot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `drupal/js_cookie`
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookiebot -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookiebot -y
```

## Grant the permission

Go to **People → Permissions** (`/admin/people/permissions`) and grant **Administer
cookiebot settings** to the roles that should be able to change consent settings
(administrators, typically).

## Next step

The module does nothing until you enter your CBID on the settings form. See
[Configuration](../configuration/index.md).
