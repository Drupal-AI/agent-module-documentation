# Installation

## Requirements

- **PHP 8.2 or newer** (`php: >=8.2`).
- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Key** module (`drupal/key:^1.16`) — a hard dependency, pulled in by Composer.
- Pantheon's **Customer Secrets PHP SDK** (`pantheon-systems/customer-secrets-php-sdk`)
  — also pulled in by Composer.
- A site hosted on **Pantheon**, where secrets are set with the `terminus` CLI. The
  module reads secrets at runtime through the SDK; it does not create them.

## Install with Composer

From the project root:

```bash
composer require drupal/pantheon_secrets -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the Key module and the Pantheon
SDK and updates shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pantheon_secrets -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pantheon_secrets -y
```

This also enables the **Key** module if it is not already on. There are **no
submodules**.

## Grant the permission

The module provides one permission, **Sync pantheon_secrets keys**, which gates the
bulk‑import page and command. Grant it only to trusted roles:

```bash
drush role:perm:add administrator 'sync pantheon_secrets keys'
```

## Create a secret in Pantheon

Secrets live in Pantheon, not Drupal. Create one with terminus — the scope **must** be
`web` for the Drupal application to see it:

```bash
terminus secret:set <site> --scope=web --type=runtime <secret_name> <secret_value>
```

## Verify it worked

Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click **Add
key**. In the **Key provider** list you should now see **Pantheon**; choosing it lets
you pick from the real secret names your site can see. You should also see a **"Sync
Pantheon Secrets"** tab on the Keys page.

Next, see [Configuration](../configuration/index.md) to create a Pantheon‑backed key
and use the bulk sync.
