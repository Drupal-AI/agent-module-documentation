# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node**, **Path**, and **Text** modules (all part of a standard install)
  — pulled in automatically as dependencies.
- The bundled **Ingredient** submodule (`ingredient`), which supplies the
  ingredient field type.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/recipe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recipe -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Recipe together with its Ingredient submodule (Recipe depends on it, so
this pulls it in):

```bash
drush en recipe ingredient -y
```

### Submodule

- **Ingredient** (`ingredient`) — provides the Ingredient entity type and the
  parsing ingredient‑reference field that make quantities, units, and ingredient
  names into structured data. Recipe relies on it.

## Verify it worked

Go to **Structure → Content types** and confirm a **Recipe** type is present, then
visit **Content → Add content → Recipe** and check that you can add a recipe with an
ingredients field. See the [main guide](../index.md#how-to-use-it) for building your
first recipe.
