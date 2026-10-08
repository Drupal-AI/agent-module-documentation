# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core modules **File**, **User**, **Filter**, and **Options** — enabled
  automatically as dependencies.
- The contributed **Key** module (`key`) — a hard dependency, used to store the
  Apigee auth credentials securely. Composer pulls it in automatically with the
  command below.
- A working **Apigee organization** (Edge or X) to connect to, with credentials
  that can authenticate against it. Without an Apigee backend the module has
  nothing to integrate.

## Install with Composer

From the project root:

```bash
composer require drupal/apigee_edge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Key module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/apigee_edge -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apigee_edge -y
```

After enabling, you must connect it to your Apigee organization before the portal
does anything useful — see [Configuration](../configuration/index.md).

## Submodules — enable only what you need

Enable these individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Teams** | `apigee_edge_teams` | Team-owned apps, so a group of developers can share ownership of an app. |
| **API Product RBAC** | `apigee_edge_apiproduct_rbac` | Role-based access control over which API products developers can see and subscribe to. |
| **Actions** | `apigee_edge_actions` | Rules-style reactions to Apigee events. |
| **Debug** | `apigee_edge_debug` | Logs Apigee API requests to help diagnose connection problems. |

For example, to add team-owned apps:

```bash
drush en apigee_edge_teams -y
```

Each submodule requires the base Apigee Edge module, which is already present once
you have installed it above.
