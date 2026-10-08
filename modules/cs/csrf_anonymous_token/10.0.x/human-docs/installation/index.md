# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No module dependencies and no Composer/PHP library requirements.

> **Before you install:** this module is **not covered** by Drupal's security
> advisory policy, and — as described in the [main guide](../index.md) — it can
> break legitimate anonymous form submissions. Review the caveats and test carefully before using it anywhere near
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/csrf_anonymous_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/csrf_anonymous_token -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en csrf_anonymous_token -y
```

There is nothing to configure — the form alter runs on every tokenless form
build as soon as the module is enabled.

## Verify it worked

Because the effect is global and invisible, the practical verification is to
**exercise your anonymous forms** — login, register, contact, and search — as an
anonymous visitor and confirm they still submit correctly, including when the
internal page cache is serving cached pages. If anonymous submissions start
failing, this module is the likely cause; uninstalling it removes the added
behavior immediately.
