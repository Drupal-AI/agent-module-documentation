# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Migrate** module (`migrate`).
- The contributed **Migrate Tools** module (`drupal/migrate_tools`) — the Preview
  tab is added to Migrate Tools' migration view page.

There are no additional PHP library requirements of its own.

> **Security coverage:** this module's releases are **not covered** by Drupal's
> security advisory policy. Prefer using it in development environments rather
> than production.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Tools and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_preview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_preview -y
```

Drupal enables core Migrate and Migrate Tools automatically as dependencies if
they are not already on.

## Verify it worked

Confirm the module is enabled (**Extend** page, or
`drush pm:list --status=enabled`). Then open a migration's **View** page and look
for the new **Preview** tab (see "How to use it" on the
[overview page](../index.md)). There is no configuration form to fill in.
