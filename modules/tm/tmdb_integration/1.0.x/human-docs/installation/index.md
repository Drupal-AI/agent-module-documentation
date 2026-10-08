# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- No other Drupal modules are required.
- A **TheMovieDB (TMDb) account** and an API access token (or API key) from your
  TMDb account settings — you enter this during
  [configuration](../configuration/index.md).

> **Note:** This project is marked as not covered by Drupal's security advisory
> policy, and it is an unofficial integration. Review it before using it on a
> production site.

## Install with Composer

From the project root:

```bash
composer require drupal/tmdb_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmdb_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The download directory is `tmdb_integration`, but the module's machine name is
**`movie_db`** — so that is the name you enable:

```bash
drush en movie_db -y
```

## Verify it worked

Log in as an administrator and visit **`/admin/movie_db/settings`**. If the
settings form appears, the module is installed. Enter your TMDb base URL and access
token (see [Configuration](../configuration/index.md)) before expecting the search
page or blocks to return results.
