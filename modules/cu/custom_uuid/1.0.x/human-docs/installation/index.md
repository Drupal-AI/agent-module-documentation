# Installation

## Requirements

- **Drupal 9.5 or 10** (`core_version_requirement: ^9.5 || ^10`).
- Core's **Media** (`media`) and **Block content** (`block_content`) modules —
  these are the forms Custom UUID extends, so they must be enabled. Drupal will
  pull them in as dependencies when you enable the module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_uuid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_uuid -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_uuid -y
```

## Verify it worked

Go to **Content → Blocks → Add content block** (or **Content → Media → Add
media**) and confirm a **Custom UUID** field now appears near the top of the
form. Leave it blank to keep the default behavior, or enter a valid UUID to pin
one. There is no configuration to do beyond enabling the module.
