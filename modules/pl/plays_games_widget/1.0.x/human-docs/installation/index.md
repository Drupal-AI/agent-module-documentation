# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- An **internet connection** from visitors' browsers to the Plays Games service, since
  the game content is served externally.
- No additional Drupal modules or third-party libraries.

Note the project's security advisory coverage is marked **not covered** at this
version — review your risk posture before using it on a high-value production site.

## Install with Composer

From the project root:

```bash
composer require drupal/plays_games_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plays_games_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plays_games_widget -y
```

## Verify it worked

Open the **Plays Games Widget dashboard** from the administration interface and check
the live preview and service diagnostics. Then go to **Structure → Block layout**, place
a **Plays Games Widget** block in a region, configure and save it (see
[How to use it](../index.md#how-to-use-it)), and view a front-end page to confirm the
games feed loads and is playable. If the feed does not appear, confirm the server/site
can reach the Plays Games service over the internet.
