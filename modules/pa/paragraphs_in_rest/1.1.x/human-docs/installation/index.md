# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The core **RESTful Web Services** module (`rest`) and the **Paragraphs** module
  (`paragraphs`) — Drupal enables these as dependencies when you turn on
  Paragraphs in REST.

There are no third-party Composer or PHP library requirements. Note that this
module works with core REST (JSON/XML) and is **not** intended for JSON:API.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_in_rest -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_in_rest -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_in_rest -y
```

You will also need a configured core REST resource for the entity you want to
expose (for example the node resource), set to a JSON or XML format. That setup is
done through core REST, not through this module.

## Verify it worked

Request an entity that has a Paragraphs field through your configured REST
resource. In the response, the Paragraphs field should now contain the paragraph
content **inline** as nested data — including any paragraphs nested inside other
paragraphs — instead of bare references. Before exposing anything publicly, review
which fields the resource serializes, as described in "How to use it" on the
[overview page](../index.md).
