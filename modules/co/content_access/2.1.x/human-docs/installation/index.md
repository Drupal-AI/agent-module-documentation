# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Node** module (`node`), enabled automatically as a dependency.
- **Optional:** the contributed **ACL** module (`drupal/acl`) if you want to grant
  access to individual named users on the per‑node tab.

There are no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/content_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the optional per‑user grants, also require the ACL
module:

```bash
composer require drupal/acl -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_access -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_access -y
```

(Enable `acl` as well if you installed it and want per‑user grants.)

After enabling, open a content type's **Access control** tab to set its access
rules — see [Configuration](../configuration/index.md). Remember to rebuild node
access permissions when Drupal prompts you, so the grants take effect.
