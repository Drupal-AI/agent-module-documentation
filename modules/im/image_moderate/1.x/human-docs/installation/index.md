# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **Microsoft Azure Cognitive Services** account with access to the Computer
  Vision / image‑moderation API, and its API credential. Screening will not work
  without it.

Be aware this project is **not covered by Drupal's security advisory policy** and
the current release is a development snapshot (`1.x-dev`).

## Install with Composer

From the project root:

```bash
composer require drupal/image_moderate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_moderate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_moderate -y
```

## Store the API credential securely

The module talks to an external API, which means an API key. **Never hard‑code or
commit the key.** Store it in an environment variable and reference it from Drupal —
for example, with DDEV you can save it to `.ddev/.env` and expose it to the web
container, then consume it via a Key entity or `getenv()`. Follow your project's
secret‑handling convention; the key should never live in configuration that gets
committed.

## Verify it worked

Go to **Configuration → Media → Image Moderate**
(`/admin/config/media/image_moderate`) — the settings form should load. You won't
get real moderation results until you've entered valid API credentials there; see
[Configuration](../configuration/index.md).
