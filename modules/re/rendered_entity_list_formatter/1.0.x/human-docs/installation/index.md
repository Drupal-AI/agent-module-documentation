# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- No other modules are required — it builds on core's entity-reference and
  field-display system.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/rendered_entity_list_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rendered_entity_list_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rendered_entity_list_formatter -y
```

## Verify it worked

Go to the **Manage display** screen of any entity type that has an
entity-reference field (**Structure → Content types → *(bundle)* → Manage
display**). The **Rendered entity list** formatter should now appear in the
**Format** dropdown for that field. See
[How to use it](../index.md#how-to-use-it) for the rest.
