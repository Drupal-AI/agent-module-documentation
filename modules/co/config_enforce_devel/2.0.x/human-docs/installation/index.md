# Installation

> **Development environments only.** Never install or enable this module in
> production.

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Config Enforce** (`config_enforce`) — the runtime module this one configures.
- **Config Devel** (`config_devel`) — used to write active config out to files.
- **Multiselect** (`multiselect`) — provides the selection widget for its UI.
- Composer patching should be enabled in your root `composer.json`, because Config
  Enforce requires it (`composer config extra.enable-patching "true"`).

There are no PHP library requirements.

## Install with Composer

From the project root, install as a **dev** dependency so it stays out of
production builds. Composer will pull in Config Enforce, Config Devel, and
Multiselect as dependencies:

```bash
composer require --dev drupal/config_enforce_devel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/config_enforce_devel -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_enforce_devel -y
```

This also enables its dependencies (Config Enforce, Config Devel, Multiselect) if
they are not already on.

## Verify it worked

Confirm the module and its dependencies are enabled (`drush pm:list --status=enabled`
should list `config_enforce_devel`, `config_enforce`, `config_devel`, and
`multiselect`). You can then start marking config objects for enforcement, as
described in the [overview](../index.md).

> **Heads-up:** the first time it runs, the module auto-creates and enables a
> default *target module* named `config_enforce_default` under `modules/custom/`
> (this is where enforced config YAML is written by default). You can create your
> own target modules later and delete this one once it is no longer the default.
