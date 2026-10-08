# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Feeds** module (`feeds`), **version 3.x** — this fetcher extends Feeds'
  core HTTP fetcher.
- The **Key** module (`key`, 8.1.x) — used to store the OAuth client credentials.

This is an early (alpha) release, so test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_http_oauth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds, Key and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_http_oauth -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_http_oauth key -y
```

Drupal enables Feeds automatically if it isn't already on.

## Set up the credential keys

The fetcher reads the OAuth client ID and client secret from **Key** entities
rather than storing them in feed configuration. Create the keys under
**Configuration → System → Keys**, and back them with an environment variable or a
secure key provider rather than pasting plaintext secrets. With DDEV you can store
a value with `ddev dotenv set .ddev/.env --oauth-client-secret=<value>` (keep
`.ddev/.env` out of version control) and `ddev restart`, then reference it from a
Key env provider.

## Verify it worked

Create or edit a feed type at **Structure → Feed types** and confirm that
**Download from url (OAuth 2.0)** appears in the **Fetcher** options. Once your
keys exist, add a feed, fill in the OAuth settings, and run a small import to
confirm a token is obtained and data comes back.
