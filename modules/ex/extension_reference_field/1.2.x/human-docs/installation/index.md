# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).

There are no additional module dependencies and no third‑party Composer or PHP
library requirements.

> **Version note:** at the time of writing the release line is a beta
> (`1.2.3-beta1`). Test before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/extension_reference_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/extension_reference_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extension_reference_field -y
```

## Verify it worked

Go to the **Manage fields** page of any content type, click **Add field**, and
confirm that **Extension** appears in the list of available field types. Add one,
choose an extension type, and check that the entity's edit form lets you pick an
extension of that type.

Next, see the "How to use it" section of the [overview](../index.md).
