# Installation

## This module is obsolete — install Cloudflare AI instead

The **Cloudflare AI Gateway** module has been consolidated into the broader
**Cloudflare AI** module and is no longer maintained on its own. There is no
reason to install `cloudflare_ai_gateway` on a new site. Everything it did — the
gateway configuration entity, the request‑URL and `cf-aig-*` header building, and
the live model catalogue — now lives in Cloudflare AI, unchanged.

## Requirements (for the replacement)

- **Drupal 10.5, 11, or 12** (`core_version_requirement: ^10.5 || ^11 || ^12`).
- The **Cloudflare SDK** and **Cloudflare API** modules, pulled in automatically.
- A **Cloudflare account** and an API token.

## Install the replacement with Composer

From the project root:

```bash
composer require drupal/cloudflare_ai -W
```

While the suite is in alpha, pin the alpha (or set your project's
`minimum-stability` to `alpha`):

```bash
composer require "drupal/cloudflare_ai:^1.0@alpha" -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_ai -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the replacement

```bash
drush en cloudflare_ai -y
```

## If you already have this module installed

Switch your dependency to `drupal/cloudflare_ai`. The gateway configuration entity
and the AI provider are unchanged, so the **Cloudflare AI Gateway Provider** keeps
working once its dependency points at Cloudflare AI. Then follow the
[Cloudflare AI setup guide](../../cloudflare_ai/1.0.x/human-docs/index.md).
