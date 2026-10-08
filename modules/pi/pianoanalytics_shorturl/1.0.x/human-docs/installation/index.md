# Installation

## Requirements

Piano Analytics Short URL is a bridge, so it needs both of the modules it
connects:

- **Drupal 10.3+ or 11.2+** (`core_version_requirement: ^10.2 || ^11`).
- **[Short URL](https://www.drupal.org/project/shorturl)** version `^2`
  (`shorturl`) — the module whose redirect visits it tracks.
- **Piano Analytics Server** (`pianoanalytics_server`), the server‑side submodule
  of **[Piano Analytics](https://www.drupal.org/project/pianoanalytics)** `^2.4` —
  which actually sends the events to Piano.

Composer pulls both dependencies in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/pianoanalytics_shorturl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in Short URL and Piano Analytics.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pianoanalytics_shorturl -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pianoanalytics_shorturl -y
```

This also enables the required `shorturl` and `pianoanalytics_server` modules if
they aren't already on.

## Verify it worked

First configure your Piano credentials in the Piano Analytics Server submodule,
then go to **Short URL settings** (`/admin/config/shorturl/settings`) and confirm
a **Piano Analytics** section is present (see the [overview](../index.md)). Visit
one of your short URLs, then check that the corresponding event appears in your
Piano Analytics dashboard — it is sent server‑side just after the redirect
completes.
