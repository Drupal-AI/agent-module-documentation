# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No special requirements — the module has no other module dependencies and no
  third-party PHP libraries. (It works with core's contact forms, so you'll want
  the core Contact module enabled to have forms to index.)

## Install with Composer

From the project root:

```bash
composer require drupal/contact_indexing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_indexing -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_indexing -y
```

## Verify it worked

Edit any contact form at **Structure → Contact forms** — you should see a new
**Enable Form Indexing** checkbox on the form. Tick it, save, then view that
form's page and check its HTML source for a robots meta tag carrying
`index,follow`.
