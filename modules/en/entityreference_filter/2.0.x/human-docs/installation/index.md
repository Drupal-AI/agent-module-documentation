# Installation

## Requirements

Views Reference Filter needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Views** module (`views`) and **Field** module (`field`) — both enabled
  automatically as dependencies.
- No third-party libraries.

To actually use the filter you'll also need core's **Entity Reference** feature
(part of core) available, since the option list comes from an Entity Reference
view display.

> **Note on the release:** the current 2.0.x release is `2.0.0-beta7`, a beta.
> Test it before relying on it in production.

**Suggested (optional):**

- **Better Exposed Filters** — lets you rewrite/relabel the filter's options.
- **Search API** — enables the `entityreference_filter_search_api` submodule with
  a Search API variant of the filter.

## Install with Composer

From the project root:

```bash
composer require drupal/entityreference_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entityreference_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entityreference_filter -y
```

Drupal enables the `views` and `field` dependencies for you if they are not
already on.

## Optional submodule — Search API variant

If you use **Search API** and want the filter available on Search-API-based views,
enable the bundled submodule:

```bash
drush en entityreference_filter_search_api -y
```

## Next steps

There is no settings page. To start using it, build a reference view and add the
**"{Field} (entityreference filter)"** filter to a view — see the
[overview](../index.md#how-to-use-it).
