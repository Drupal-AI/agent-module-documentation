# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No modules outside of Drupal core are required.
- A **FreecurrencyAPI account and API key** — sign up at
  [freecurrencyapi.com](https://freecurrencyapi.com/) to obtain one. You'll enter it
  during configuration.
- **Cron** running regularly, so exchange rates refresh automatically (you can also
  refresh them by hand).

## Install with Composer

From the project root:

```bash
composer require drupal/freecurrency -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/freecurrency -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en freecurrency -y
```

## A note on the API key

Treat your FreecurrencyAPI key as a secret. Store it in an **environment variable**
(and, where possible, reference it through a **Key** entity) rather than pasting it
into configuration that gets exported to version control. This keeps the credential
out of your repository. You'll add the key on the module's Settings tab, covered in
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → Web services → Administer Currency Converter
(FreecurrencyAPI)**. You should see the module's admin interface with **Settings**,
**Currencies**, and **Rates** tabs, ready for you to add your key and sync data.
