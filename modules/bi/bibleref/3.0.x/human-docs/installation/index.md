# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Taxonomy** module (`taxonomy`), which backs the reference data. Drupal
  enables it automatically as a dependency when you turn on Bible Reference.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bibleref -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bibleref -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bibleref -y
```

After enabling, add the Bible-reference field to a content type under **Structure →
Content types → (your type) → Manage fields** to start capturing scripture
citations.
