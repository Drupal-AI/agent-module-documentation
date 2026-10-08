# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Search** module (`search`), enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements. The PECL `stem`
extension is used automatically *if present* for speed, but it is entirely
optional — the module ships a pure-PHP implementation that produces the same
result.

## Install with Composer

From the project root:

```bash
composer require drupal/porterstemmer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/porterstemmer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en porterstemmer -y
```

There are no submodules and nothing to configure.

## Important: rebuild the search index

Stemming only applies to content indexed *after* the module is enabled. To stem
your existing content, rebuild the core search index — go to
**Configuration → Search and metadata → Search pages** and rebuild it, or let cron
re-index over time. Until the index is rebuilt, older content will not benefit from
stemming.
