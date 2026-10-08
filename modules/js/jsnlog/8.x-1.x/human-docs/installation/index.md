# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **JSNLog JavaScript library**, installed into `/libraries` (see below). The
  module implements the library but does not bundle it.
- Optionally, the **WhichBrowser** library for nicer browser/OS output in the log.
- No other contributed modules are required.

## Install the module with Composer

From the project root:

```bash
composer require drupal/jsnlog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jsnlog -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Install the JSNLog JavaScript library

JSNLog needs the JSNLog library present on disk. You have two options.

**Managed by Composer (recommended).** Add the asset‑packagist repository and
installer support to your **root** `composer.json`, then require the library:

```json
{
    "type": "composer",
    "url": "https://asset-packagist.org"
}
```

Make sure your `installer-paths` include library asset types and add
`installer-types`:

```json
"installer-types": ["bower-asset", "npm-asset"]
```

Then:

```bash
composer require bower-asset/jsnlog
```

**Manual download.** Alternatively, download the JSNLog library from the JSNLog
project and place the folder under your webroot's `libraries` directory named
`jsnlog`. Optionally, for better output, download the WhichBrowser library and
place it under `libraries` named `whichbrowser`.

## Enable the module

```bash
drush en jsnlog -y
```

Then activate and configure it at **Configuration → Development → JSNLog** — see
[Configuration](../configuration/index.md).

> **Compatibility note:** JSNLog was originally written for Drupal 8/9. On current
> Drupal 11 there is a known compatibility issue in the module's request‑logging
> access check that can prevent it from being enabled. If `drush en jsnlog` fails
> on Drupal 11, check the project's issue queue for a compatible release or patch
> before relying on it in production.

## Troubleshooting

If nothing is being logged, check your ad blocker — some block the JSNLog script,
especially when asset aggregation is off or you're using the library's CDN option.

## Verify it worked

With the module enabled and the library in place, trigger a JavaScript error on
the front end (or call `JL().info("test")` from the console), then look in
**Reports → Recent log messages**. The message should appear there.
