# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No other modules are required, and there are no third‑party Composer or PHP
  library requirements — the module does its own Hijri conversion and translation
  without external libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/hijri_format -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hijri_format -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hijri_format -y
```

## Verify it worked

Go to **Structure → Content types → *(a type)* → Manage display**. For a date
field (or the *Authored on* / *Changed* dates), open the **Format** drop‑down —
you should now see a Hijri display option. Choosing it renders that date in the
Hijri calendar. To set the default format, Umm al‑Qura adjustment, and numeral
style, see [Configuration](../configuration/index.md).
