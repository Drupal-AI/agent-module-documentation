# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Key** module (`key`), for storing the API token securely — Composer pulls
  it in automatically.
- Core's **System** module (always present).
- A **Cloudflare account on the Workers Paid plan** with the Email Service
  enabled, a **verified sending domain** (Cloudflare provisions the required MX,
  SPF, DKIM and DMARC DNS records), and an **API token with the *Email Sending:
  Send* permission**.

The 1.0.x branch is an early alpha (`1.0.0-alpha1`), so treat it as experimental.

## Install with Composer

From the project root:

```bash
composer require drupal/cloudflare_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the Key module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_email -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudflare_email -y
```

If the Key module was not already on, enable it too (`drush en key -y`); Composer
and Drush usually handle this for you.

## Submodules

Cloudflare Email ships two optional submodules — enable only what you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Analytics** | `cloudflare_email_analytics` | A delivery‑report controller and route, with its own permission, for viewing email analytics. |
| **Symfony Mailer Lite bridge** | `cloudflare_email_symfony_mailer_lite` | Integrates the Cloudflare transport with the Symfony Mailer Lite module, as an alternative to setting the mail plugin directly. |

For example:

```bash
drush en cloudflare_email_analytics -y
```

## Verify it worked

Go to **Reports → Status report** — Cloudflare Email adds a health check that
tells you whether it is configured and active. It will report "not configured"
until you complete the [Configuration](../configuration/index.md) steps. You can
also send a test message once configured with
`drush cloudflare-email:test you@example.com`.
