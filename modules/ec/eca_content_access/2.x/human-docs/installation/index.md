# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **ECA** base module (`eca`, `^2 || ^3`).
- The **Content Access** module (`content_access`, `^2`).

Both dependencies are pulled in automatically when you require this module with
Composer. You will also want one of ECA's modelling tools (BPMN.iO or the ECA
Classic Modeller) installed so you have a UI in which to build models.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_content_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ECA and Content
Access and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_content_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_content_access -y
```

This also enables `eca` and `content_access` if they are not already on.

## Verify it worked

Open an ECA model at **Configuration → Workflow → ECA** and confirm the Content
Access actions/conditions this module provides appear in the palette. Before you
rely on any access rule in production, test it against real user roles — including
users who should be denied — as described in the main guide.
