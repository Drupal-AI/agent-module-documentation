# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field**, **Filter**, **Image**, and **Text** modules — all part of a
  standard Drupal install and enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

Note two constraints described in the [overview](../index.md): this release only
acts on the **Article** content type's `field_image` → `body` mapping in the
`full` view mode, and it is **incompatible with Layout Builder**.

## Install with Composer

From the project root:

```bash
composer require drupal/imagefieldintextifnone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imagefieldintextifnone -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagefieldintextifnone -y
```

## Verify it worked

There is no settings page to check. Instead, view an **Article** whose `body`
contains no embedded image: the image from `field_image` should now appear in the
body between the first and second paragraphs. If nothing changes, confirm your
site actually has an Article type with a `field_image` image field and that you
are viewing the full (not teaser) display.
