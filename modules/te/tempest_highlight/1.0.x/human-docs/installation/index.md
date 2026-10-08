# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) — this is a declared dependency and
  Drupal enables it automatically.

There are no separately declared third‑party Composer or PHP library requirements
in the module metadata; the `tempestphp/highlight` library it builds on is resolved
through Composer when you install the module.

## Install with Composer

From the project root:

```bash
composer require drupal/tempest_highlight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the highlighting library the module relies on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tempest_highlight -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tempest_highlight -y
```

## Verify it worked

Edit a piece of content using a CKEditor 5 text format, add a code block with some
code, and view the rendered page. The code should appear with syntax highlighting
applied on the server (no client‑side highlighter is loaded).
