# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core only — no module dependencies and no third-party PHP libraries. The
  formatter works with core's Field and Entity Reference systems, which are
  already present.

## Install with Composer

From the project root:

```bash
composer require drupal/nested_entity_reference_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nested_entity_reference_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nested_entity_reference_formatter -y
```

## Verify it worked

Go to the **Manage display** screen for a bundle that has an entity-reference field
(for example **Structure → Content types → *(type)* → Manage display**). Open the
**Format** dropdown for that field — the Nested Entity Reference Formatter should
now be one of the options. Selecting it and opening its settings should reveal the
AJAX-driven nested-field and formatter pickers described in "How to use it" in the
[overview](../index.md).
