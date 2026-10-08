# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **Language** module (`language`), enabled automatically as a dependency.
  The block only appears on a genuinely multilingual site with exactly two
  languages configured.

There are no third-party Composer or PHP library requirements. The link icon uses a
Font Awesome class, so it displays best where a Font Awesome library is available in
your theme, but this is not a hard dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/bilingual_switch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bilingual_switch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bilingual_switch -y
```

After enabling, place the **Bilingual Language Switcher** block through **Structure →
Block layout** (`/admin/structure/block`) and set its prefix text if you want to
change the default "Switch to".
