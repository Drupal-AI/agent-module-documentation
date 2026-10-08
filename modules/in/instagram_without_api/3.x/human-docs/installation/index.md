# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a
  dependency.
- The Instagram account you display must be **public** (not private).
- Your server must be able to make outbound HTTPS requests to `instagram.com`.

There are no third‑party Composer or PHP library requirements — and, by design,
no API key or access token.

## Install with Composer

From the project root:

```bash
composer require drupal/instagram_without_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/instagram_without_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en instagram_without_api -y
```

## Verify it worked

Go to **Structure → Block Layout**, click **Place block** on any region, and
search for **Instagram Without API**. If it appears in the list, the module is
installed — place it, enter a public account name, and save to see the feed.
