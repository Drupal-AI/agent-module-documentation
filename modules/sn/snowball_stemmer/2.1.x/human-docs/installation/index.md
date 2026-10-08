# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **`wamania/php-stemmer`** PHP library (`^2.0 || ^3.0`). This is a Composer
  dependency, so installing the module with Composer (below) pulls it in
  automatically — you do not fetch it separately.
- To stem a Search API index you will of course need the
  [Search API](https://www.drupal.org/project/search_api) module and an index.
  Core Search integration works with Drupal core's own Search module.

## Install with Composer

Always install this module with Composer so the required stemmer library comes
with it. From the project root:

```bash
composer require drupal/snowball_stemmer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/snowball_stemmer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en snowball_stemmer -y
```

For Drupal **core Search**, that is all you need — stemming is applied
automatically. For a **Search API** index you still need to enable the processor
on the index and re-index; see the *How to use it* section on the
[overview page](../index.md).
