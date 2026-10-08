# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Drupal core's **Node** (`node`) and **Field** (`field`) modules — both are
  standard on any content site and are enabled automatically as dependencies.

No external libraries or third-party APIs are required. **Metatag** and
**Schema.org Blueprints** are recommended companions but optional.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonld_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonld_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonld_generator -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Search and metadata →
JSON-LD Generator**. You should see the settings form listing your content types.
Enable one, pick a Schema.org `@type`, save, then view a node of that type and look
at the page source — you should find a `<script type="application/ld+json">` block
in the `<head>` containing the generated structured data.

Next, see [Configuration](../configuration/index.md) to set up each content type.
