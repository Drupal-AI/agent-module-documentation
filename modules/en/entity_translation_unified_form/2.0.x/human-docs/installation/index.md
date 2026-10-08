# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Content Translation** module (`content_translation`) enabled — this is a
  required dependency, and Drupal enables it automatically when you turn on ETUF.
- A multilingual site with the languages you need enabled and the target entity
  types made translatable.

There are no third‑party Composer or PHP library requirements.

> **Incompatibility:** ETUF does not work with the **Autosave Form**
> (`autosave_form`) module. If you have it installed, uninstall it before testing
> or using ETUF.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_translation_unified_form -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_translation_unified_form -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_translation_unified_form -y
```

## Turn it on for an entity type

ETUF has no settings form of its own — you activate it from the core content
language page. Go to **Configuration → Regional and language → Content language and
translation** (`/admin/config/regional/content-language`) and enable the unified
inline form (and, if you want, side‑by‑side editing) for each entity type. See
*How to use it* on the [overview page](../index.md) for the exact checkboxes.

## Verify it worked

After turning it on for a content type, open that type's **add** or **edit** form.
You should see the translatable fields for all enabled languages inline on the one
form rather than a separate translate tab per language.
