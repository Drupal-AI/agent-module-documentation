# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer**.
- The **`stomp-php/stomp-php`** PHP library
  (<https://github.com/stomp-php/stomp-php>) — Composer installs it automatically
  as a dependency.
- A running **STOMP-capable message broker** such as ActiveMQ, configured to accept
  STOMP connections. See ActiveMQ's getting-started guide and its STOMP guide for
  how to set that up. The broker is separate infrastructure, not something this
  module installs.

## Install with Composer

From the project root:

```bash
composer require drupal/stomp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`stomp-php/stomp-php` library and any other shared dependencies alongside the
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/stomp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stomp -y
```

## Configure the connection

STOMP is configured through your site settings rather than an admin form. Supply
the broker's host, port, and credentials, and assign the Drupal queues that should
run through STOMP. Keep the broker username and password in an environment
variable and reference them from `settings.php` — do not commit them. The module's
`README.md` documents the exact configuration keys and options.

## Verify it worked

With the broker running and the connection configured, queue an item through
Drupal's queue API and confirm it appears in the broker (for example in ActiveMQ's
management console). If the connection details or credentials are wrong, the queue
operations will fail — re-check the host, port, and credentials first.
