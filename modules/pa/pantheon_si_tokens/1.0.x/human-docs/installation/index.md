# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Token** module (`token`) — Composer installs it for you with the `-W` flag
  below.
- A **Pantheon-hosted** environment using **Secure Integration**, so that the
  `PANTHEON_SOIP_*` constants are actually defined in the PHP runtime. Off
  Pantheon those constants won't exist and the tokens resolve to empty strings.

This is a **beta** release (`1.0.0-beta3`) and the project is **not covered** by
the security advisory policy — review it against your own risk tolerance.

## Install with Composer

From the project root:

```bash
composer require drupal/pantheon_si_tokens -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Token.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pantheon_si_tokens -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pantheon_si_tokens -y
```

Drupal enables Token automatically as a dependency. If you want to use these
tokens inside Feeds imports, also enable the optional `feeds_enhanced_tokens`
submodule (which itself requires the Feeds Enhanced setup).

## Verify it worked

Log in as an administrator and go to **Configuration → System → Pantheon SI
Tokens** (`/admin/config/system/pantheon-si-tokens`). The settings form, where
you allowlist SI constants, should load. Continue with
[Configuration](../configuration/index.md).
