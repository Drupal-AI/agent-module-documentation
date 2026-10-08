# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** editor (the module is a CKEditor 5 plugin).
- No other contributed module dependencies.
- **Optional:** the `symfony/dom-crawler` library, only if you want the
  server‑side filter that re‑renders each embedded block through the text format
  on Drupal 10/11. Drupal 9 bundled this library in core; Drupal 10 and 11 do
  not, so you add it with Composer (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_insert_blocks -W
```

If you want the optional block‑re‑rendering filter on Drupal 10/11, also pull in
the DOM‑crawler library:

```bash
composer require symfony/dom-crawler
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_insert_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_insert_blocks -y
```

## Verify it worked

The module does nothing until you add its button to a text format's CKEditor 5
toolbar — that is the next step, described in
[Configuration](../configuration/index.md). Once the button is in the toolbar,
open a content field that uses that format, click the Insert Blocks button, and
confirm the block picker appears.
