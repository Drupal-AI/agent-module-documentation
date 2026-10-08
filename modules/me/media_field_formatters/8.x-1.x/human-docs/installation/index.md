# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Drupal core's **Media** module (`media`), which Drupal enables automatically as
  a dependency. The formatters are designed to work with the Media and Image
  modules bundled in core.

There are no contributed‑module dependencies and no third‑party PHP libraries to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/media_field_formatters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_field_formatters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_field_formatters -y
```

Core's Media module is enabled automatically if it is not already on.

## Verify it worked

Go to a bundle's **Manage display** tab (for example **Structure → Content types →
*(type)* → Manage display**), open the **Format** dropdown on a media reference or
image field, and confirm the module's formatters now appear as options. How to use
them is covered in the [main guide](../index.md).
