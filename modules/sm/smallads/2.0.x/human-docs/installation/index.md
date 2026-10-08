# Installation

## Requirements

Smallads needs a fair amount of scaffolding in place, but Composer pulls almost
all of it in for you:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules **Block**, **Comment**, **Field**, **Image**, **Link**,
  **Search**, **Taxonomy**, **Token** and **Views** — all part of Drupal core.
- Three contrib modules: **SHS** (`shs`, hierarchical select widget), **Chosen**
  (`chosen`, enhanced select lists) and **Taxonomy Entity Index**
  (`taxonomy_entity_index`).
- Core's **Contact** module, which Smallads enables automatically during
  installation.

There are no extra PHP version constraints or third-party library requirements
recorded for this release.

## Install with Composer

From the project root:

```bash
composer require drupal/smallads -W
```

The Composer package name (`drupal/smallads`) matches the module's machine name
(`smallads`). The `-W` (`--with-all-dependencies`) flag lets Composer pull in and
update the required contrib dependencies (SHS, Chosen, Taxonomy Entity Index) as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smallads -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smallads -y
```

Enabling Smallads creates the `smallad` content entity and its `smallad_type`
bundle, the **categories** and **smallads_types** vocabularies, the three listing
views, the nested-categories navigation block and the breadcrumb builder — and it
turns on core's Contact module for you.

## Verify it worked

Log in as an administrator and visit **Structure → Smallads**
(`/admin/structure/smallads`); you should see the ad-types collection. Give a role
the **post smallad** permission, then have a member create an ad — it should appear
in the generated "all offers" or "all wants" view according to the type you
assigned it.
