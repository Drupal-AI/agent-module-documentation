# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`; the Composer
  package also declares `drupal/core: ^9.3 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the only Drupal dependency.
- A **valid WIRIS license** for MathType/ChemType (the products are commercial —
  see <https://www.wiris.com/en/mathtype/>).
- A **MathML rendering solution** such as MathJax to display equations on the front
  end (see [Configuration](../configuration/index.md)).

> **Version note:** the 3.0.x series supports **CKEditor 5** on Drupal 10 and 11.
> This release line has been published as an alpha — review its stability before
> using it on a production site. (Older 2.x targets CKEditor 4 on Drupal 9/10.)

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_wiris -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_wiris -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_wiris -y
```

## Verify it worked

Enabling the module alone does not add anything to the editor. Follow
[Configuration](../configuration/index.md) to add the **MathType** and
**ChemType** buttons to a text format, then edit content: click the MathType
button and confirm the visual equation editor opens. Remember that equations will
only *display* on published pages once a rendering solution (MathJax) is in place.
