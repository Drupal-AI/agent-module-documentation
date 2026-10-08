# Installation

## Requirements

Entity Embed Placeholder builds on top of Drupal's rich-text embedding stack, so
you need:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled.
- The contributed **Entity Embed** module (`entity_embed`) installed and enabled,
  with at least one text format configured to allow entity embeds.

There are no third‑party Composer or PHP library requirements. Drupal will pull
in and enable the dependencies for you when you enable this module (Entity Embed
itself must be available via Composer first — see below).

## Install with Composer

From the project root:

```bash
composer require drupal/entity_embed_placeholder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Entity Embed is not already in your project, add it in
the same way (`composer require drupal/entity_embed -W`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_embed_placeholder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_embed_placeholder -y
```

Drupal enables `ckeditor5` and `entity_embed` as dependencies if they are not
already on. That's all it takes — there is no configuration step. Open a
CKEditor 5 field that allows entity embeds and you'll see the compact placeholder
card in place of the full in-editor preview.
