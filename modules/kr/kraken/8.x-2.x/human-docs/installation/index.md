# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3.0 || ^11`).
- The **Image Optimize** module (`imageapi_optimize`) — a contrib dependency that
  provides the pipeline/processor system this module plugs into.
- A **Kraken.io account** with an **API key** and **API secret**.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/kraken -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Image Optimize and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/kraken -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en kraken -y
```

Enabling Kraken.io will also enable Image Optimize if it isn't already on.

## Verify it worked

Log in as an administrator and go to **Configuration → Media → Image Optimize
pipelines** (`/admin/config/media/imageapi-optimize-pipelines`). Create or edit a
pipeline, click to add a processor, and confirm **Kraken** appears in the
processor list. If it does, the module is installed — continue to
[Configuration](../configuration/index.md) to add and configure the processor.
