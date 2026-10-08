# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Access to an **IRC server / qwebirc endpoint** for the client to connect to.
- The **Mibbit** module must **not** be enabled at the same time — Qwebirc is based
  on Mibbit and the two conflict.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/qwebirc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/qwebirc -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en qwebirc -y
```

If Mibbit is currently enabled, disable it first to avoid a conflict.

## Grant permissions

Qwebirc provides its own permission under **People → Permissions**. Grant it to the
roles that should be able to open the embedded IRC client.

## Verify it worked

Visit **`/irc`** on your site. The embedded qwebirc IRC widget should load inside the
page. If it does not connect, check the configured IRC server / qwebirc endpoint.
