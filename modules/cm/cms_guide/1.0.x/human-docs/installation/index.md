# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Filter** (`filter`) and **Text** (`text`) modules — enabled
  automatically as dependencies.
- The contrib **Pathauto** (`pathauto`) module — generates the clean URLs for
  guide pages. Composer pulls it in for you.

The Markdown-to-HTML conversion uses the `league/commonmark` PHP library, which
Composer installs as part of the module's dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/cms_guide -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Pathauto, the
CommonMark library, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cms_guide -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cms_guide -y
```

## Verify it worked

Log in as an administrator. **CMS Guide** should appear in the admin toolbar, and
the importer should be reachable at `/admin/structure/cms-guide/import`. Remember
that the module ships **empty** — you will not see any guide pages until you
provide content and run the importer. See the "How to use it" section of the
[guide](../index.md) for that workflow.
