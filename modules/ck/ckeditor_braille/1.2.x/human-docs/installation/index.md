# Installation

## Requirements

- **Drupal 10.5, 11, or 12** (`core_version_requirement: ^10.5 || ^11 || ^12`).
- Core's **CKEditor 5** module (`ckeditor5`), which Drupal enables automatically
  as a dependency.

There are no third-party Composer packages or PHP library requirements. The
module ships with prebuilt JavaScript assets
(`js/build/ckeditorbraille.umd.js` and `.css`), so no build step is needed to use
it. (A TypeScript source and a `npm install` / `npm run watch` workflow are
documented for developers who want to rebuild the plugin.) This module is covered
by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_braille -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor_braille -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_braille -y
```

## Verify it worked

Edit a CKEditor 5 text format (**Configuration → Content authoring → Text formats
and editors**) and confirm a **Braille** toolbar item is available to add. After
setting it up (see [Configuration](../configuration/index.md)), edit some content
and confirm you can toggle Braille input on and type Braille. You can also visit
the practice page at `/ckeditor-braille/exercise`.
