# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Markdown** contrib module (`drupal/markdown`, version 8.x-2.0 or higher) —
  this provides the filter that converts the stored Markdown into HTML on output.
  Editor.md does not render Markdown itself.
- The **Editor.md JavaScript library**, installed at `/libraries/editor.md`.

## Install with Composer

From the project root, require both the module and its Markdown dependency:

```bash
composer require drupal/editor_md drupal/markdown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/editor_md -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Install the Editor.md library

The module needs the Editor.md front-end library present at
`/libraries/editor.md` (so that `editormd.min.js`, its CSS, and
`languages/en.js` can load). If your site is not using a Composer/asset workflow
that places it there automatically, download it manually into that directory. The
maintainers recommend installing **this module's dedicated fork** of the library
rather than the upstream distribution, which is currently out of date — see the
project page for the current download link.

## Enable the module

```bash
drush en editor_md markdown -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and configure a format. If **Editor.md** appears
in the **Text editor** dropdown, the module and library are in place. Assign it to
a format (see [Configuration](../configuration/index.md)), then edit a field that
uses that format — you should see the Markdown editor with its live preview pane.
