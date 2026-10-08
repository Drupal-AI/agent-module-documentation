# Installation

## Requirements

- **Drupal 11.3 or newer, or Drupal 12**
  (`core_version_requirement: ^11.3 || ^12`). Earlier core versions are not
  supported by the 2.2.x branch — stay on 2.1.x if you still need Drupal 8/9/10.
- Core's **User** module (`user`), which is always present on a Drupal site.

There are no other Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/login_disable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_disable -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_disable -y
```

The module ships no submodules. **Enabling it does nothing on its own** — the
feature stays dormant until you activate it and configure the details on the
settings form. Head to [Configuration](../configuration/index.md) next, and note
in particular the warning there about the default access key.
