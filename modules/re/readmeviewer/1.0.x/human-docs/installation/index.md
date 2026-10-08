# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies.
- **Optional:** the `league/commonmark` PHP library, which enables proper
  rendering of Markdown (`README.md`) files. Without it, READMEs are still shown as
  plain text.

> **Note:** the current release of this branch is an alpha (1.0.0-alpha2) and its
> security advisory coverage is **not covered** — test it before relying on it,
> and restrict access to administrators.

## Install with Composer

From the project root:

```bash
composer require drupal/readmeviewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To get formatted Markdown rendering, also require the
CommonMark library:

```bash
composer require league/commonmark
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/readmeviewer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en readmeviewer -y
```

## Verify it worked

Go to **Extend** (`/admin/modules`) and confirm a **README Files** tab now
appears alongside the Extend and Uninstall tabs. Open it, search for a module, and
click through to view its README — no configuration is required.
