# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer.**
- **Purge module** (`drupal/purge`) — a *soft* dependency. It is not required to
  enable Stale 404 Purge, but without Purge installed and configured for your
  reverse proxy/CDN, the module only detects and logs events; nothing is actually
  purged. Install Purge to make the module do its job.
- **Redirect module** (`drupal/redirect`) — an optional soft dependency. The
  redirect entity type is checked at runtime, so there is no hard requirement; if
  Redirect is present, deleting a redirect triggers a purge of its source path.

## Install with Composer

From the project root:

```bash
composer require drupal/stale_404_purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/stale_404_purge -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

To get actual purges, also install the Purge module (and a purger for your
reverse proxy):

```bash
composer require drupal/purge -W
```

## Enable the module

```bash
drush en stale_404_purge -y
```

## Wire it up to Purge

Enabling the module alone does not send purges. Finish the setup like this:

1. Install and enable the **Purge** module, then configure a **purger** and
   **queue** for your reverse proxy or CDN (Varnish, a CDN's cache-tag/URL purge
   API, and so on).
2. Go to **Configuration → Development → Performance → Purge**
   (`/admin/config/development/performance/purge`).
3. Enable the **`stale_404_purge` queuer**. This is the switch that lets the
   module enqueue its targeted invalidations.

## Verify it worked

Publish a node whose URL had previously returned a 404, then check the logs — the
module debug-logs every dispatched target path set, so you should see the
canonical path and alias it enqueued. If Purge is not yet configured, you'll
instead see a notice that the event was detected but nothing was sent.
