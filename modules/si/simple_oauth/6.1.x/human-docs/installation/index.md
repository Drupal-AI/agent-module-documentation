# Installation

## Requirements

Simple OAuth pulls in a few third‑party libraries and some other Drupal modules:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**.
- Composer libraries (installed automatically with the command below):
  - `league/oauth2-server` `^9.0` — the OAuth 2.0 server engine.
  - `steverhoades/oauth2-openid-connect-server` `^3.0` — the OpenID Connect layer.
- Drupal module dependencies (enabled automatically): core **Serialization**,
  **Options**, and **Path alias**, plus the contributed **Consumers** module
  (`consumers` `^1.17`), which represents each client application.

You will also need to be able to write an **RSA key pair** to the filesystem
(ideally outside the web root) for signing tokens — the module can generate this
for you.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_oauth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the OAuth server
libraries and the Consumers module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/simple_oauth -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_oauth -y
```

Consumers and the other module dependencies are enabled automatically.

## Optional submodule — static scopes

Simple OAuth ships one submodule, **Simple OAuth Static Scope**
(`simple_oauth_static_scope`). Enable it only if you prefer to define scopes as
static, deployable YAML plugins instead of the default dynamic scope *entities*
managed in the UI:

```bash
drush en simple_oauth_static_scope -y
```

Which you choose is set by the **scope provider** on the settings form — see
[Configuration](../configuration/index.md).

After enabling, continue to [Configuration](../configuration/index.md) to set up
signing keys, scopes, and your first consumer — the module needs those before it
can issue tokens.
