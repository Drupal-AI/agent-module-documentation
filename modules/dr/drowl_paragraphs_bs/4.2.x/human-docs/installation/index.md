# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Direct module dependencies (Composer and Drupal pull these in):
  - **Paragraphs** (`paragraphs`), **Layout Paragraphs** (`layout_paragraphs`),
    **Field Group** (`field_group`), **UI Styles Paragraphs**
    (`ui_styles_paragraphs`), and core **Media** (`media`).
- Additional modules the DROWL ecosystem expects you to have, per the project
  page: **UI Styles**, **DROWL Layouts**, **DROWL Media**, **Twig Tweak**,
  **PhotoSwipe**, **Fences**, **Micon**, **Entity Reference Display**, **Block
  Field**, **Link Attributes**, **Field Formatter**, **Entity Access by Role**,
  **Views Reference**, and **Webform**.
- A **Bootstrap 5** theme — designed for DROWL's **DROWL Base / Radix** theme.
  With any other Bootstrap 5 theme you will likely need to override some templates
  yourself. Gin is recommended as the admin theme.

There are no third‑party PHP library requirements from the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/drowl_paragraphs_bs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragraphs,
Layout Paragraphs, UI Styles Paragraphs, and the other dependencies together. You
may need to `composer require` the additional recommended modules above separately.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drowl_paragraphs_bs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drowl_paragraphs_bs -y
```

## Submodules

Each pre‑defined paragraph bundle ships as its own submodule, so you can activate
only the bundles you need. After enabling the base module, look under **Extend**
(`/admin/modules`) for the DROWL Paragraphs bundle submodules and enable the ones
you want, for example:

```bash
drush en <bundle_submodule_machine_name> -y
```

## Verify it worked

Go to **Structure → Paragraphs types** and confirm the DROWL Bootstrap paragraph
bundles you enabled are listed, then add one to a Paragraphs or Layout Paragraphs
field and check that its UI Styles display options appear.
