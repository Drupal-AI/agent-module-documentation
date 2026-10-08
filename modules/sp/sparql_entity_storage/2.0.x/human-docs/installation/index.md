# Installation

## Requirements

SPARQL Entity Storage needs RDF libraries and, crucially, an external triple-store:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Options** module (`options`) — the only Drupal module dependency,
  enabled automatically.
- Two PHP libraries, pulled in by Composer: **`sweetrdf/easyrdf`** (`^1.9`) and
  **`ml/json-ld`** (`^1.0`).
- **An external SPARQL 1.1 endpoint** — for example a running Virtuoso, Blazegraph,
  or other triple-store that Drupal can reach over HTTP. The module does not provide
  one; you must have an endpoint to connect to.

## Install with Composer

From the project root:

```bash
composer require drupal/sparql_entity_storage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the EasyRDF and
JSON-LD libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/sparql_entity_storage -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sparql_entity_storage -y
```

Enabling the module adds no user-facing feature on its own — it is a storage
backend for other modules (such as RDF Entity) to build on. Before it can do
anything you must point it at your SPARQL endpoint and set up graphs and mappings —
see [Configuration](../configuration/index.md).

There are no submodules (a `sparql_test` example entity ships only with the test
suite, for developers).
