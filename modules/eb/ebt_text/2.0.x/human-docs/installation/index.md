# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`ebt_core`) — the shared base for the Extra Block Types family; it
  is the only dependency, and Composer installs it for you.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_text -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_text -y
```

## Verify it worked

Go to **Content → Blocks → Add content block** (or open Layout Builder) — you should
see the **Text** block type. Add one, enter a title and body, place it, and confirm
the styled text renders with the EBT design options applied.
