# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** module (`file`), which Drupal enables automatically as a
  dependency (it is on for virtually every site already).

There are no third-party Composer libraries.

You will also need a favicon package and HTML snippet from
[realfavicongenerator.net](https://realfavicongenerator.net/) — generate this before
configuring the module.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_favicons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/responsive_favicons -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_favicons -y
```

The module has no submodules. After enabling, grant the **Administer responsive
favicons** permission to the roles that should manage favicons, then head to
[Configuration](../configuration/index.md) to upload your favicon package.

> **Heads-up:** if the `favicon` or `pwa` modules are also enabled, the Status
> report will warn about potential conflicts — see the configuration page.
