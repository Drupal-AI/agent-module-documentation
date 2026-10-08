# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **broad dependency stack**, all of which are required and enabled with the
  module:
  - **Drupal Commerce** (`commerce_product`)
  - **[Paragraphs](https://www.drupal.org/project/paragraphs)** (`paragraphs`)
  - **[CSHS – Client‑side hierarchical select](https://www.drupal.org/project/cshs)** (`cshs`)
  - **[Taxonomy Views Integrator](https://www.drupal.org/project/tvi)** (`tvi`)
  - **[Image Effects](https://www.drupal.org/project/image_effects)** (`image_effects`)
  - **[Colorbox](https://www.drupal.org/project/colorbox)** (`colorbox`)
  - **[Field Group](https://www.drupal.org/project/field_group)** (`field_group`)
  - **[Metatag](https://www.drupal.org/project/metatag)** (`metatag`)
  - Core **Responsive Image** (`responsive_image`)
  - **[Focal Point](https://www.drupal.org/project/focal_point)** (`focal_point`)

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cmlstarter -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it pulls in the full
dependency stack above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cmlstarter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cmlstarter -y
```

Enabling triggers the install process: it provisions the product/variation types,
taxonomies, paragraph type, fields, image styles, views, blocks and pathauto
patterns, and creates a default commerce store. Because it does a lot, prefer
enabling it on a fresh or purpose‑built Commerce site.

> **Language note:** if your site's default language is Russian (`ru`), the install
> creates an "Example Store" with a Moscow address and RUB currency; otherwise it
> creates a "US Store" with USD. The install also imports `product_options` taxonomy
> terms from the module's bundled configuration.

## Verify it worked

After enabling, check that:

- **Commerce → Configuration → Stores** shows the default store (which you should
  then edit — see "How to use it" in the [overview](../index.md)).
- **Structure → Content types / Commerce product types** shows the `product` type
  with its fields.
- The `catalog`, `brand` and `product_options` vocabularies exist under
  **Structure → Taxonomy**.

## Optional: demo content

To seed the shop with example products, install
[CML Starter Demo](https://www.drupal.org/project/cmlstarter_demo):

```bash
composer require drupal/cmlstarter_demo -W
drush en cmlstarter_demo -y
```
