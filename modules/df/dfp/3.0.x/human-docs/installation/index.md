# Installation

## Requirements

DFP needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **Block** module (`block`), which DFP depends on so ad tags can be exposed
  as placeable blocks. Drupal enables it automatically as a dependency.
- A **Google Ad Manager account** with your network ID, ad units, and campaigns
  configured — that's the ad server DFP tags talk to.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dfp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dfp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dfp -y
```

Drupal enables the required **Block** module at the same time.

## Grant the permission

At **People → Permissions** (`/admin/people/permissions`), grant **Administer DFP**
to your trusted ad‑ops editors — it controls creating, editing, and deleting ad
tags and changing the global settings.

Next, enter your Network ID and create ad tags — see
[Configuration](../configuration/index.md).
