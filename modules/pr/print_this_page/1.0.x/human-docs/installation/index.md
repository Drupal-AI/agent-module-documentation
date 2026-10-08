# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Block** module (`block`) — Drupal enables it as a dependency
  automatically, and you'll need it for the block placement.
- No third‑party libraries are required; printing uses the browser's own
  `window.print()`.

The module is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/print_this_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/print_this_page -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en print_this_page -y
```

## Verify it worked

Place the **Print This Page** block in a region (or add the **Print This Page**
formatter to a field) — see [How to use it](../index.md#how-to-use-it). Load a page
that shows the button, click it, and confirm the browser's print dialog opens with
the excluded elements (header, footer, nav, and so on) hidden from the preview.
