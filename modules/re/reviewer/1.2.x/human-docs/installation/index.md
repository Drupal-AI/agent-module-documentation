# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.2** or newer.
- **Drush 12** or newer — Reviewer is driven primarily through Drush commands.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/reviewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reviewer -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reviewer -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Reviewer UI** | `reviewer_ui` | A report page at **Reports → Reviewer** (`/admin/reports/reviewer`) so you can browse review results in the admin UI rather than only through Drush. |
| **Reviewer Test** | `reviewer_test` | Installs sample test content and example reviews so you can try Reviewer out. For evaluation/development, not production. |

For example, to add the report page:

```bash
drush en reviewer_ui -y
```

## Verify it worked

Run:

```bash
drush reviewer:list
```

You should see the list of available reviews. If you enabled **Reviewer UI**, visit
**Reports → Reviewer** (`/admin/reports/reviewer`) to view results in the browser.
See "How to use it" on the [overview page](../index.md) for running reviews.
