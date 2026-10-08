# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- Core's **Package Manager** module (`package_manager`) and core's **Update** module
  — both enabled automatically as dependencies. Package Manager does the sandbox
  staging that makes safe updates possible.
- A Composer-managed Drupal site. Automatic Updates works by adjusting your project's
  `composer.json`, so the codebase must be one Composer controls (not, for example, a
  tarball install).
- PHP with the **json** extension, `composer-runtime-api` ^2.1, and Symfony Console
  ^6.2 or ^7 — these come with a normal Drupal 11 Composer project.

Your web server user needs to be able to write to the codebase for updates to be
committed, and your hosting must allow the brief maintenance-mode sync.

## Install with Composer

From the project root:

```bash
composer require drupal/automatic_updates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/automatic_updates -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en automatic_updates -y
```

Enabling it also enables Package Manager and Update. Once on, an **Update now** link
appears on the core update report when a supported core release is available, and the
unattended-update options appear on the core update settings form.

## A note on the Extensions submodule

Automatic Updates lists one submodule, **Automatic Updates Extensions**
(`automatic_updates_extensions`), which used to handle contrib module and theme
updates. It is now **obsolete** — its functionality has moved into the main module —
so you do not need to enable it.

## Next steps

By default unattended updates are **disabled**, so nothing updates automatically
until you say so. See [Configuration](../configuration/index.md) to run a push-button
update or turn on unattended updates.
