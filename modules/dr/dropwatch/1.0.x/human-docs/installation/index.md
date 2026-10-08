# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **DropWatch account** — the module reports to the DropWatch service and needs
  an account and credential to connect. Full setup documentation is provided
  within the DropWatch app once you have access.

There are no module dependencies or third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dropwatch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dropwatch -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dropwatch -y
```

> **Note:** This is a beta release (1.0.0‑beta7). Test it on a non‑production
> environment first.

## Verify it worked

1. Confirm the module is enabled at **Extend** (`/admin/modules`).
2. Connect the site to your DropWatch account using the credential/token and the
   instructions in the DropWatch app, storing the token as a secret (see "How to
   use it" in the [overview](../index.md)).
3. Confirm the site shows up in your DropWatch dashboard and reports its status.
