# Installation

## Requirements

Ludwig depends only on Drupal core:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no third-party Composer packages or other contributed modules required.

## Installing Ludwig itself

There's a chicken-and-egg note worth calling out: Ludwig exists for non-Composer
sites, but the module itself still has to get onto your site somehow. If you do
have Composer available, the simplest way is:

```bash
composer require drupal/ludwig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. On a site with no Composer at all, download the Ludwig
project from its [drupal.org page](https://www.drupal.org/project/ludwig) and
place it in your modules directory (for example `modules/contrib/ludwig`) by hand.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ludwig -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ludwig -y
```

## Next steps

Ludwig has nothing to configure. To use it, enable a module that ships a
`ludwig.json` file and then visit **Reports → Packages**
(`/admin/reports/packages`) to download its libraries — see the
[overview](../index.md#how-to-use-it) for the workflow.

Remember: this 2.0.x release has **no Drush command** — downloads happen only by
visiting the Packages report page, and the module directory must be writable for
those downloads to succeed.

There are no submodules.
