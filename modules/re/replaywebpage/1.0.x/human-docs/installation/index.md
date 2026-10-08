# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Media** module (`media`) — this is a required dependency and Drupal
  enables it automatically.
- Your site should be served over **HTTPS**. ReplayWeb.page uses a browser
  **service worker**, which is only permitted on secure (HTTPS) origins, so replay
  will not work on a plain-HTTP site.

There are no additional third‑party Composer or PHP library requirements — the
ReplayWeb.page viewer assets ship with the module.

> **Note:** This project does **not** have official security-advisory coverage.
> Weigh that when deciding whether to run it on a production site, and keep it
> updated.

## Install with Composer

From the project root:

```bash
composer require drupal/replaywebpage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer enable core Media (if
needed) and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/replaywebpage -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en replaywebpage -y
```

This creates the **Web Archive** media type and registers the ReplayWebPage field
formatter.

## Verify it worked

Go to **Structure → Media types** and confirm a **Web Archive** type now exists.
Then follow [How to use it](../index.md#how-to-use-it) to set the formatter, add
an archive file, and attach it to content. Upload a small WARC/WACZ file and check
that it replays in the browser (remember the site must be on HTTPS for the viewer
to load).
