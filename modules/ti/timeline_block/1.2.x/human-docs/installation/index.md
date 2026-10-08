# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency.

There are no third-party Composer or PHP library requirements. Note that this
release is **not** covered by drupal.org's security advisory policy — weigh that
before relying on it on a security-sensitive production site.

## Install with Composer

From the project root:

```bash
composer require drupal/timeline_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/timeline_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en timeline_block -y
```

## Verify it worked

Go to **Structure → Block layout → Place block**. The **Timeline Block** should
appear in the block list. Place it, add a couple of entries, choose a layout, and
save — then view the page to see your timeline render.
