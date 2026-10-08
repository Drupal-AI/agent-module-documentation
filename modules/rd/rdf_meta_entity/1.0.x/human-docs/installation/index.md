# Installation

## Requirements

- **Drupal 9.3 or newer** (`core_version_requirement: >=9.3`).
- **PHP 7.4** or newer.
- The **Meta Entity** module (`meta_entity`) — the module this one extends.
- The **SPARQL Entity Storage** module (`sparql_entity_storage`), which provides
  the triplestore-backed entity storage.
- A working **SPARQL endpoint** (a triplestore such as Virtuoso) configured for
  your site. Without a triplestore behind SPARQL Entity Storage, the meta-entities
  have nowhere to live.

## Install with Composer

From the project root:

```bash
composer require drupal/rdf_meta_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies, and will bring in Meta Entity and SPARQL Entity Storage if they are
not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/rdf_meta_entity -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rdf_meta_entity -y
```

Drupal will enable `meta_entity` and `sparql_entity_storage` as dependencies at
the same time.

## Verify it worked

Visit **`/admin/structure/rdf-meta-entity`** as a user with the **Administer RDF
meta entity** permission and confirm the administration page loads. From there you
can define your first `rdf_meta_entity` type and map its fields to the SPARQL
backend. Make sure your SPARQL endpoint is reachable before defining and saving
meta-entity content.
