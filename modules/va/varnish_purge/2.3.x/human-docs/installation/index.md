# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- **PHP 8.0** or newer.
- The **Purge** module (`purge`) and **Purge Tokens** (`purge_tokens`) — these
  are declared as dependencies, so Composer and Drupal pull them in for you.
  `purge_tokens` is what makes the `[invalidation:expression]` token replacement
  in a purger's path and header fields work.
- A running **Varnish** server you can reach over HTTP/HTTPS, with a VCL that
  understands the request method you plan to use (`BAN` or `PURGE`).

There are no extra third‑party Composer libraries beyond Purge.

## Install with Composer

From the project root:

```bash
composer require drupal/varnish_purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including Purge — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/varnish_purge -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Remember the machine name is `varnish_purger`, not `varnish_purge`:

```bash
drush en varnish_purger -y
```

To actually queue and process invalidations you'll want a few Purge companion
pieces too — a queuer, a processor, and the UI/Drush helpers:

```bash
drush en purge purge_tokens purge_ui purge_drush purge_queuer_coretags purge_processor_cron -y
```

## Submodules — enable only what you need

Varnish Purger ships three optional submodules that all require the base module:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Varnish Purge Tags** | `varnish_purge_tags` | Emits a `Cache-Tags` response header on cacheable pages so your VCL can ban by Drupal cache tag. Enable this for tag‑based invalidation. |
| **Varnish Image Purge** | `varnish_image_purge` | Sends `URIBAN` requests to flush every image‑style derivative of an entity's image fields when it is saved. |
| **Varnish Focal Point Purge** | `varnish_focal_point_purge` | Sends `URIBAN` requests to flush image derivatives when a Focal Point crop entity changes. |

Enable them individually, for example:

```bash
drush en varnish_purge_tags -y
```

## Verify it worked

Add a purger and check Purge's diagnostics:

```bash
drush p:purger-add varnish
drush p:diagnostics
```

The **Varnish** (`varnishconfiguration`) diagnostic must report OK. If it says a
purger is "not configured," open its form and fill in the required fields — see
[Configuration](../configuration/index.md).
