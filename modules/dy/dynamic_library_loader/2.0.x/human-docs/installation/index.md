# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`; the module also
  declares support toward Drupal 12).
- No third‑party Composer or PHP library requirements, and **no other Drupal module
  dependencies** — earlier versions required the Paragraphs module, but that
  dependency has been removed.
- You'll need **declared asset libraries** (defined by a module or theme in a
  `*.libraries.yml`) to attach — this module attaches existing libraries; it doesn't
  create them.

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_library_loader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_library_loader -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_library_loader -y
```

## Verify it worked

Go to **Configuration → System** and confirm the Dynamic Library Loader form is
listed. Add an entry mapping a declared library to a content type (see
[Configuration](../configuration/index.md)), then view a page for that entity and
check — in your browser's page source or dev tools — that the library's CSS/JS is now
loaded there and absent elsewhere.
