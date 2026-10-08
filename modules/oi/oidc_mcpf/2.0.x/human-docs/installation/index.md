# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **OpenID Connect Client** module (`oidc`) — required; this module adds an ACM
  realm on top of it. Note that OIDC itself needs the PHP **`gmp`** extension, so see
  the OIDC module's installation notes as well.
- Core's **Telephone** module (`telephone`).

## Install with Composer

From the project root:

```bash
composer require drupal/oidc_mcpf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the OIDC module and Telephone.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oidc_mcpf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

> **`gmp` extension:** because this depends on OIDC, the same `ext-gmp` requirement
> applies. If `composer require` fails with *"ext-gmp is missing"*, add it — in DDEV:
> `ddev config --webimage-extra-packages='php${DDEV_PHP_VERSION}-gmp'` then
> `ddev restart`.

## Enable the module

```bash
drush en oidc_mcpf -y
```

This also enables OIDC and Telephone if they aren't already on. Enable the
`oidc_mcpf_user_purge` submodule separately if you want its account clean‑up:

```bash
drush en oidc_mcpf_user_purge -y
```

## Verify it worked

Confirm the **ACM realm** is available in the OIDC realm administration and that you
can configure it (see [Configuration](../configuration/index.md)). A login route for
the ACM realm will follow the OIDC pattern `/oidc/login/{realm}`.
