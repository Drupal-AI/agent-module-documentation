# Installation

## Requirements

- **Drupal 10.1 or newer, or Drupal 11** (`core_version_requirement:
  ^10.1 || ^11`).
- The **Facets** module (`drupal/facets` `^2.0 || ^3.0`) — the module this one
  extends. Composer installs it automatically.
- Core's **Views** (`views`) and **System** (`system`) modules — both standard.

There are no third-party Composer libraries and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/core_views_facets -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer pull
in the Facets module and reconcile any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/core_views_facets -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en core_views_facets -y
```

Enabling Core Views Facets also enables the **Facets** module if it isn't on
already, since it's a dependency.

## Verify it worked

You need a Views **page** display with at least one exposed or contextual filter
for anything to appear. Once you have one, go to **Configuration → Search and
metadata → Facets** (`/admin/config/search/facets`) and look at the **facet
sources** — your view display should now be listed (typically twice: one source
for its exposed filters and one for its contextual filters). If you don't see it,
run `drush cr` after editing the view so the sources refresh.

Next, follow [Configuration](../configuration/index.md) to turn that source into
working facets — in particular the required URL-processor step.
