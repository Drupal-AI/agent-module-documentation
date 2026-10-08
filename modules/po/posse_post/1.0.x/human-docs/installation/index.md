# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** (`system`), **User** (`user`), and **Node** (`node`) modules — all part of
  Drupal core. POSSE Post has **no third‑party Drupal module dependencies**.
- **API credentials** for each social platform you want to syndicate to (Bluesky, Mastodon,
  Facebook, Instagram, LinkedIn). See the module's documentation for how to obtain each one.
- **Recommended:** `vlucas/phpdotenv`, so you can load credentials from a `.env` file in your
  project root instead of setting server environment variables by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/posse_post -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/posse_post -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en posse_post -y
```

## Verify it worked

1. Go to **Configuration → Web services → POSSE Post → Social Accounts** and confirm you can
   add an account.
2. Add and authenticate at least one platform account (see
   [Configuration](../configuration/index.md)), set `SEND_CROSSPOSTS=1` in your production
   environment, publish a test node, and confirm the crosspost appears (on the next cron run, or
   by publishing it immediately from the admin UI).
