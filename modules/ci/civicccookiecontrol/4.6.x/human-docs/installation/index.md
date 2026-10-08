# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- A **CIVIC UK Cookie Control account** and an **API key** for the site you are
  deploying on. A free Community edition is available, with paid Pro / Multisite
  Pro tiers; obtain your key from CIVIC UK before configuring the module.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/civicccookiecontrol -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/civicccookiecontrol -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en civicccookiecontrol -y
```

Then apply any pending database updates (the project's install steps call for this):

```bash
drush updb -y
```

## Submodule — GOV.UK styling (optional)

If you need the GOV.UK / DWP cookie-consent look and behaviour, enable the bundled
submodule:

```bash
drush en civic_govuk_cookiecontrol -y
```

It provides a reference implementation of the DWP GOV.UK Cookie Consent pattern on
top of Cookie Control, including handling cookie removal when a user declines
consent. It requires the base module, which is already present once you have
installed the above.

## Verify it worked

After you have configured the module (see [Configuration](../configuration/index.md))
and added your API key, open a public page as a new/anonymous visitor with a clean
browser session — the Cookie Control consent banner should appear.
