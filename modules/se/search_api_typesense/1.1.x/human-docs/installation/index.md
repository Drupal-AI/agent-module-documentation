# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: >10.3 || ^11`).
- The **Search API** module (`search_api`).
- A running **Typesense** server that Drupal can reach, plus its API key.

## Download and run Typesense

You need a Typesense instance before the module is useful. Download and install
Typesense from its own project, or — if you develop with DDEV — use the community
add-on, which downloads and runs Typesense inside DDEV for you:

```bash
ddev add-on get lussoluca/ddev-typesense
```

## Install the module with Composer

From the project root:

```bash
composer require drupal/search_api_typesense -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_typesense -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_typesense -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search API**. You should now be able
to create a new server using the **Typesense** backend. From there, follow
[Configuration](../configuration/index.md) to connect to your Typesense instance,
create an index, and complete the required schema step.
