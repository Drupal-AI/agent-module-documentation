# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **js_cookie** module (`js_cookie`) — a hard dependency.
- A Siteimprove.ai account and an authentication token.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/siteimprove -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `js_cookie` and
any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/siteimprove -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en siteimprove -y
```

Enabling Siteimprove also pulls in `js_cookie` as its dependency.

## Verify it worked

Log in as an administrator and go to `/admin/config/system/siteimprove`. You
should see the Siteimprove settings form ready for your token. The overlay does
not appear on content until you enter the token and grant the `use siteimprove`
permission — see [Configuration](../configuration/index.md).
