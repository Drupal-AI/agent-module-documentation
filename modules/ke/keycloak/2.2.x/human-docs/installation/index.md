# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **OpenID Connect** module (`drupal/openid_connect`, `^3.0@alpha`), which
  Keycloak extends. Composer installs it as a dependency, and Drupal enables it
  automatically.
- A reachable **Keycloak server** with a realm and a client you can configure.
  This is external infrastructure — the Drupal module is only the client side.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/keycloak -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in OpenID Connect
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/keycloak -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en keycloak -y
```

This also enables OpenID Connect if it is not already on. There are no
submodules. Once enabled, head to [Configuration](../configuration/index.md) to
create your Keycloak client.

> **Tip:** Store the Keycloak client secret with the **Key** module rather than
> in plain configuration for production sites.
