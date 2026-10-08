# Installation

## Requirements

Publishing options is lightweight and has no dependencies outside Drupal core:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party Composer packages or PHP libraries.

Note that the Composer package name (`drupal/pub_options`) differs from the
module's machine name (`publishing_options`) — you enable it under the machine
name.

## Install with Composer

From the project root:

```bash
composer require drupal/pub_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pub_options -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en publishing_options -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring →
Publishing options** (`/admin/config/content/publishing-options`). You should see
the management screen with an **Add publishing option** button. From here, head
to [Configuration](../configuration/index.md) to create your first custom flag.
