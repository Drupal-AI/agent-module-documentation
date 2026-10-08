# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **File** module (`file`) — enabled automatically as a dependency.
- The **ImageAPI Optimize** module (`imageapi_optimize`, also listed on
  drupal.org as *Image Optimize*) — this module is a processor for it, so it must
  be present. Composer pulls it in as a dependency.
- **Outbound network access** to the external Dev Weapons API, which generates
  the SVG placeholders.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/imageapi_optimize_sqip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including ImageAPI Optimize if it is not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imageapi_optimize_sqip -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imageapi_optimize_sqip -y
```

This also enables ImageAPI Optimize and core File if they are not already on.

## Verify it worked

Go to **Configuration → Media → Image Optimize pipelines**
(`/admin/config/media/imageapi-optimize-pipelines`), edit or create a pipeline,
and confirm that **SQIP** now appears in the list of processors you can add. See
the "How to use it" section of the [overview](../index.md) for wiring it into a
pipeline.
