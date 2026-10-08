# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[IP2Country](https://www.drupal.org/project/ip2country)** module
  (`ip2country`) — required for country‑based banning. Per its own project page,
  IP2Country can take a few minutes to install because it builds its lookup data.
- Core's **Path Alias** module (`path_alias`), enabled with Drupal core.

## Install with Composer

Requiring the module with the `-W` flag pulls in IP2Country as a dependency:

```bash
composer require drupal/ip_ban -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ip_ban -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ip_ban -y
```

Drupal enables IP2Country and Path Alias automatically as dependencies. Allow a
few minutes for IP2Country to finish populating its country database.

## Verify it worked

Log in as an administrator and open the IP Ban settings form (see
[Configuration](../configuration/index.md)). Add a harmless test rule — for
example, set a country you can test from behind a VPN to read‑only — and confirm
the behavior, then remove the test rule. **Be careful not to ban your own IP or
country**, or you may lock yourself out.
