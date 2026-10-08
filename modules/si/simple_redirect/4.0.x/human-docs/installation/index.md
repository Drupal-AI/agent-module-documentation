# Installation

## Requirements

Simple Redirect is deliberately minimal. It needs:

- **Drupal 8.9, 9, or 10** (`core_version_requirement: >=8.9 < 11.0.0-stable`).
  Note that it is **not** yet marked compatible with Drupal 11.
- No other modules, and no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/simple_redirect`,
matches the module's machine name, `simple_redirect`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_redirect -y
```

## Verify it worked

Log in as a user with the **Administer site configuration** permission and go to
`/admin/config/search/simple-redirect`. You should see the Simple Redirect list
page with an **Add Simple Redirect** button. Create a redirect, then visit the
"from" path in your browser — you should be forwarded to the "to" path. See
[Configuration](../configuration/index.md) for the details.
