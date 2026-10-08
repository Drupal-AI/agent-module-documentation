# Installation

## Requirements

- **Drupal 10.1 or newer, or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Guzzle Retry Middleware** library (`caseyamcl/guzzle_retry_middleware`) —
  this is what performs the actual retries. Installing the module with Composer
  normally pulls it in; if it is missing, add it explicitly (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/http_client_retry -W
```

If the retry library was not pulled in automatically, add it:

```bash
composer require caseyamcl/guzzle_retry_middleware
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_client_retry -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_client_retry -y
```

## Verify it worked

Visit the settings form at
**`/admin/config/system/http_client_retry`** to confirm it loads. To see retries in
action, make a request to an endpoint that returns a retryable status — for example
in a development console: `\Drupal::service('http_client')->request('GET',
'https://httpstat.us/503', ['retry_enabled' => TRUE]);`. You should see warning-level
log entries reporting each retry attempt and its backoff delay before the request
finally fails.
