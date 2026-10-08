# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a
  dependency.
- A modern browser that supports the **Fullscreen API** (Chrome, Firefox, Safari,
  and other current browsers do).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/full_screen_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/full_screen_mode -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en full_screen_mode -y
```

## Verify it worked

Go to **Structure → Block layout** and place the **Full Screen Mode** block in a
region (see the [main guide](../index.md) for the block settings). Reload a page in
that region and click the toggle button — the browser should switch into
full-screen mode.
