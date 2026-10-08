# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/open_vocabularies -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/open_vocabularies -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en open_vocabularies -y
```

## Verify it worked

After enabling, grant the module's permission to the appropriate roles at
**People → Permissions**, then add an **open vocabulary** field to a content type
under **Structure → Content types → *(type)* → Manage fields**. Being able to add
that field type and create an association confirms the module is working. See the
[overview](../index.md) for the full workflow.
