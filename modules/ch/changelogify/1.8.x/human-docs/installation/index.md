# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- **PHP 8.1 or higher.**
- Core modules: **datetime**, **node**, **options**, and **user** — Drupal enables
  these as dependencies automatically.
- No external libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/changelogify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/changelogify -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en changelogify -y
```

Changelogify begins capturing events immediately after it is enabled, but you
still need to configure tracking and publish your first release — see
[Configuration](../configuration/index.md).

## Verify it worked

As an administrator, visit `/admin/config/development/changelogify`. You should
reach the Changelogify dashboard. Make a change on the site (for example, edit a
node), then return to the dashboard — the event should appear, ready to be rolled
into a release. Grant the module's permissions at **People → Permissions**
(`administer changelogify`, `manage changelogify releases`, and
`view changelogify releases`) so the right roles can manage and view the
changelog.
