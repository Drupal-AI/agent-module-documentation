# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Schema.org Metatag** module (`schema_metatag`) — the framework this module
  plugs into. It must be present and enabled, and it in turn builds on the
  contributed **Metatag** module.

There are no PHP‑library or other third‑party requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_software_application -W
```

The Composer package name (`drupal/schema_software_application`) matches the
module's machine name (`schema_software_application`). The `-W`
(`--with-all-dependencies`) flag lets Composer pull in Schema.org Metatag and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_software_application -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_software_application -y
```

Enabling it will also enable `schema_metatag` (and Metatag) if they are not
already on.

## Verify it worked

Go to **Configuration → Search and metadata → Metatag**
(`/admin/config/search/metatag`), edit a content type's meta tags, and confirm you
see a **Schema.org: SoftwareApplication** section among the available fields.
