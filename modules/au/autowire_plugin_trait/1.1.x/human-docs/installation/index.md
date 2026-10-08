# Installation

## Requirements

- **Drupal 10, or 11 below 11.3** (`core_version_requirement: ^10 || >=11 <11.3`).
- No third‑party Composer or PHP library requirements, and no module dependencies.

> **Obsolete from Drupal 11.3.** Core's `PluginBase` now ships an autowiring `create()`
> factory, so on Drupal 11.3 and later you do not need this module — drop the trait and
> extend `PluginBase` instead. That is why this branch refuses to install on 11.3+.

## Install with Composer

From the project root:

```bash
composer require drupal/autowire_plugin_trait -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autowire_plugin_trait -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autowire_plugin_trait -y
```

That is the entire setup. There is no configuration. Once enabled, your custom modules
can `use Drupal\autowire_plugin_trait\AutowirePluginTrait;` in their plugin classes.

## Verify it worked

Add the trait to a plugin, remove that plugin's hand‑written `create()`, and clear
caches (`drush cr`). If the plugin still loads and behaves normally — with its
dependencies injected — the trait is doing its job. If a dependency cannot be resolved
you will see an `AutowiringFailedException` naming the missing service.
