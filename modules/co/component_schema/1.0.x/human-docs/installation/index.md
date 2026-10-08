# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- No required module dependencies and no third‑party PHP or library requirements.

Recommended companions (optional):

- **Style Guide** — to get a visual representation of your components and their
  variables.
- **UI Patterns** (via the Component Schema UI Patterns submodule), plus
  **Component Blocks**, **UI Patterns Field Formatters**, and **UI Patterns
  Settings** for a fuller component workflow.
- **Bulma Components** — the fullest reference example of a module built on
  Component Schema.

## Install with Composer

From the project root:

```bash
composer require drupal/component_schema -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/component_schema -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en component_schema -y
```

## Verify it worked

Component Schema is a developer framework, so there is nothing user-visible on its
own. The best check is to define a component with a schema (or install a module
like Bulma Components that uses it) and, with the Style Guide module enabled,
confirm the component shows up in the styleguide with its variables documented.
