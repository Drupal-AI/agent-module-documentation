# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1** or newer.
- The PHP **zip** extension (`ext-zip`) — used to build the Solr config archive
  that's uploaded to opensolr.
- The **Search API Solr** module, version **4.3.2 or newer**
  (`drupal/search_api_solr:>=4.3.2`), which in turn brings Search API. Composer
  pulls it in and Drupal enables it as a dependency.
- An **opensolr.com** account. Create one at
  [opensolr.com/register](https://opensolr.com/register) (a 15-day free trial, no
  card required) — the module's *Get started* page links you there.
- Optional: the **Key** module (`drupal/key`) if you want to store your opensolr
  API key as a Key entity rather than as raw config.

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

### Optional: the Key module for the API key

To store your opensolr API key as a Key entity, install and enable Key:

```bash
composer require drupal/key
drush en key -y
```

With Key enabled, the settings form gains a **"Store the API key with the Key
module"** checkbox. This integration is an **explicit opt-in** — merely installing
Key does not change how the key is stored until you tick that box. The Key entity
can source its value from an environment variable or file rather than from config.
(While the opt-in is on you cannot uninstall Key without first switching back to
direct storage — the module guards against it, since the Key entity holds the live
API key.)

## Submodule — per-core security

An optional submodule manages per-core HTTP Basic Auth credentials and IP
allow-lists on opensolr:

```bash
drush en search_api_opensolr_security -y
```

After enabling, enter your opensolr credentials and run the setup flows — see
[Configuration](../configuration/index.md).
