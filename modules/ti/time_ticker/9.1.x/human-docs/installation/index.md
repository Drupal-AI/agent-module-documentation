# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency.

There are no third-party Composer or PHP library requirements. Note that this
release is **not** covered by drupal.org's security advisory policy — weigh that
before using it on a security-sensitive production site.

## Install with Composer

From the project root:

```bash
composer require drupal/time_ticker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/time_ticker -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en time_ticker -y
```

Once enabled, set the timezone and place the block — see
[Configuration](../configuration/index.md).

## Verify it worked

After placing the **Time Ticker** block in a region (see Configuration), visit a
page that shows the block. You should see the current date and time, and it should
advance second by second without reloading the page.
