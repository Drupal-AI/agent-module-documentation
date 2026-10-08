# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- The **aerolab/readremaining.js** front‑end library, installed into
  `/libraries/readremaining`. Without it the gauge silently does nothing.
- **composer/installers** is used to place the library into the `libraries`
  directory (it is pulled in as part of the install below).

## Install with Composer

From the project root:

```bash
composer require drupal/readremaining -W
```

On this branch the module declares the library as a Composer dependency
(`aerolab/readremaining`), so Composer fetches both the module and the library and
places the library at `/libraries/readremaining` for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/readremaining -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

### Installing the library manually (alternative)

If needed, download version **1.0.x** of the ReadRemaining.js library, rename the
extracted folder to **`readremaining`**, and place it at `/libraries/readremaining`.

## Enable the module

```bash
drush en readremaining -y
```

## Grant the permission

The settings form is gated by a dedicated permission. Grant it to the roles that
should manage the gauge (Administer site configuration is not enough on its own):

```bash
drush role:perm:add editor 'administer readremaining'
```

## Verify it worked

Open **Configuration → System → ReadRemaining**
(`/admin/config/system/readremaining`), tick at least one content type, and save.
Then view a node of that type — the reading‑time gauge should appear. If nothing
shows, confirm the library is present at `/libraries/readremaining`. Next, tune the
gauge in [Configuration](../configuration/index.md).
