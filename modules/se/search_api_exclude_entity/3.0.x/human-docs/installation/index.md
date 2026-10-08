# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Field** (`field`) module (enabled on virtually every site).
- The **Search API** (`search_api`) module, version **1.41 or newer** — pulled in by
  Composer.

There are no other third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_exclude_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required Search
API version and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_exclude_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_exclude_entity -y
```

Enabling the module makes the exclude field type available, but nothing is excluded
until you add the field to a bundle and enable the processor on your index — see the
[how-to-use walkthrough on the overview page](../index.md#how-to-use-it).

## Submodules — enable only what you need

Two optional submodules extend the idea. Enable individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Exclude Entity By Field** | `search_api_exclude_entity_by_field` | Excludes items when any indexed field matches a configured value, so you don't need to add a dedicated exclude field. |
| **Exclude Entity - Metatag** | `search_api_exclude_entity_metatag` | Excludes published entities whose Metatag `robots` value contains `noindex`, keeping search in sync with what crawlers are told to skip. |

For example:

```bash
drush en search_api_exclude_entity_by_field -y
```

Each submodule requires the base module, which is already present once you have
installed it above.

## Verify it worked

Go to **Structure → Content types → (a type) → Manage fields → Add field** and
confirm that **Search API Exclude Entity** appears in the list of available field
types.
