# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 7.1 or newer**.

That's all — Translated Config has no contrib dependencies and no third-party
Composer libraries. It relies only on core's configuration and language services.
To get any benefit you'll naturally have a multilingual site with configuration
translation in use, but the module itself imposes no such requirement.

## Install with Composer

From the project root:

```bash
composer require drupal/translated_config -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/translated_config -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en translated_config -y
```

## What to do next

There is nothing to configure. Once enabled, the `translated_config.helper`
service is available to your custom code — see
[How to use it](../index.md#how-to-use-it) for the one method it provides, and the
sibling [`agent/`](../agent/start.md) docs for a fuller code example.
