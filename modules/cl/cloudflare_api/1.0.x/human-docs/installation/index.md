# Installation

## Requirements

- **Drupal 10.5, 11, or 12** (`core_version_requirement: ^10.5 || ^11 || ^12`).
- No other Drupal modules are required — it depends only on the PSR HTTP
  interfaces already present in Drupal core.
- A **Cloudflare account** with an API token, if you actually want the client to
  reach Cloudflare. Creating a token is covered in Cloudflare's own docs at
  `developers.cloudflare.com/fundamentals/api/get-started/create-token`.

This 1.0.x branch is a pre‑stable alpha, so require it accordingly (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/cloudflare_api -W
```

While the suite is in alpha, either pin the alpha explicitly or set your
project's `minimum-stability` to `alpha` so the pre‑stable release resolves:

```bash
composer require "drupal/cloudflare_api:^1.0@alpha" -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudflare_api -y
```

Usually you will not enable this by hand — a higher‑level Cloudflare module (the
SDK, AI Gateway, and so on) lists it as a dependency and Drupal enables it for you.

## Verify it worked

Confirm the module is active with
`drush pm:list --status=enabled | grep cloudflare_api`. There is nothing to click:
the client comes into play only when another module uses it.
