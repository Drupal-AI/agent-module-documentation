# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Webform** module (`webform`) — this is the one required dependency, and
  Composer will pull it in with the command below.
- No third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Webform module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_token -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_token -y
```

## Verify it worked

Log in as an administrator and open **Configuration → System → Custom Token**
(`/admin/config/system/custom_token`). Add a token key and value, save, then use
`[custom_token:yourkey]` in a Webform email handler field (or any token-enabled
field) and confirm it resolves to your value. See
[Configuration](../configuration/index.md) for the full workflow, including how to
deploy tokens across environments.
