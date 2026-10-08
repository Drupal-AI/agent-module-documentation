# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10`).
- Core's **Path Alias** module (`path_alias`) — the only dependency, part of core.

There are no third-party Composer or PHP library requirements.

> **Before you rely on this module:** it is marked **unsupported / obsolete**, its
> stable release is **not covered** by Drupal's security advisory policy, and its
> UI is in Spanish. Consider these points before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/search_replace_aliases -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_replace_aliases -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_replace_aliases -y
```

## Verify it worked

As a user with the **Administer site configuration** permission, visit
`/admin/config/search/path/replace`. You should see the search-and-replace form.
Because this is a destructive bulk operation, test it against a small, specific
fragment first and review the preview before confirming.
