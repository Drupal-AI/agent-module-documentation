# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Several core and contrib modules that DCAT builds its entities and fields on.
  Composer and Drush resolve these automatically, but for reference they are:
  - **Core:** Taxonomy, Field, Filter, User, System, Datetime, Datetime Range,
    Telephone, Text, Link, Options.
  - **Contrib:** [Inline Entity Form](https://www.drupal.org/project/inline_entity_form)
    (`inline_entity_form`).
- The optional **DCAT Export** submodule uses the `easyrdf/easyrdf` library to build
  the RDF feed; Composer installs it when required.

## Install with Composer

From the project root:

```bash
composer require drupal/dcat -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer pull
in Inline Entity Form and update the other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dcat -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dcat -y
```

Enabling DCAT also enables its required core and contrib dependencies. Enabling it
creates the Dataset, Distribution, Agent, and vCard entity types and their
designated taxonomies.

## Submodules

DCAT ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **DCAT Export** | `dcat_export` | Serialises all your DCAT entities into a single RDF feed published at `/dcat`, gated by the *Access DCAT export feed* permission. Adds an export settings page. Enable it when you want to publish machine-readable catalog metadata to external systems or open-data portals. |

Enable it with:

```bash
drush en dcat_export -y
```

## Verify it worked

Log in as an administrator and go to **Structure → DCAT**
(`/admin/structure/dcat`) — you should see the DCAT admin area. Check the
**Content** area for the ability to add Datasets, Distributions, Agents, and
vCards. If you enabled DCAT Export, visit `/dcat` (with the export-feed permission)
to confirm the RDF feed responds. Then continue to
[Configuration](../configuration/index.md).
