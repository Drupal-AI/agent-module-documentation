# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**.
- **Layout Paragraphs** (`drupal/layout_paragraphs` >=2.1 <2.2) — supplies the
  components and layouts the builder edits.
- **Style Options** (`drupal/style_options` ^1 || ^2) — supplies the visual styling
  controls.

Composer installs both dependencies for you. You will also need a bundle set up for
Layout Paragraphs (a layout‑paragraphs field) for the builder to have anything to
edit.

## Install with Composer

From the project root:

```bash
composer require drupal/mercury_editor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update Layout
Paragraphs and Style Options as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mercury_editor -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mercury_editor -y
```

Then enable Mercury Editor for the bundles you want it on — see
[Configuration](../configuration/index.md).

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Mercury Editor Templates** | `mercury_editor_templates` | Reusable section templates (a `me_template` entity) that editors can drop into a page to start faster. Has its own permissions. |
| **Mercury Editor Inline Editor** | `mercury_editor_inline_editor` | **Deprecated** empty shim — do not enable it. Its replacement is the separate `mercury_editor_live_edit` module. |

To add reusable templates:

```bash
drush en mercury_editor_templates -y
```
