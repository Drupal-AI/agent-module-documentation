# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`akamai-open/edgegrid-client`** PHP library (`^2.1`), which Composer installs
  automatically when you require the module.
- **Akamai Fast Purge (CCU) API credentials**, created in your Akamai Control Center
  (a client token, client secret, access token, and REST API host).

Recommended companions:

- The **Purge** module (`drupal/purge`) and its UI (`purge_ui`) — the usual way to
  drive automatic, queued cache invalidation.
- The **Key** module (`drupal/key`) — the preferred, more secure way to store your
  Akamai API credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/akamai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the bundled
`akamai-open/edgegrid-client` library and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/akamai -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en akamai -y
```

## Grant the permissions

Akamai defines two permissions, both marked *restrict access* because they are
security-sensitive:

| Permission | What it allows |
|---|---|
| **Administer Akamai** (`administer akamai`) | Access the Akamai configuration form (including API-credential settings). |
| **Purge Akamai cache** (`purge akamai cache`) | Access the manual cache-clear form and the "Akamai Cache Clear" block. |

Grant `purge akamai cache` to editors who need to flush pages but should **not** see
or change your API credentials:

```bash
drush role:perm:add editor 'purge akamai cache'
```

## Verify it worked

Go to **Configuration → Akamai → Configure** (`/admin/config/akamai/config`). If the
settings form loads, the module is installed. Next, set up your credentials and
options on the [Configuration](../configuration/index.md) page.
