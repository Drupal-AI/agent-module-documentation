# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Schema.org Metatag** module (`schema_metatag`) — the framework this module
  plugs into. It must be present and enabled, and it in turn builds on the
  contributed **Metatag** module.

There are no PHP‑library or other third‑party requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_publication_issue -W
```

The Composer package name (`drupal/schema_publication_issue`) matches the module's
machine name (`schema_publication_issue`). The `-W` (`--with-all-dependencies`)
flag lets Composer pull in Schema.org Metatag and update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_publication_issue -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_publication_issue -y
```

Enabling it will also enable `schema_metatag` (and Metatag) if they are not
already on.

## Verify it worked

Go to **Configuration → Search and metadata → Metatag → Settings**
(`/admin/config/search/metatag/settings`). Pick a content type and confirm you can
tick a **Schema.org: PublicationIssue** checkbox — that tells you the type is
registered and ready to map.
