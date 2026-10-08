# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A multilingual site — core's **Language** module with **two or more languages**
  enabled, at least one of which differs from your site default, so there is
  something to suggest.

There are no third‑party Composer or PHP library requirements. The optional
MaxMind GeoIP2 Country database integration only matters if you want IP‑based
country detection; the module works from the browser language without it.

## Install with Composer

From the project root:

```bash
composer require drupal/language_suggestion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_suggestion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_suggestion -y
```

## Verify it worked

Open **Configuration → Regional and language → Language Suggestion**
(`/admin/config/regional/language-suggestion`) — the settings form should load.
To see the suggestion box in action, set your browser to a single language that
differs from your current site language but is enabled on your site, then visit a
page in a private/incognito window. The suggestion box should appear once you have
added the matching entry to the browser‑language mapping (see
[Configuration](../configuration/index.md)).
