# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Language** module (`language`) — provides the language negotiation this
  module checks against.
- Core's **Node** module (`node`) — the check is a node‑view access rule.

Both dependencies are core modules; Drupal enables them automatically if needed.
There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_language_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_language_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Before you enable — set up language detection

This module keys entirely off the language Drupal negotiates for the request. Set
that up first, at **Configuration → Regional and language → Languages → Detection
and selection** — typically **URL** (prefix) or **domain** negotiation for a
per‑language‑site setup.

## Enable the module

```bash
drush en content_language_access -y
```

> **Note:** the mismatch‑denial rule is **active immediately** on enable, with no
> matrix entries — the settings form only *loosens* it. Enable deliberately once
> language detection is configured. There are no submodules.

## Grant permissions

The module adds two permissions — assign them under **People → Permissions**:

- **Administer content_language_access settings** — open the settings form.
- **Bypass content_language_access** — exempt a role from the check entirely.
  This removes the whole feature for that role, so grant it narrowly (for example
  to administrators).

## Next step

Whitelist the cross‑language pairings you want and configure bypasses — see
[Configuration](../configuration/index.md).
