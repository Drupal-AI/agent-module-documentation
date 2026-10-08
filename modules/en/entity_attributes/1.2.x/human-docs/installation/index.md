# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Field** (`field`) and **System** (`system`) modules, both part of a
  standard Drupal install and enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_attributes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_attributes -y
```

## Verify it worked

After enabling, edit one of the supported entities (a node, block, menu link,
taxonomy term, or paragraph) and confirm the attributes field appears on its form.
If you don't see it, check the module's permissions at **People → Permissions**
(`/admin/people/permissions`) and grant your role the ability to manage entity
attributes. See the [overview](../index.md) for how to enter attributes in YAML.
