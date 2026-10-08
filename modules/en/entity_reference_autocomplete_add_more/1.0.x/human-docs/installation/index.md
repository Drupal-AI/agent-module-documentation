# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required — it depends only on Drupal core.
- No third‑party Composer or PHP library requirements.

This is a developer‑oriented module: it registers a Form API element and does
nothing visible on its own until you use that element in custom form code.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_autocomplete_add_more -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_autocomplete_add_more -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_autocomplete_add_more -y
```

## Verify it worked

Enabling the module makes no visible change on its own — that is expected. To
confirm it is available, use the new `entity_reference_autocomplete_add_more`
element type in a custom form (see the example in the [overview](../index.md)).
The rendered form should show an entity autocomplete input with **Add more item**
and **Remove** buttons that work without a page reload.
