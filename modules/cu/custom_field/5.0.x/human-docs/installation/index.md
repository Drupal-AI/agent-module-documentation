# Installation

## Requirements

- **Drupal 11.4 or newer, or Drupal 12** (`core_version_requirement: ^11.4 ||
  ^12`; the Composer requirement pins `drupal/core: ^11.4 || ^12`). This is a
  recent-core-only release — for older sites you need an earlier branch of the
  module.
- Core's **Field**, **File**, **Filter**, **Image**, and **Link** modules. These
  ship with Drupal and are enabled automatically as dependencies.

There are no third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/custom_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_field -y
```

Once enabled, *Custom* appears as a new field type when you add a field to any
entity. See [Configuration](../configuration/index.md) to build one.

## Integration submodules — enable only what you need

Custom Field ships nine optional submodules that connect it to other systems.
Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| GraphQL | `custom_field_graphql` | Exposes Custom Field data to GraphQL. |
| JSON:API | `custom_field_jsonapi` | Serves Custom Field columns over JSON:API. |
| Linkit | `custom_field_linkit` | Linkit autocomplete for `link` columns. |
| Media Library | `custom_field_media` | Media Library integration for media columns. |
| Search API | `custom_field_search_api` | Makes columns indexable by Search API. |
| SDC | `custom_field_sdc` | Map columns to Single Directory Component props. |
| Entity Browser | `custom_field_entity_browser` | Entity Browser widget for reference columns. |
| AI | `custom_field_ai` | AI-assisted integration. |
| Viewfield | `custom_field_viewfield` | Adds a `viewfield` column type to embed a View. |

For example:

```bash
drush en custom_field_jsonapi -y
```

Each submodule requires the base Custom Field module, which is already present
once you have installed it above.
