# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working **DKAN** site with the metastore search submodule
  (**dkan_metastore_search**) enabled — this module depends on it.
- The bundled patch **`4310-plus.patch`** applied to DKAN. This is required for
  the extra fields to register correctly; the patch ships with this module.

There are no additional PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dkan_extra_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dkan_extra_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Apply the required DKAN patch

Before enabling, apply the bundled **`4310-plus.patch`** to DKAN. The typical
approach is Composer's patching workflow (for example the `cweagans/composer-patches`
plugin), pointing an entry for `drupal/dkan` at the patch file shipped with this
module. Consult the module's README for the exact path to the patch.

## Enable the module

```bash
drush en dkan_extra_fields -y
```

## Verify it worked

Go to the DKAN content type's **Manage display** tab (for example
`admin/structure/types/manage/data/display`). The dataset's JSON‑schema properties
should now appear as extra (pseudo‑)fields you can drag into place and reorder. If
they don't appear, confirm the `4310-plus.patch` was applied to DKAN and that
**dkan_metastore_search** is enabled.
