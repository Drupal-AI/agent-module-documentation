# Installation

## Requirements

Google Site Review is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No modules outside of Drupal core, and no third‑party PHP libraries.

If your configuration links the module to Google's reviews data through an API
key or Place ID, you'll also need that credential from Google — keep it as a
secret (see the note below).

## Install with Composer

From the project root:

```bash
composer require drupal/gareview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gareview -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gareview -y
```

## A note on credentials

If your site connects to Google's reviews API, never hard‑code or commit the API
key. Store it in an environment variable — with DDEV you can save it once with
`ddev dotenv set .ddev/.env --google-api-key=<value>` and then `ddev restart` —
and reference it from Drupal rather than pasting it into exported configuration.

## Verify it worked

Log in as an administrator and confirm **Google Site Review** appears as enabled
on the **Extend** page (`/admin/modules`). You can then place its output (a
block) in a region and load a page to confirm the Google reviews render.
