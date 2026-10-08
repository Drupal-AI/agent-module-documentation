# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).
- **PHP 8.1** or higher.
- No modules outside of Drupal core, and no third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/partial_page_print -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/partial_page_print -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en partial_page_print -y
```

Enabling the module makes the `partial_page_print_button` render element available.
There is no settings form — you place the button in your theme or a custom module
(see [How to use it](../index.md#how-to-use-it)).

## Verify it worked

Add the print button to a template or render array, pointing its `#element_id` at a
container that exists on the page (for example a node summary `div`). Load the page,
click the button, and your browser's print dialog should show only that container's
content — themed, but without the site's regions and blocks.
