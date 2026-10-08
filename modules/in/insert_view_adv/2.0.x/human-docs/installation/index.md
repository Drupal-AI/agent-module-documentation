# Installation

## Requirements

Advanced Insert View needs:

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8.0 || ^9 || ^10 || ^11`).
- Core's **Views** (`views`), **Text Editor** (`editor`), and **Filter**
  (`filter`) modules — all part of a standard Drupal install and enabled
  automatically as dependencies.

There are no third‑party Composer libraries or special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/insert_view_adv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/insert_view_adv -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en insert_view_adv -y
```

Enabling the module does not turn on embedding by itself — you still have to enable
the **Advanced Insert View** filter on each text format where you want it, and
optionally add the CKEditor button. See the
[overview](../index.md#how-to-use-it) for those steps.

## Submodule — BUEditor support

Advanced Insert View ships one optional submodule, **Insert View Adv BUEditor**
(`insert_view_adv_bueditor`), which adds the same insert‑view button to the
BUEditor editor. Enable it only if your site uses BUEditor:

```bash
drush en insert_view_adv_bueditor -y
```

Note that this submodule requires the separate **BUEditor** contrib project, which
you would install alongside it.

## Verify it worked

Edit a text format at **Configuration → Content authoring → Text formats and
editors** and confirm **Advanced Insert View** appears in the list of enabled
filters. Tick it, save, and try embedding a view token such as
`[view:frontpage]` in a body field.
