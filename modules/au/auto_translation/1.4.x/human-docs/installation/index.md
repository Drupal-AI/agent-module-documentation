# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **Content Translation** module (`content_translation`), which this
  module builds on. You'll also want more than one language configured and your
  content types set to be translatable — the standard multilingual setup.
- The **`google/cloud-translate`** PHP library (`^1.17`), pulled in by Composer.
  It's needed for the paid Google server‑side provider; the other providers use
  HTTP or their own SDKs.
- Depending on the provider you choose: an **Amazon Translate** setup needs the AWS
  SDK and credentials, and **Drupal AI** translation needs the AI and AI Translate
  modules with a provider configured.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_translation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies, including the `google/cloud-translate` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auto_translation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_translation -y
```

This enables Content Translation if it isn't already on. Then configure a provider
and credentials — see [Configuration](../configuration/index.md).
