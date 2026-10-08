# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No required contributed‑module dependencies and no third‑party libraries — it
  builds on core's Field API.
- Core's **Field UI** module enabled to add the field through the admin
  (`drush en field_ui -y`).
- The **Feeds** module only if you want to use the module's Feeds import target
  — it is optional.

## Install with Composer

From the project root:

```bash
composer require drupal/multivaluefield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/multivaluefield -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multivaluefield -y
```

## Example submodule

To install a ready‑made demonstration (a sample entity with the field already
configured), enable the bundled example:

```bash
drush en multivaluefield_example -y
```

It requires the base module, which is already present once you have installed it
above. It is a learning aid — you would not normally leave it enabled on a
production site.

## Verify it worked

Go to any bundle's **Manage fields** (for example **Structure → Content types →
Article → Manage fields**), click **Add field**, and confirm **Multi Value
Field** appears in the list of field types. Add it, save, and check that the
widget shows its sub‑value inputs on the content form.
