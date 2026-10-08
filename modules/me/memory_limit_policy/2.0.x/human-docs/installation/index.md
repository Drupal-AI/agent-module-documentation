# Installation

## Requirements

- **Drupal 9.3, 10 or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).

There are no third-party Composer libraries. The module depends on Drupal core
only — but see the important note below about the constraint **submodules**, which
you'll almost certainly need.

## Install with Composer

From the project root:

```bash
composer require drupal/memory_limit_policy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This one download includes the base module and all of its
submodules — you enable the submodules you want separately with Drush.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/memory_limit_policy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en memory_limit_policy -y
```

## Enable at least one constraint submodule — required to do anything useful

The base module provides the policy engine and UI, but **no constraint types**. A
policy with no constraints it can build has nothing to match on, so you need to
enable at least one of these submodules to get the conditions you want:

| Submodule | Machine name | Lets a policy match on… |
|-----------|--------------|--------------------------|
| Role | `memory_limit_policy_role` | the current user's role(s) |
| Path | `memory_limit_policy_path` | the request path (with wildcards, e.g. `/admin/reports/*`) |
| Route | `memory_limit_policy_route` | a specific route name, plus an "admin route" match |
| HTTP method | `memory_limit_policy_http_method` | `GET` / `POST` / `PUT` etc. |
| HTTP header | `memory_limit_policy_http_header` | a request header name/value |
| Query parameter | `memory_limit_policy_query_param` | a query string parameter (e.g. `?export=1`) |
| Domain | `memory_limit_policy_domain` | the domain (multisite / Domain Access) |
| Environment variable | `memory_limit_policy_env_variable` | an environment variable value |
| Drush | `memory_limit_policy_drush` | the Drush command being run |
| AI Agents | `memory_limit_policy_ai_agents` | (integration to manage policies via the AI Agents module) |

Enable the ones you need, for example:

```bash
drush en memory_limit_policy_path memory_limit_policy_role -y
```

## Verify it worked

Log in as an administrator and go to
`/admin/config/performance/memory-limit-policy/list` (under **Configuration**). You
should see the (empty) policy list with an **Add policy** action. When you add a
policy, the constraint types you'll be offered correspond to the submodules you
enabled above.

Next, follow [Configuration](../configuration/index.md) to create your first
policy.
