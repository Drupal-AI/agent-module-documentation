# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- Core modules **Taxonomy**, **Options**, **Field**, **Language** and **Content
  Translation** — all dependencies, needed for the translatable vocabularies and
  the dependent reference fields.
- The **`yasseralsamman/saudi-national-address`** Composer package, which supplies
  the actual region/city/district dataset the module imports.

There are no additional third‑party library requirements.

## Install with Composer

First require the dataset package, then the module (or both together):

```bash
composer require yasseralsamman/saudi-national-address
composer require drupal/saudi_national_address -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the core module
dependencies and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/saudi_national_address -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en saudi_national_address -y
```

## Import the reference data

Enabling the module creates the empty vocabularies; you then seed them from the
dataset package. The import is idempotent, so it is safe to run again:

```bash
drush sna:import          # seed regions / cities / districts
drush sna:import --purge  # wipe and re-import fresh data
drush sna:purge           # delete all SNA terms
```

You can also import from the admin UI at **Configuration → Regional → Saudi
National Address** (`/admin/config/regional/sna`), which requires the `administer
sna data` permission. Either way the import runs through the Batch API so large
datasets do not time out.

## Optional: Select2 dependent selects

An optional Select2 submodule enhances the cascading region → city → district
selects with a nicer search‑as‑you‑type experience. Enable it if you want that.

## Verify it worked

After importing, smoke‑test the data with the resolver's Drush commands:

```bash
drush sna:resolve <districtId>   # resolve a full hierarchy from an 11-digit district ID
drush sna:reverse <lat> <lng>    # reverse-geocode a coordinate to region/city/district
```

You should get back a populated region → city → district hierarchy. Continue to
[Configuration](../configuration/index.md) to wire up the fields and resolver.
