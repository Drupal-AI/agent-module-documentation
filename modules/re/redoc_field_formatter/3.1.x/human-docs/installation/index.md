# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **File** (`file`) and **Link** (`link`) modules — both ship with Drupal
  core and are the field types this formatter works on.
- Network access to the **Redoc library on jsDelivr**
  (`cdn.jsdelivr.net`) at render time — or a locally vendored copy of the library
  (see the note on the [overview page](../index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/redoc_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redoc_field_formatter -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redoc_field_formatter -y
```

## Clear caches

The maintainer specifically calls out clearing caches right after installing:

```bash
drush cr
```

## Verify it worked

Go to a fieldable entity type's **Manage display** (**Structure → *(entity type)*
→ Manage display**). For a **file** or **link** field, the format dropdown should
now offer **Redoc UI**. Select it, then upload or link an OpenAPI/Swagger spec —
remember to allow the `json` and `yml` extensions on a file field — and confirm
the documentation renders on the entity's page. See the
[overview](../index.md) for the full step‑by‑step and the CDN caveat.
