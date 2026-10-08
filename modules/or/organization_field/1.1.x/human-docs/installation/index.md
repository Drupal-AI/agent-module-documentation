# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contributed module dependencies and no extra PHP libraries. The module talks
  to the ROR REST API over the network, so the site needs outbound HTTP access to
  reach `ror.org` (or whichever ROR API endpoint you configure).

## Install with Composer

From the project root:

```bash
composer require drupal/organization_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/organization_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en organization_field -y
```

## Verify it worked

Log in as an administrator and visit
`/admin/config/content/organization_field` — you should see the module's settings
form. Then add an Organization field to a content type and confirm that typing an
organization name in the widget returns suggestions from ROR. If you plan to tune
the API endpoint or result count first, see
[Configuration](../configuration/index.md).
