# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Gutenberg** module (`drupal/gutenberg`), set up as the editor for the
  relevant content types.
- The **AOS** module (`drupal/aos`), which provides the Animate On Scroll library
  integration this module builds on.

Note: this module is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/gutenberg_aos -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Gutenberg and AOS modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gutenberg_aos -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gutenberg_aos -y
```

Drupal enables the Gutenberg and AOS dependencies at the same time.

## Verify it worked

Open the Gutenberg editor, select a block, and open its settings. You should see a
new **AOS settings** section. Apply an animation, save, and view the published page
— the block should animate in as you scroll it into view.
