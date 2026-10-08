# Installation

## Requirements

Menu Multilingual needs:

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- Two core modules, which Drupal will enable automatically as dependencies:
  - **Menu Link Content** (`menu_link_content`) — the editable custom menu links
    the filter inspects.
  - **Content Translation** (`content_translation`) — provides the translation
    machinery the checks rely on.
- A multilingual setup to be useful: more than one language enabled, and content
  translation configured for the entities your menus point at. On a single-language
  site the module has nothing to filter.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_multilingual -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_multilingual -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_multilingual -y
```

Drupal will pull in Menu Link Content and Content Translation if they aren't
already on. Enabling the module adds the **Multilingual options** to menu blocks
but changes nothing until you tick those options on a block.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`), edit a menu block,
and confirm a **Multilingual options** section with the two checkboxes appears in
its configuration form. See the
[how-to-use section on the overview page](../index.md#how-to-use-it) for what to do
next, and remember to run `drush cr` after changing options.
