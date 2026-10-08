# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- Core's **System** module (always on).
- A **Cloudflare account** with your site proxied through it, so you have a **Zone
  ID** and either an API **Bearer Token** (scoped to Cache Purge) or your account
  **Email + Global API Key**.
- **Optional but recommended:** the [Key](https://www.drupal.org/project/key)
  module for secure credential storage. It is only *suggested*, not required.
- The core **Database Logging** (`dblog`) module if you want the Purge History
  page to show recent operations.

## Install with Composer

From the project root:

```bash
composer require drupal/cloudflare_purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_purge -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudflare_purge -y
```

If you plan to store credentials with the Key module, enable it too:

```bash
composer require drupal/key -W
drush en key -y
```

On a fresh install with Key already present, the module defaults its storage
method to `key`; otherwise it starts in `plain` config mode.

## Handling your Cloudflare secrets

Do not commit an API token or Global API Key to version control. The recommended
approach is to keep the secret in an environment variable and expose it through a
Key entity, or to set the credentials in `settings.php` (which also keeps them out
of the database and config export). See
[Configuration](../configuration/index.md) for the three storage tiers and how
they resolve.

## Verify it worked

Go to **Configuration → Cloudflare Purge → Credentials**
(`/admin/config/cloudflare-purge/credentials`) and enter your Zone ID and token.
Then run `drush cloudflare:status` — it reports whether credentials are configured
and by which method. Once credentials are valid, the manual purge forms' submit
buttons become active. Next, see [Configuration](../configuration/index.md).
