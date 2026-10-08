# Installation

## Requirements

Footnotes is a CKEditor 5 / text‑filter module. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`, and it requires
  `drupal/core: >=10.0`).
- Core's **CKEditor 5** (`ckeditor5`), **Editor** (`editor`), and **Media**
  (`media`) modules — these are hard dependencies and are enabled with it. The
  Footnotes button only works on a **CKEditor 5** text format.

Two **optional** integrations are suggested — you only need them for their specific
features:

- **Search API** (`drupal/search_api`) — provides the "Ignore citations" processor
  to keep footnote text out of your search index.
- **Metatag** (`drupal/metatag`) — footnotes coexist with metatag description
  generation (used in the module's tests).

## Install with Composer

From the project root:

```bash
composer require drupal/footnotes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/footnotes -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en footnotes -y
```

Drupal enables the CKEditor 5, Editor, and Media dependencies automatically.

## Next: turn footnotes on for a text format

Enabling the module doesn't yet give editors the button — footnotes are switched on
per **text format**. You can either use the ready‑made "Footnote" format the module
ships, or add footnotes to an existing format such as Full HTML. Both paths are
covered in [Configuration](../configuration/index.md).

## Upgrading from Footnotes 3.x

If you have content authored with the older 3.x footnote markup, migrate it in bulk
with the module's Drush command after upgrading, for example:

```bash
drush footnotes:upgrade-3-to-4 node
```

Developers can adjust each upgraded footnote's render array during the migration via
`hook_footnotes_upgrade_3x4x_build_alter()`.
