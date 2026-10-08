# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Taxonomy** (`taxonomy`), **Field** (`field`), and **File** (`file`)
  modules — Drupal enables these automatically as dependencies.
- The **`enshrined/svg-sanitize`** PHP library (`>=0.9 <1.0`), used to sanitize
  uploaded SVGs before they go into the sprite. Composer pulls it in for you when
  you require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/icon_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install/update shared
dependencies — including the `enshrined/svg-sanitize` library this module needs.
Installing via Composer (rather than downloading the module by hand) is the
reliable way to get that library in place.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/icon_select -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en icon_select -y
```

Enabling the module creates the **`icons`** taxonomy vocabulary and its two fields
(Symbol ID and SVG file) automatically. From there, follow
[How to use it](../index.md#how-to-use-it) in the overview to add icons and wire
up a field.

## Verify it worked

Go to **Structure → Taxonomy** and confirm an **Icons** vocabulary exists. Add a
test icon term with a unique Symbol ID and an SVG file, save it, and check that
the sprite file appears at `public://icons/icon_select_map.svg` (i.e.
`web/sites/default/files/icons/icon_select_map.svg`). If it doesn't, run
`drush generate-sprites` and check the `icon_select` log channel for any SVGs that
failed to parse.
