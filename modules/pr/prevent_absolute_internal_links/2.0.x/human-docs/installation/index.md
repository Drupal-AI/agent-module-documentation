# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules and no third‑party libraries are required. The module works
  with core's **Link** field type.

This project is **minimally maintained** (maintenance fixes only) and is not
covered by Drupal's security advisory policy — fine for its narrow validation job,
but worth noting.

## Install with Composer

From the project root:

```bash
composer require drupal/prevent_absolute_internal_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prevent_absolute_internal_links -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prevent_absolute_internal_links -y
```

## Verify it worked

Edit any content that has a **Link** field, paste an absolute URL pointing at your
own site (for example `https://www.example.com/node/1`), and save. The save should
be rejected with a message asking you to use the internal reference/autocomplete
instead. Entering the same destination as `/node/1` or via the autocomplete should
save without complaint.
