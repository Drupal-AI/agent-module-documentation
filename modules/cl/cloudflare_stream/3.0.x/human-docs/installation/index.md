# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** module (`media`) enabled — Drupal enables it automatically as a
  dependency.
- A **Cloudflare account with Stream enabled**, and from it: an API token with
  Stream permissions, your account ID, and your customer subdomain. You'll enter
  these on the settings form after enabling (see
  [Configuration](../configuration/index.md)).

There are no additional third‑party Composer packages required by the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/cloudflare_stream -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_stream -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudflare_stream -y
```

Enabling the module registers the Cloudflare Video field type, widget, formatters,
Media source, and the settings form — but nothing streams until you add your
credentials.

## Submodule — Cloudflare Stream - Sync

The project bundles one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Cloudflare Stream - Sync** | `cloudflare_stream_sync` | Imports videos that already exist in your Cloudflare account into Drupal as Media items, and provides a `drush cloudflarestream:sync` (alias `css`) command for scheduled/periodic imports. |

Enable it only if you need to pull existing Cloudflare videos back into Drupal:

```bash
drush en cloudflare_stream_sync -y
```

It requires a Media type backed by the Cloudflare Stream source (set that up first —
see [Configuration](../configuration/index.md)).

## Next step

Head to [Configuration](../configuration/index.md) to enter your Cloudflare
credentials and add a video field or Media type.
