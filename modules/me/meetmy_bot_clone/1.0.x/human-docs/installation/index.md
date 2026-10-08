# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`), with **PHP 8.1+** as
  required by Drupal core.
- Core's **Block** (`block`) and **System** (`system`) modules — Block ships with
  core and is enabled automatically as a dependency.
- A **MeetMy.bot Clone service URL** from Eternity.ac — the module embeds the bot
  from that URL, so you need an account/service set up on their side.
- A modern browser with JavaScript enabled for visitors (the bot is a JavaScript
  widget).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/meetmy_bot_clone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/meetmy_bot_clone -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en meetmy_bot_clone -y
```

## Verify it worked

Go to **Configuration → Web Services → MeetMy.bot Clone**
(`/admin/config/services/meetmy-bot-clone`). If the settings form loads, the module
is installed. Enter your global settings (see [Configuration](../configuration/index.md)),
place a **MeetMy.bot Clone** block from **Structure → Block Layout**, and visit a
page in that region to confirm the bot appears.
