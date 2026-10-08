# Installation

## Requirements

- **Drupal 9.5, 10, 11, or 12** (`core_version_requirement: ^9.5 || ^10 || ^11 || ^12`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a
  dependency.
- No third‑party Composer or PHP library requirements.

Because translation happens in the visitor's browser via Google's hosted service,
there is **no API key to obtain** for the basic widget — the tradeoffs are the
ones described on the [overview page](../index.md), not a setup cost.

## Install with Composer

From the project root:

```bash
composer require drupal/g_translate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/g_translate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en g_translate -y
```

## Verify it worked

Go to **Configuration → Regional and language → GTranslate**
(`/admin/config/regional/g-translate`) and confirm the settings form loads. Then
place the GTranslate block via **Structure → Block layout**, save, and load a
front‑end page — the language selector should appear, and choosing a language
should translate the page in the browser.
