# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Image** module (`image`) enabled — this is a dependency.
- A **provider plugin** (custom or contrib) if you actually want to offload
  derivatives. The base module ships the framework only; without a provider,
  image styles behave like Drupal Core.

There are no third‑party Composer or PHP library requirements for the base module.

> **Compatibility warning:** External Image Styles overrides the core `image_style`
> config entity class. It is **incompatible with any other module that also
> overrides `image_style`** — enabling both throws a `RuntimeException` at cache
> rebuild. Check for such conflicts before enabling.

## Install with Composer

From the project root:

```bash
composer require drupal/external_image_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_image_styles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_image_styles -y
```

## Verify it worked

Go to **Configuration → Media → Image styles** and add or edit an image style
(`/admin/config/media/image-styles/add`). You should see a new **Image Style
Provider** select, defaulting to **Drupal Core**. Once you have a provider module
enabled, that provider will appear as an option here.

Next, see the "How to use it" section of the [overview](../index.md) for selecting
a provider per style.
