# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A number of modules Liveblog depends on: core **Field**, **Node**, **REST**,
  **Taxonomy**, **Views**, **Serialization**, **HAL**, **Link**, **Options**,
  **Menu UI**, **Path**, **Text**, and **Language**, plus the contributed
  **Simple Google Maps** (`simple_gmap`) module. Composer resolves these for you.
- For real‑time delivery: a **Pusher** account (app id, key, secret, cluster) — or
  another websocket provider if you implement a custom channel.

There are no special PHP library requirements beyond what the dependencies pull
in.

> **A note on security coverage:** at the documented version this project is **not**
> covered by the Drupal security advisory policy (it is an alpha release). Test
> before relying on it in production, and re‑read the exposure notes in the
> [overview](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/liveblog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Simple Google Maps
and update the shared core dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/liveblog -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en liveblog -y
```

## Enable the Pusher notification channel (recommended)

Real‑time push is provided by the bundled **Liveblog Pusher** submodule. Enable it
if you want new posts pushed to readers over Pusher's socket service (without it,
clients fall back to polling the JSON post‑list endpoint):

```bash
drush en liveblog_pusher -y
```

You'll enter your Pusher credentials on the Liveblog settings form — see
[Configuration](../configuration/index.md).

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring →
Liveblog** (`/admin/config/content/liveblog`). You should see the settings form
with a notification‑channel selector. If you enabled the Pusher submodule, the
Pusher credential fields should be available there. Then create a **Liveblog** node
and confirm you can add posts to it.
