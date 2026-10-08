# Installation

> **This is an example/reference module** meant for developers to study and clone. You
> generally install it, copy it into your own entity module, and then remove it — you
> would not normally leave the sample entity enabled in production.

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The module builds on the contrib **Entity API** (`drupal/entity`) handlers for
  query access and per‑bundle permissions, so have Entity API available in your
  project. If Composer reports a missing dependency when you require the module, add
  `drupal/entity` as well.
- No other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_entity_example -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_entity_example -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_entity_example -y
```

The example admin permission is **`administer custom_entity_example`**; grant it to
whoever needs to explore or manage the sample entity.

## Verify it worked

After enabling, you can browse the example entity's collection page and inspect the
entity type in the admin UI. To try the code generator, use the clone form at
`admin/content/custom-entity-example-types/clone-form` or the `drush cee-ge` command
— see the main guide's [How to use it](../index.md#how-to-use-it). For the generator
to write files, the destination folder must be writable.
