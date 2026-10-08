# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **ReadRemaining.js** front‑end library (MIT‑licensed), installed into
  `/libraries/readremaining`. Without it the gauge does nothing.

## Install the module with Composer

The recommended route also fetches the JavaScript library for you, but on this
2.2.x branch you first add the library's package definition to your project. Open
your root `composer.json`, add the library package to the `repositories` section
(the exact snippet is in the module's `README.txt`), then run:

```bash
composer require drupal/readremaining -W
```

That fetches the library into `/libraries/readremaining` automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/readremaining -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

### Installing the library manually (alternative)

If you'd rather not touch `composer.json`, download version **1.0.x** of the
ReadRemaining.js library, rename the extracted folder to **`readremaining`**, and
place it at `/libraries/readremaining` in your project.

## Enable the module

```bash
drush en readremaining -y
```

## Verify it worked

Open **Configuration → System → ReadRemaining**
(`/admin/config/system/readremaining`), tick at least one content type, and save.
Then view a node of that type — the reading‑time gauge should appear. If nothing
shows, confirm the library is present at `/libraries/readremaining`. Next, tune
the gauge in [Configuration](../configuration/index.md).
