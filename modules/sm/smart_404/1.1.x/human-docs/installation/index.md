# Installation

## Requirements

- **Drupal 10.3 or higher, or Drupal 11** (`core_version_requirement:
  ^10.3||^11`).
- **PHP 8.1 or higher.**
- The **Redirect** module (`redirect`), version 1.9 or newer. You don't need to
  install this separately — it comes in automatically as a Composer dependency of
  Smart 404.

Optionally, the **Search 404** module: if it's present, Smart 404 can log 404s at
the exception level *before* Search 404 converts the response into a redirect or
search-results page, so no 404 slips past your statistics.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_404 -W
```

The Composer package name (`drupal/smart_404`) matches the module's machine name
(`smart_404`). The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
Redirect module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smart_404 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_404 -y
```

Drupal enables the Redirect module at the same time, since it is a dependency.

## Verify it worked

Smart 404 logs 404s as soon as it is enabled, with no further setup. To confirm,
visit a URL that doesn't exist on your site (for example `/this-page-is-not-real`),
then open the **404 overview** as an administrator — the path you just requested
should appear in the table. From there you can grant the module's permissions and
start creating redirects; see [Configuration](../configuration/index.md).
