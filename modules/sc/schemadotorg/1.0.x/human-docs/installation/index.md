# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Several core modules that the base module depends on and enables automatically:
  **Node**, **User**, **Field**, **Datetime**, **Image**, **Link**, **Options**,
  **Telephone**, and **Text**. These are the field types it uses when generating
  fields from Schema.org properties.

There are no third-party Composer or PHP library requirements for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/schemadotorg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schemadotorg -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schemadotorg -y
```

### Enable the UI submodule to add mappings by hand

The base module is programmatic — it has **no form for adding mappings**. If you
want to create mappings by clicking through the admin UI (rather than via Drush),
also enable the UI submodule:

```bash
drush en schemadotorg_ui -y
```

### The rest of the suite

Schema.org Blueprints ships around 50 submodules — for JSON-LD output, JSON:API,
node/taxonomy/media/paragraphs integration, and many contrib-module bridges. None
are required to use the base module, and they are out of scope for this guide.
Enable only the ones your project needs, one at a time, and check each one's own
documentation.

## Next steps

Head to **Configuration → Schema.org** (`/admin/config/schemadotorg`) to review the
settings and create your first mapping — see [Configuration](../configuration/index.md).
