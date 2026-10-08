# Installation

> **Before you install, read the security warning on the
> [overview page](../index.md).** This module is *Unsupported* with *revoked*
> security coverage; prefer an actively maintained SMS module unless you have had
> the known issue fixed.

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Gammu SMS Daemon (smsd)** installed and configured on your server, connected
  to a working GSM modem or SMS gateway. The module drives Gammu; it does not send
  SMS on its own.
- Access to the **Gammu SMSD database** so the module can read/write messages.
- No third‑party Composer or PHP library requirements for the module itself.

## Install Gammu SMSD on the server

Install and configure Gammu SMSD **before** enabling the Drupal module — set up
the modem/gateway, its communication method and port, and the SMSD database.
Follow Gammu's own documentation for your operating system.

## Install with Composer

From the project root:

```bash
composer require drupal/gammu_smsd -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gammu_smsd -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gammu_smsd -y
```

## Verify it worked — and secure it immediately

Grant the **administer gammu** permission to your administrator role at **People →
Permissions**, then open the Gammu admin interface and confirm it loads.

**Do not stop there.** Straight after install, go to
[Configuration](../configuration/index.md) and **set a strong `gammu_token`** and
**restrict the `api/gammu/send` route** — until you do, the inbound send endpoint
accepts unauthenticated requests (see the security warning on the
[overview page](../index.md)).
