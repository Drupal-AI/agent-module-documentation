# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- Core's **CKEditor 5** module (`ckeditor5`) enabled — enabled automatically as a
  dependency.
- **Two JavaScript libraries** must be installed under your site's `libraries/`
  directory (see below). The module reports on their presence and version at
  **Reports → Status report**.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_codemirror -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_codemirror -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Install the two required JavaScript libraries

The module needs these under the docroot `libraries/` folder:

1. **CodeMirror 5** at `libraries/codemirror`. **Version 5 only** — CodeMirror 6
   is a different, incompatible project and is not supported.
2. **`@cdubz/ckeditor5-source-editing-codemirror`** (the CKEditor 5 ↔ CodeMirror
   bridge) at `libraries/ckeditor5-source-editing-codemirror`.

A common way to manage these is the [Composer Merge
plugin](https://github.com/wikimedia/composer-merge-plugin) with a
`composer.libraries.json` that pins both packages, so they land in `libraries/`
automatically. You can also download them and place them there by hand. After
installing, check **Reports → Status report** (`/admin/reports/status`) — the
module lists both libraries and their detected versions there. If highlighting
doesn't appear later, this status report is the first place to look.

## Enable the module

```bash
drush en ckeditor_codemirror -y
```

Or enable **CKEditor CodeMirror** on the **Extend** page (`/admin/modules`).

Enabling the module doesn't change any format on its own — you turn CodeMirror on
per text format (and the format must have the **Source** button in its toolbar).
See [How to use it](../index.md#how-to-use-it) for that.

## Upgrading from CKEditor 4

If you're migrating a site that used the CKEditor 4 `codemirror` plugin, this
module includes an upgrade path that carries your old CodeMirror settings over to
the new per‑format configuration automatically during the CKEditor 5 upgrade.

CKEditor CodeMirror has no submodules.
