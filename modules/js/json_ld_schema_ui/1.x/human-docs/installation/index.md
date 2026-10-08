# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Entity API** module (`entity`) — this is a hard dependency and must be
  installed beforehand.
- Optionally, the **Token** module (for a token browser when setting default
  values) and the **Select2** module (for an alternative schema‑type selector).
- A core patch may be required for the form's Ajax + `#states` behavior to work
  correctly — see the note below.

## Install with Composer

From the project root:

```bash
composer require drupal/json_ld_schema_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Pull in Entity API too if it isn't already present:

```bash
composer require drupal/entity -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/json_ld_schema_ui -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## A required core patch

Because this module combines the Ajax and the JavaScript `#states` APIs in its
forms, the patch from the Drupal.org issue *"Display bug when using #states (Forms
API) with Ajax request"* is needed for the schema forms to behave correctly. Apply
it (for example via `cweagans/composer-patches`) if you find the form fields
misbehaving.

## Enable the module

```bash
drush en entity json_ld_schema_ui -y
```

## Verify it worked

Go to a content type's manage page (**Structure → Content types → *(type)* →
manage**) and look for the schema configuration (vertical) tab. You should also
find **Content Schema Settings** at **Configuration → Search and metadata**
(`/admin/config/search/schemaorg/settings`). See
[Configuration](../configuration/index.md) for how to set up your first schema.
