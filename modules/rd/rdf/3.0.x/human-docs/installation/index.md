# Installation

## Requirements

RDF is lightweight and depends only on Drupal core:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- No other modules are required, and there are no submodules.

The `easyrdf/easyrdf` library is suggested only as a development dependency used by
the module's tests to parse RDFa output — it is not needed to run the module on a
live site.

## Install with Composer

From the project root:

```bash
composer require drupal/rdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rdf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rdf -y
```

That is all it takes. RDF has no configuration form and no permissions to grant. Its
default mappings for core's article, page, forum, user, tags, and comment bundles
begin producing RDFa metadata immediately. To describe your own content types or
fields, or to add namespace prefixes, work in configuration and code as outlined in
the [overview](../index.md#how-to-use-it) and the sibling
[`agent/`](../agent/start.md) docs.
