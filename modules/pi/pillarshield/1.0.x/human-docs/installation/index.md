# Installation

## Requirements

PillarShield needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`).
- The **[Key](https://www.drupal.org/project/key)** module (`key`), used to store
  the PillarShield API key securely. Composer pulls it in as a dependency, and it
  is strongly recommended (not just optional) for credential storage.
- An **active PillarShield tenant / API key** from
  [pillarshield.co](https://pillarshield.co).

**Recommended:** core's **Content Moderation** module if you want Gate enforcement
tied to moderation‑state transitions.

## Install with Composer

From the project root:

```bash
composer require drupal/pillarshield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and brings in the required Key module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pillarshield -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pillarshield -y
```

This also enables the required `key` module if it isn't already on.

## Verify it worked

After enabling, go to **Configuration → Content authoring → PillarShield**
(`/admin/config/content/pillarshield`) and confirm the settings form loads. Then
follow [Configuration](../configuration/index.md) to store your API key, test the
connection, and choose which content to evaluate.
