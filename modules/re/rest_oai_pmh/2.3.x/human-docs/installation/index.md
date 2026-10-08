# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Views** (`views`) and **RESTful Web Services** (`rest`) modules —
  enabled automatically as dependencies.
- A **metadata source** for the format you want to serve:
  - For Dublin Core from RDF mappings (the `dublin_core_rdf` map), the core **RDF**
    module.
  - For Dublin Core from Metatag (the `dublin_core_metatag` map), the **Metatag**
    (and typically **Schema.org Metatag**) modules.
  - MODS is served from a dedicated View you configure.
- At least one **View with an *Entity Reference* display** — that is the display
  type the settings form offers to expose.

There are no third‑party Composer requirements. Optionally,
`discoverygarden/dgi_image_discovery` provides thumbnail‑URL discovery for
RDF‑based Dublin Core output.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_oai_pmh -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_oai_pmh -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_oai_pmh -y
```

If you plan to serve Dublin Core, also enable your chosen metadata source, for
example the core RDF module:

```bash
drush en rdf -y
```

## Next steps

Enabling the module installs the OAI‑PMH REST resource, but the endpoint returns
403 and serves nothing until you grant a permission, pick Views, and build the
index. Continue to [Configuration](../configuration/index.md).
