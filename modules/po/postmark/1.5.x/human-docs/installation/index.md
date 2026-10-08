# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Mail System** module (`drupal/mailsystem`) — Postmark registers itself as
  a mail plugin that Mail System routes to.
- Two PHP libraries, installed automatically by Composer:
  - **`wildbit/postmark-php`** (`^4.0`) — the official Postmark API client.
  - **`html2text/html2text`** (`^4.3`) — generates a plain-text alternative from
    HTML bodies.
- A **Postmark account** with a Server API token and at least one verified Sender
  Signature (set up at postmarkapp.com, not in Drupal).

## Install with Composer

From the project root:

```bash
composer require drupal/postmark -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the two PHP
libraries and Mail System, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/postmark -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en postmark -y
```

Enabling Postmark also enables Mail System if it isn't already on.

## Check the Status report

Postmark reports its health on the **Status report**
(`/admin/reports/status`): an error if the `wildbit/postmark-php` library is
missing, a warning if the library is present but your API token or Sender
Signature isn't configured yet, and OK once both are set. Continue to
[Configuration](../configuration/index.md) to enter those values.
