# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1** or newer.
- The PHP **zip** extension (`ext-zip`) — used to build the Solr config archive
  that's uploaded to opensolr.
- The **Search API Solr** module, version **4.3.2 or newer**
  (`drupal/search_api_solr:>=4.3.2`), which in turn brings Search API. Composer
  pulls it in and Drupal enables it as a dependency.
- An **opensolr.com** account (or register one from within Drupal via the
  *Get started* form).
- Recommended: the **Key** module (`drupal/key`) to store your opensolr API key
  securely rather than as raw config.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_opensolr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (such as Search API Solr) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_opensolr -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_opensolr -y
```

### Recommended: the Key module for the API key

To keep your opensolr API key out of plain configuration, install and enable Key:

```bash
composer require drupal/key
drush en key -y
```

With Key enabled, the settings form lets you store the API key as a Key entity,
which can source its value from an environment variable or file rather than from
config.

## Submodule — per-core security

An optional submodule manages per-core HTTP Basic Auth credentials and IP
allow-lists on opensolr:

```bash
drush en search_api_opensolr_security -y
```

After enabling, enter your opensolr credentials and run the setup flows — see
[Configuration](../configuration/index.md).
