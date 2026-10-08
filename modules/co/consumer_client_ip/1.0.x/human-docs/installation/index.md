# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`composer.json` requires `php >=8.1`).
- The **Consumers** contrib module (`consumers:consumers`) — Composer pulls it in
  automatically with the command below.
- No third-party PHP library requirements.
- For the mapping to take effect, your site also needs **trusted reverse-proxy
  settings** (`reverse_proxy`, `reverse_proxy_addresses`) configured in `settings.php`
  — see the note below.

## Install with Composer

From the project root:

```bash
composer require drupal/consumer_client_ip
```

Composer resolves the Consumers module (`drupal/consumers`) as a dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/consumer_client_ip`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en consumer_client_ip -y
```

This enables Consumer Client IP along with the Consumers module if it is not
already on.

## Reverse-proxy configuration

The module copies the header you map into `X-Forwarded-For`. For Drupal to actually
read the client IP from `X-Forwarded-For`, configure `reverse_proxy` and
`reverse_proxy_addresses` in `settings.php` for your proxy addresses, and map a header
that your proxy/CDN sets. See the [overview](../index.md) for the step-by-step setup.

## Verify it worked

After configuring the header mapping on the relevant consumer (see the
[overview](../index.md)), confirm that Drupal reports the real visitor IP — for
example that flood control counts requests per real client.
