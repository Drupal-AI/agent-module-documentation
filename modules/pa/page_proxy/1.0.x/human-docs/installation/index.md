# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contributed module dependencies beyond Drupal core.
- The server that runs Drupal must be able to reach the remote host you intend to
  proxy.

## Install with Composer

From the project root:

```bash
composer require drupal/page_proxy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_proxy -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_proxy -y
```

## Verify it worked

Go to **Configuration → Web services → Page Proxy**
(`/admin/config/services/page-proxy`) and create a proxy configuration pointing at
a trusted external host. Visit the local path you mapped — the remote page should
render under your domain. See [Configuration](../configuration/index.md) for the
setup steps and the security points to consider first.
