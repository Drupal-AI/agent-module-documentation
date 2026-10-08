# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Field** (`field`) module, always present.
- The **Extra Field** (`extra_field`) contrib module — this module is a
  configuration layer over it and does nothing without it.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/extra_field_configuration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Extra Field
module and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/extra_field_configuration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extra_field_configuration -y
```

## Submodules

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Extra Field Configuration Examples** | `extra_field_configuration_examples` | Example Extra Field plugins in both simple and formatted flavors, so you have working pseudo-fields to create instances from while learning the module. |

Enable it if you want the examples:

```bash
drush en extra_field_configuration_examples -y
```

## Verify it worked

Go to **Structure → Extra fields** (`/admin/structure/extra-field`). The
management screen should load, listing any available Extra Field plugins you can
create instances from (the examples submodule adds some if you enabled it). From
here, follow "How to use it" on the [overview page](../index.md) to create and
place an extra-field instance.
