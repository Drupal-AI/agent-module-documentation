# Installation

## Requirements

Snippet Manager needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **Filter** (`filter`) and **File** (`file`) modules — both ship with
  Drupal and are usually already enabled.
- The contributed **CodeMirror Editor** (`codemirror_editor`) module, which
  provides the code editor used when writing snippet Twig. Composer pulls this in
  automatically when you require Snippet Manager with `-W`.

There are no additional PHP extension or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/snippet_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update shared
dependencies — including CodeMirror Editor — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/snippet_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en snippet_manager -y
```

Drupal will enable the CodeMirror Editor dependency at the same time if it is not
already on.

## After enabling

Grant the **`administer snippets`** permission only to developers and trusted
site builders — it lets its holder write Twig that renders on the live site, so
treat it like the ability to edit theme templates. Then head to the snippet
management interface to create your first snippet.
