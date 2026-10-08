# Installation

## Requirements

- **Drupal 11.2** or newer (`core_version_requirement: ^11.2`).
- Core's **Media** module — required only if you want to use the Open Graph image
  feature (the image is read from a Media image reference field).
- No third-party Composer packages or PHP libraries are needed beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_wt_metatags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_wt_metatags -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_wt_metatags -y
```

## Prepare your fields first

Before the settings will do anything useful, make sure the fields you want to read
exist on your content types and vocabularies:

- For the **meta description / Open Graph description**, add (or reuse) a **Text
  (plain, long)** field.
- For the **Open Graph image**, add (or reuse) a **Media (image)** reference field
  with the allowed number of values limited to 1.

Then head to [Configuration](../configuration/index.md) to point the module at those
field machine names.
