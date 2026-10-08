# Installation

## Requirements

Persistent Identifiers Field Set needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Persistent Identifiers](https://www.drupal.org/project/persistent_identifiers)**
  module (`persistent_identifiers`), which this module builds on. Composer pulls
  it in as a dependency.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pid_field_set -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in the Persistent Identifiers module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pid_field_set -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pid_field_set -y
```

This also enables the required `persistent_identifiers` module if it isn't already
on.

## Set permissions

The module defines an **Administer pid_field_set configuration** permission that
gates its minter settings. At **People → Permissions**, grant it only to the roles
that should manage identifier minting.

## Verify it worked

Go to a content type's **Manage fields → Add field** and confirm the
persistent‑identifier field is available to add. If you plan to mint new
identifiers, configure the minters first via **Help → Persistent Identifiers Field
Set Module → Persistent id field set settings** — see the [overview](../index.md)
for the walk‑through.
