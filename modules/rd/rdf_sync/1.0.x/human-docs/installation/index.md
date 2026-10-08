# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Serialization** module (`serialization`), which RDF Sync depends on and
  which is enabled as a dependency.
- An external **RDF backend / triplestore** with a SPARQL endpoint (query,
  update, and graph-store paths) that your site can reach, plus any credentials it
  requires.

There are no third-party Composer or PHP library requirements beyond the above.

## Install with Composer

From the project root:

```bash
composer require drupal/rdf_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/rdf_sync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rdf_sync -y
```

Core's Serialization module is enabled automatically as a dependency.

## Verify it worked

Visit **Configuration → System → RDF Sync** (`/admin/config/system/rdf-sync`)
and confirm the settings form loads. Once you have entered your endpoint details
and defined a mapping (see [Configuration](../configuration/index.md)), save a
mapped entity and check that the expected triples appear in your triplestore.
