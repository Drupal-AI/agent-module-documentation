# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.0** or newer.
- Core's **Toolbar** module (`toolbar`), which Drupal enables automatically as a
  dependency — this is where the Design System link appears.

There are no third-party Composer or PHP library requirements. The Gin admin
toolbar is supported if present, but it is optional.

## Install with Composer

From the project root:

```bash
composer require drupal/design_system -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/design_system -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en design_system -y
```

## Verify it worked

After enabling, set the target URL and grant the viewing permission as described in
[Configuration](../configuration/index.md). Then log in as a user who has the
**`access design system`** permission — you should see a **Design System** link in
the admin toolbar that opens your configured page embedded at
`/admin/design-system`.
