# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Key** module (`key`) — this module is a key provider for it, so Key must
  be installed and enabled. Composer pulls it in automatically with the command
  below.
- A reachable **HashiCorp Vault** instance (self-hosted or HashiCorp Cloud) with
  a KV secrets engine, plus an auth token Drupal can use to read the secrets you
  need.

> **Not security-advisory covered.** This project is not covered by Drupal's
> security advisory policy. Review it yourself before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/hashicorp_vault_secrets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Key module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hashicorp_vault_secrets -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hashicorp_vault_secrets -y
```

Enabling this module also enables the Key module if it wasn't already on.

## Verify it worked

Go to **Configuration → System → Keys → Add key**
(`/admin/config/system/keys/add`). In the **Key provider** dropdown you should
now see a **HashiCorp Vault** option. If it's there, the integration is
installed. Next, follow [Configuration](../configuration/index.md) to point it at
your Vault instance — but first store your Vault address and token in the
environment, not in Drupal.
