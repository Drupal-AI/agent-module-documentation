# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- No dependent modules and no third‑party Composer or PHP libraries for the base
  module.

The **Analytics: AMP** submodule additionally requires the separate `amp` module
if you want to use it — install that yourself.

## Install with Composer

From the project root:

```bash
composer require drupal/analytics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This one package includes the base module and all three
bundled submodules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/analytics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the base module

```bash
drush en analytics -y
```

The base module already provides the **Google Tag Manager** and **Google
Optimize** service plugins, so if that's all you need, you're done — go to
[Configuration](../configuration/index.md).

## Choose your vendor submodules

Enable only the ones you need for the vendors you use:

| Submodule | Machine name | Adds |
|-----------|--------------|------|
| **Analytics: Google Analytics** | `analytics_google` | A Google Analytics service (tracking ID). |
| **Analytics: AMP** | `analytics_amp` | AMP analytics and an AMP tracking pixel for AMP routes. **Requires the separate `amp` module.** |
| **Analytics: Piwik** | `analytics_piwik` | A Piwik/Matomo service (site URL + site ID). |

For example, to add Google Analytics:

```bash
drush en analytics_google -y
```

Each submodule just registers an extra service plugin — you still configure it on
the Analytics page as described in [Configuration](../configuration/index.md).
