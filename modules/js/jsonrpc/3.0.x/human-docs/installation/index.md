# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.3** (`php: ^8.3`) — this is a hard requirement; the module will not install on an
  older PHP.
- The **`e0ipso/shaper`** library (`^1.2.1`), used for JSON-Schema validation. Composer pulls
  it in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonrpc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `e0ipso/shaper` library
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonrpc -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonrpc -y
```

The `/jsonrpc` endpoint is registered immediately. On its own, the base module provides the
infrastructure but no methods — you either write your own or enable the Core Methods
submodule below.

## Submodules — enable what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **JSON-RPC Core Methods** | `jsonrpc_core` | Ready-made methods for common core operations (for example rebuilding caches, toggling maintenance mode, listing permissions and plugins), so you have something to call without writing code. |
| **JSON-RPC Discovery** | `jsonrpc_discovery` | A discovery/self-documentation API that lets a client enumerate the available methods and their schemas. |

```bash
drush en jsonrpc_core jsonrpc_discovery -y
```

## After enabling

Head to [Configuration](../configuration/index.md) to choose which authentication providers
are accepted on the endpoint, and grant the `use jsonrpc services` permission to whichever
account (often a dedicated API/service user) should be allowed to call the API.
