# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Options** module (`options`) — enabled automatically as a dependency.
- At the server level, the hostnames you plan to register must actually resolve to
  your Drupal server (via DNS and your web server's virtual hosts). Domain
  negotiates the hostname inside Drupal, but it cannot make DNS point at your
  server for you.

There are no PHP library or third-party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This one package contains the base module and all of its
submodules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the base module

```bash
drush en domain -y
```

## Enable the submodules you need

The base module only creates and negotiates domain records. Enable submodules for
the features you actually want — for example per-domain access control and
per-domain configuration:

```bash
drush en domain_access domain_source domain_config domain_config_ui -y
```

| Submodule | Machine name | Enable it for… |
|---|---|---|
| Domain Access | `domain_access` | Per-domain content/user access control. |
| Domain Source | `domain_source` | Canonical outbound URLs per content item. |
| Domain Config | `domain_config` | Per-domain configuration overrides (storage). |
| Domain Config UI | `domain_config_ui` | The admin UI for saving those overrides. |
| Domain Alias | `domain_alias` | Extra hostname patterns pointing at one domain. |
| Domain Content | `domain_content` | Per-domain content administration views. |

Enable **Domain Config UI** alongside **Domain Config** — the former is what gives
you an interface for the overrides the latter stores.

## Next steps

Once enabled, create your domain records and configure the global settings — see
[Configuration](../configuration/index.md).
