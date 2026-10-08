# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Options** (`options`) and **Text** (`text`) modules, which Drupal enables
  automatically as dependencies.
- The **Mautic API PHP library** (version 3.1.0), installed automatically with
  Composer.
- A reachable **Mautic** instance whose API is configured (and, if you use OAuth2,
  API credentials created on the Mautic side).

## Install with Composer

From the project root:

```bash
composer require drupal/mautic_paragraph -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Mautic API
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mautic_paragraph -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mautic_paragraph -y
```

Enabling the module creates the **Mautic paragraph type** and **Mautic block type**.

## Verify it worked

Go to **Configuration → Web services → Mautic**
(`/admin/config/services/mautic`) and enter your Mautic connection details (see
[Configuration](../configuration/index.md)). Once connected, add a **Mautic**
paragraph or block to a page and confirm the list of Mautic forms is available to
choose from.
