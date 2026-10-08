# Installation

## Requirements

- **Drupal 10.3 or newer** (`core_version_requirement: >=10.3`).
- The **Feeds** module (`feeds`), **version 3.0.0 or higher** — this fetcher is
  designed for the API and structures Feeds 3.x provides.
- The **Key** module (`key`) — used to store and retrieve the FileMaker API
  credentials securely.
- A reachable **FileMaker Data API** endpoint (served over HTTPS) with credentials
  you can use.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_filemaker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds, Key and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_filemaker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_filemaker key -y
```

Drupal enables Feeds automatically if it isn't already on.

## Set up the credential keys

The fetcher reads three **Key** entities rather than storing FileMaker credentials
in module configuration:

- `filemaker_auth_endpoint` — the FileMaker Data API sessions URL, e.g.
  `https://<host>/fmi/data/vLatest/databases/<db>/sessions`.
- `filemaker_username` — the FileMaker account username.
- `filemaker_password` — the FileMaker account password.

Supply their values via `settings.php` config overrides so the secrets stay out of
exported configuration, for example:

```php
$config['key.key.filemaker_auth_endpoint']['key_provider_settings']['key_value'] = 'https://<host>/fmi/data/vLatest/databases/<db>/sessions';
$config['key.key.filemaker_username']['key_provider_settings']['key_value'] = 'USERNAME';
$config['key.key.filemaker_password']['key_provider_settings']['key_value'] = 'PASSWORD';
```

> **Keeping secrets out of the repo.** Don't hard‑code passwords in committed
> files. Store the values in environment variables and reference them from
> `settings.php` (or a Key env provider). With DDEV you can save a variable with
> `ddev dotenv set .ddev/.env --filemaker-password=<value>` (keep `.ddev/.env` out
> of version control) and `ddev restart`, then read it with `getenv()` in
> `settings.php`.

## Verify it worked

Create a feed type at **Structure → Feed types** and confirm that the **FileMaker
API fetcher** and **FileMaker parser** appear in the fetcher and parser options.
Once your keys are set, run a small import to confirm the connection authenticates
and records come back.
