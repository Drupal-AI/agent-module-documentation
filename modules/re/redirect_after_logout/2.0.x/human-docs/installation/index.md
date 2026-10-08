# Installation

## Requirements

- **Drupal 10.4+ or 11.1+** (`core_version_requirement: ^10.4 || ^11.1`).
- Core's **Filter** module (`filter`) enabled — this is the only hard dependency,
  and it's on by default on most sites.

No third‑party Composer or PHP library requirements.

### Optional (suggested) integrations

- **Token** (`drupal/token`, `^1.10`) — when enabled, the settings form shows a
  token help/browser so you can build dynamic destinations and messages with
  tokens.
- **Masquerade** (`drupal/masquerade`, `^2.0@beta`) — if present, the module
  automatically skips its logout redirect during a masquerade session so
  unmasquerading works normally. Nothing to configure.

Neither is required for the core feature to work.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_after_logout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the optional integrations, require them too, for
example `composer require drupal/token`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redirect_after_logout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_after_logout -y
```

Enabling the module alone doesn't redirect anyone yet — you still need to set a
destination and grant the permission. Head to
[Configuration](../configuration/index.md) next.
