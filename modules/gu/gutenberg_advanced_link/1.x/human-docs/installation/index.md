# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Gutenberg** module (`drupal/gutenberg`), enabled and set up as the editor
  for the content types where you want advanced links.

Note: this module is **not covered by Drupal's security advisory policy**, and the
project is currently **seeking a co‑maintainer**.

## Install with Composer

From the project root:

```bash
composer require drupal/gutenberg_advanced_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Gutenberg module if it isn't already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gutenberg_advanced_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gutenberg_advanced_link -y
```

## Verify it worked

Edit a piece of content with the Gutenberg editor, add a link, and confirm the
advanced link options (attributes such as `target`, `rel`, and class) now appear in
the link UI. Test the result on a non‑production environment before relying on it in
production.
