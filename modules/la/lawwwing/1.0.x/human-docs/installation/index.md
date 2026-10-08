# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A valid **Lawwwing account and API key** — the banner, consent records, and
  legal documents are served by the Lawwwing service, so you need an account with
  them first. Sign up at [lawwwing.com](https://lawwwing.com).
- **Outbound internet access** from your Drupal installation to Lawwwing, so the
  module can fetch configuration and updates and the browser can load the widget.

There are no third‑party Composer or PHP library requirements bundled with the
module.

> **Security coverage:** this module is **not** covered by Drupal's security
> advisory policy. It also loads a third‑party script and transmits consent data
> to Lawwwing — review that against your privacy and CSP requirements before
> deploying.

## Install with Composer

From the project root:

```bash
composer require drupal/lawwwing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lawwwing -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lawwwing -y
```

## Verify it worked

Go to **Configuration → Lawwwing Settings** and confirm the form loads. Nothing
appears on the front end until you enter your Lawwwing Plugin ID — see
[Configuration](../configuration/index.md). Once configured, load a front‑end page
in a fresh browser session and the Lawwwing cookie banner should appear.
