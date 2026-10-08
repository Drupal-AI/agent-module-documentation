# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules **REST** (`rest`), **Serialization** (`serialization`), and
  **HTTP Basic Authentication** (`basic_auth`) — all part of Drupal core and
  enabled automatically as dependencies of this module.
- Recommended: the contributed **REST UI** (`restui`) module, which gives you a
  point-and-click way to enable and configure REST resources (otherwise you edit
  configuration by hand).
- A RankCrew account — the platform that will send content to your site.

## Install with Composer

From the project root:

```bash
composer require drupal/rankcrew -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the optional REST UI helper:

```bash
composer require drupal/restui -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rankcrew -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rankcrew -y
```

And, if you want the UI helper:

```bash
drush en restui -y
```

Enabling the module alone does **not** open any endpoint — the REST resources
stay inert until you explicitly enable them, as described in
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → Web services → REST** (`/admin/config/services/rest`).
You should see the RankCrew resources listed (for example `rankcrew_rankcrew`),
ready to be enabled. If they appear, the module is installed correctly — continue
to [Configuration](../configuration/index.md) to turn them on securely.
