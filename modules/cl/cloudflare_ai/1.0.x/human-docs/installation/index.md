# Installation

## Requirements

- **Drupal 10.5, 11, or 12** (`core_version_requirement: ^10.5 || ^11 || ^12`).
- The **Cloudflare SDK** (`cloudflare_sdk`) and **Cloudflare API**
  (`cloudflare_api`) modules — Composer pulls both in automatically. The SDK
  provides the credential framework and shared HTTP client; the API module is the
  Cloudflare v4 client this module calls.
- A **Cloudflare account**, and an API token scoped for the resources you use (AI
  Gateway and/or Vectorize).

This 1.0.x branch is a pre‑stable alpha, so require it accordingly (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/cloudflare_ai -W
```

While the suite is in alpha, either pin the alpha explicitly or set your
project's `minimum-stability` to `alpha` so the pre‑stable releases resolve:

```bash
composer require "drupal/cloudflare_ai:^1.0@alpha" -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the SDK and API modules — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_ai -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudflare_ai -y
```

This also enables `cloudflare_sdk` and `cloudflare_api`.

## Recommended companion

To route the Drupal **AI** module's features through a Cloudflare gateway (and to
supply embeddings a Vectorize‑backed semantic search can consume), also install
the **Cloudflare AI Gateway Provider**.

## Verify it worked

Log in as an administrator and go to **Configuration → Web services**. You should
see the new *Cloudflare AI Gateways* and *Cloudflare Vectorize* entries. The
module has no AI features of its own until you add a
credential set and at least one resource — see
[Configuration](../configuration/index.md).
