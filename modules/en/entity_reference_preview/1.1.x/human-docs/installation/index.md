# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies beyond core, and no third‑party Composer or PHP library
  requirements. To get the most from it you will want core's **Content
  Moderation** workflow in use, since the module is about previewing draft
  revisions.

This release line is `1.1.0-beta1`, a beta — test it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_preview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_preview -y
```

## Verify it worked

Go to **Configuration → Content authoring → Entity Reference Preview**
(`/admin/config/content/entity-reference-preview`). If the settings form loads, the
module is installed. From there, continue to [Configuration](../configuration/index.md)
to turn on the preview formatter, the toolbar/block button, and Views preview.
