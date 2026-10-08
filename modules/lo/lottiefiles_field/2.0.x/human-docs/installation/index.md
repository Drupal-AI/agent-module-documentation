# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Link** (`link`), **Media** (`media`), and **Media Library**
  (`media_library`) modules — dependencies that Drupal enables for you.
- A **writable public files directory**. The module stores uploaded animations
  under `public://lottiefile_field/` and, on install, copies its media icon into
  the media icon directory — installation fails if that directory isn't writable
  or if the Media module is missing.

There are no third‑party Composer or PHP library requirements — the
`<lottie-player>` JavaScript component is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/lottiefiles_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lottiefiles_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lottiefiles_field -y
```

Drupal enables Link, Media, and Media Library as dependencies at the same time.
Enabling the module also creates a ready‑made **Lottiefiles** media type.

## Verify it worked

Add a **Lottiefiles Field** to any content type from its **Manage fields** screen,
or check **Structure → Media types** for the new **Lottiefiles** type. See the
[overview page](../index.md#how-to-use-it) for adding and configuring animations.
