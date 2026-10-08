# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`).
- The contributed **Key** module (`key`) — used to store the MJML API key
  securely. The Composer command below installs it as a dependency.
- An **MJML API key** from the MJML rendering service (needed before you can
  preview; see the [overview](../index.md) for how to store it).

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mjml_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies, including the Key module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mjml_preview -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mjml_preview -y
```

If Key was not already enabled, enable it too:

```bash
drush en key -y
```

## Verify it worked

Visit **Configuration → Web services → MJML preview**
(`/admin/config/services/mjml_preview`) — the API-credentials form should load.
Once you've stored your MJML API key (see the [overview](../index.md)) and created
an `mjml` view mode with a matching theme template, open a node of that bundle and
confirm the **Preview MJML** and **Download MJML** tabs appear and render.
