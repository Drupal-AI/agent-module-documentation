# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no module dependencies and no third‑party Composer or PHP library
requirements — the module builds on core's text-format/filter system.

## Install with Composer

From the project root:

```bash
composer require drupal/function_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/function_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en function_filter -y
```

## Turn on the filter

The module does nothing until you enable its filter on a text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit a **trusted** text format (one used only by roles you trust — see the
   security note in the [main guide](../index.md)).
3. Enable the **Function filter** filter and save.

## Verify it worked

Register at least one function via `hook_filter_functions()` in a custom module (see
the [main guide](../index.md)), then add its `[function:...]` token to a piece of
content using the format you configured. When the content renders, the token should
be replaced by the function's result. An unknown or unregistered function name will
simply produce nothing, which confirms the allow-list is working as intended.
