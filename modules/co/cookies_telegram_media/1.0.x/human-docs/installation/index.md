# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **COOKiES Consent Management** module (`cookies`) — provides the consent
  banner this module hooks into.
- The **Telegram Media Type** module (`telegram_media_type`) — provides the
  Telegram media that gets gated.

Both are hard dependencies. There are no third‑party Composer or PHP library
requirements beyond them.

## Install with Composer

From the project root:

```bash
composer require drupal/cookies_telegram_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in COOKiES, Telegram
Media Type, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookies_telegram_media -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookies_telegram_media -y
```

Enabling this module also enables COOKiES and Telegram Media Type if they are not
already on.

## Verify it worked

Visit a page that embeds Telegram media as an anonymous visitor. Before you accept
cookies in the COOKiES banner, the Telegram embed should be blocked (replaced by a
consent placeholder rather than loading). After you grant consent, the embed
should load normally.
