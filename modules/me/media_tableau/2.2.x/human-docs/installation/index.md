# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Media Remote** module (`media_remote`) — this is the required dependency
  that Media Tableau builds on. Composer installs it for you when you require
  Media Tableau.
- No third‑party Composer libraries. (The Tableau Embedding API JavaScript is
  loaded from Tableau's own servers at render time.)

## Install with Composer

From the project root:

```bash
composer require drupal/media_tableau -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and pulls in Media Remote at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_tableau -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_tableau -y
```

Drupal enables **Media Remote** automatically as a dependency.

There are **no submodules**. The module provides one permission — **Administer
media_tableau allowed hosts** — which controls access to the Tableau settings
page; grant it to the roles that should manage which Tableau domains may be
embedded.

## Verify it worked

Visit **Configuration → Media → Tableau settings**
(`/admin/config/media/tableau`). You should see the **Allowed Hosts** form,
pre‑populated with `https://public.tableau.com`. Next, set up your Remote Media
type and its display formatter — see [Configuration](../configuration/index.md).
