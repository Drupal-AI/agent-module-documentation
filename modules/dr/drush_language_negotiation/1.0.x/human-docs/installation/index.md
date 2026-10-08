# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Language** module enabled — this module adds a language-negotiation
  method, which only makes sense on a multilingual site.
- **Drush**, since the method only takes effect during command-line runs.

There are no third-party Composer or PHP library requirements, and no other
module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_language_negotiation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drush_language_negotiation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_language_negotiation -y
```

## Turn on the negotiation method

Enabling the module registers a new negotiation method but does not activate it.
Go to **Configuration → Regional and language → Languages → Detection and
selection** (`/admin/config/regional/language/detection`), enable the **Drush
Language Switching** method, make sure it is prioritised high enough to win for
CLI runs, and save. See the [main guide](../index.md) for details.

## Verify it worked

On a multilingual site whose default language is not English, run a Drush command
that previously produced the wrong language (for example importing configuration
or generating content) and confirm it now uses the site's default language. Your
website's front-end language behavior should be unchanged.
