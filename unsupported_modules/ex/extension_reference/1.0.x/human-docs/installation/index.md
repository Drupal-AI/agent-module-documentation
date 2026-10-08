# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** (`field`) and **Options** (`options`) modules — both are part of
  Drupal core, and Drupal enables them automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

> **Note on security coverage:** this project is **not covered by Drupal's security
> advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/extension_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/extension_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extension_reference -y
```

## Verify it worked

Go to the **Manage fields** page of any content type, click **Add field**, and
confirm that **Extension** appears in the list of available field types. Add one,
then check the entity's edit form shows a select box listing your site's
extensions.

Next, see the "How to use it" section of the [overview](../index.md).
