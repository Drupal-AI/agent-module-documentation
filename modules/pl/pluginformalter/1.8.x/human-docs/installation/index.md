# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal modules are required, and there are no third‑party Composer or
  PHP library requirements.

### Optional integrations

- **Paragraphs** (`drupal/paragraphs`) — enables the `ParagraphsFormAlter` plugin
  type for altering paragraph subforms.
- **Inline Entity Form** (`drupal/inline_entity_form`) — enables the
  `InlineEntityFormAlter` plugin type for altering IEF subforms.
- **Webprofiler** (`drupal/webprofiler`) — its Forms data collector is decorated
  to list which plugins altered each form.

## Install with Composer

From the project root:

```bash
composer require drupal/pluginformalter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pluginformalter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pluginformalter -y
```

There is nothing to configure. Once enabled, create your FormAlter plugin classes
under your module's `src/Plugin/FormAlter/` directory — see the
[overview](../index.md) for how to write one.

> **Heads up:** on Drupal 11.2+ these plugins emit a deprecation notice and will
> stop running in Drupal 12. Prefer core OOP Hooks for new code.
