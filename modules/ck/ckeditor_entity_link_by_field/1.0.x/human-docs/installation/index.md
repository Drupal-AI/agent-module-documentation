# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **CKEditor** (`ckeditor`) — the legacy CKEditor 4 editor module this plugin
  targets.
- **Editor** (`editor`) — core's text‑editor framework.
- **Linkit** (`linkit`) — the autocomplete link infrastructure it builds on.

Composer pulls in the module dependencies. There are no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_entity_link_by_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `linkit` (and
other) dependencies and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_entity_link_by_field -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_entity_link_by_field -y
```

This also enables `ckeditor`, `editor`, and `linkit` if they are not already on.

## Verify it worked

The module needs configuration before it does anything useful — continue to
[Configuration](../configuration/index.md) to map the source field and add the
button to a text format. Once configured, editing content in that format should
show an **Add link by field** button that opens a field‑scoped autocomplete dialog.
