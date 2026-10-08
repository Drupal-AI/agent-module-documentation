# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **LocalGov Drupal** site with a services directory to publish (typically built
  with **LocalGov Directories**).
- These modules, which Composer and Drupal pull in as dependencies:
  - core **Serialization** (`serialization`), **REST** (`rest`) and **Views**
    (`views`)
  - **Search API** (`search_api`) and its database backend (`search_api_db`)
  - **Facets** (`facets`)
  - **Geo Entity — Address** (`geo_entity_address`, from the Geo Entity project)

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_openreferral -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
Search API, Facets and Geo Entity dependencies alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_openreferral -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_openreferral -y
```

Drupal will enable the dependency modules (Serialization, REST, Views, Search API,
Facets and Geo Entity Address) at the same time.

## Verify it worked

After enabling, map at least one content type to the Open Referral **Organisations**
and **Services** types — the quickest route is to enable the matching **LocalGov
Directories** submodules, which configure this for you. Then index your directory
content through **Search API** and request the Open Referral endpoints. Confirm the
returned data is complete and — importantly — that it exposes only the public
directory fields you intend to share.
