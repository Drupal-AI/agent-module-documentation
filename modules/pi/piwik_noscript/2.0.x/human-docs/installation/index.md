# Installation

## Requirements

- **Drupal 11.1 or higher** (`core_version_requirement: ^11.1 || ^12`; the `^12`
  reaches toward a Drupal major that does not exist yet, so in practice this is a
  Drupal 11.1+ module).
- Optionally, the **Matomo** module (`matomo`). It is not required — Matomo Noscript
  works standalone — but if it is present, this module reads the Matomo site ID and
  URL from it instead of from `settings.php`.
- A **Matomo instance** (self-hosted or Matomo Cloud) that will receive the tracking
  requests.

## Install with Composer

From the project root:

```bash
composer require drupal/piwik_noscript -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/piwik_noscript -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en piwik_noscript -y
```

## Configure the Matomo target

Enabling the module is not enough on its own — it needs to know which Matomo instance
and site to send requests to:

- **With the Matomo module:** configure your site ID and Matomo URL in the Matomo
  module, and this module uses them automatically.
- **Without the Matomo module:** add the required values to your `settings.php` (see
  the module's README for the exact keys), then run `drush cr`.

## Verify it worked

Load any page of your site and view its HTML source. Near the bottom you should find a
`<noscript>` block containing a Matomo tracking `<img>` pointing at your Matomo server
with your site ID. You can also check that hits appear in your Matomo dashboard.
Remember that this fallback is subject to the same consent and privacy handling as the
main tracker — see the notes in the [guide overview](../index.md).
