# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies.
- **No Google API key** is needed — the module uses Google's client‑side Website
  Translate widget rather than a server‑side API. Visitors' browsers do, however,
  need outbound access to Google for the widget to load and translate.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/multilingual_google_web_translator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multilingual_google_web_translator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multilingual_google_web_translator -y
```

Once enabled, a **Google Translation Block** becomes available in your block
system, ready to place.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`). The **Google
Translation Block** should be available to place. Place it (see
[Configuration](../configuration/index.md)), then load a front‑end page and confirm
the language dropdown appears and translates the page.
