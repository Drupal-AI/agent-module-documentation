# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** and **Config** modules — enabled automatically as
  dependencies.
- **A Drupal core patch is required.** The module depends on core issue
  **2940016** (https://www.drupal.org/project/drupal/issues/2940016). Apply that
  patch — typically with `cweagans/composer-patches` — before using the module in
  production.

There are no other third‑party Composer or PHP library requirements for the base
module.

## Install with Composer

From the project root:

```bash
composer require drupal/image_style_metadata -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_style_metadata -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

Remember to apply core patch **2940016** as part of your Composer patch
configuration.

## Enable the module

```bash
drush en image_style_metadata -y
```

## Submodules

Enable only the submodules you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **JSON:API Image Style Metadata** | `jsonapi_image_style_metadata` | Exposes the stored metadata on File entities in the JSON:API export, for decoupled front‑ends. |
| **BlurHash Image Style Metadata** | `blurhash_image_style_metadata` | Adds a BlurHash placeholder string to the stored metadata for blur‑up image loading. |

```bash
drush en jsonapi_image_style_metadata -y
drush en blurhash_image_style_metadata -y
```

## Verify it worked

Confirm the module is enabled (**Extend**, or `drush pm:list | grep
image_style_metadata`), that the core patch is applied, and that the module's
permissions appear at **People → Permissions**. Then generate a styled image and
check that its metadata is captured — via JSON:API if you enabled that submodule.
See the [manual setup guide](../index.md) for the full workflow.
