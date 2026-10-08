# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal module dependencies, and no third‑party Composer or PHP library
  requirements. Drush is needed only if you want to use the command‑line reports.

> **Note:** this module is **not covered by Drupal's security advisory policy**,
> and its maintenance status is *Minimally maintained*. It is a developer
> introspection tool — keep it enabled only where you need it, and gate the
> reports behind the *Access site reports* permission.

## Install with Composer

From the project root:

```bash
composer require drupal/plugin_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plugin_report -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plugin_report -y
```

## Grant access

The report is protected by core's **Access site reports** permission. At
**People → Permissions** (`/admin/people/permissions`), give that permission to
any role that should view Plugin Report — typically administrators or developers.

## Verify it worked

Go to **Administration → Reports → Plugins**. You should see a filterable table of
every plugin manager on the site. Alternatively, run
`drush plugin-report:managers` and confirm it prints the list of managers.
