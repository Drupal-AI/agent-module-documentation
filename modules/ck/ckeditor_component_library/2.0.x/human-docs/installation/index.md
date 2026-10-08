# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Component Library** (`component_library`) — where your patterns and variants
  are defined.
- **Embedded Content** (`embedded_content`) — the CKEditor 5 embedded‑content
  framework this module plugs into.

Composer pulls in the two module dependencies automatically. There are no
third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_component_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`component_library` and `embedded_content` dependencies and update shared packages
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_component_library -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_component_library -y
```

This also enables `component_library` and `embedded_content` if they are not
already on.

## Verify it worked

Once enabled, continue to [Configuration](../configuration/index.md): you must
enable the Embedded Content button on a text format and expose at least one
pattern before editors can embed anything. When that is done, editing content in
the configured format should show an **Embedded Content** button that lets you
pick one of your exposed patterns.
