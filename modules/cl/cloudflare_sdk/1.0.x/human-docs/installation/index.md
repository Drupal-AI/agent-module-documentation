# Installation

## Requirements

- **Drupal 10.5, 11, or 12** (`core_version_requirement: ^10.5 || ^11 || ^12`).
- The **Cloudflare API** module (`cloudflare_api`), which Composer installs
  automatically as a dependency.
- A **Cloudflare account** and an API token to make a credential set actually
  useful.

This 1.0.x branch is a pre‑stable alpha, so require it accordingly (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/cloudflare_sdk -W
```

While the suite is in alpha, either pin the alpha explicitly or set your
project's `minimum-stability` to `alpha` so the pre‑stable release resolves:

```bash
composer require "drupal/cloudflare_sdk:^1.0@alpha" -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the Cloudflare API module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_sdk -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudflare_sdk -y
```

Enabling it also enables `cloudflare_api`. Often you will not run this by hand —
another Cloudflare module lists the SDK as a dependency and Drupal enables it for
you.

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → Cloudflare
credentials**. If the credential‑set screen loads, the SDK is installed. Then add
a credential set and its `settings.php` secrets as described in the
[overview](../index.md#set-up-a-credential-set).
