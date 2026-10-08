# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **`drupal-code-builder/drupal-code-builder`** PHP library (`^4.6`) — Composer
  installs this automatically as a dependency when you require the module. This
  library does the heavy lifting of code generation.
- No JavaScript library dependencies.

## Install with Composer

Module Builder is a **developer tool** and should be installed as a dev dependency
so it is not deployed to production servers. From the project root:

```bash
composer require --dev drupal/module_builder -W
```

The `--dev` flag keeps it out of your production install; `-W`
(`--with-all-dependencies`) lets Composer pull in the `drupal-code-builder` library
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/module_builder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

> **Never install this on a production site.** Module Builder can write PHP into your
> codebase, so keep it to local/development environments and never grant the *Create
> modules* permission on a live site.

## Enable the module

```bash
drush en module_builder -y
```

### Optional submodule

- **`module_builder_devel`** — an add‑on aimed at Module Builder's own development.
  Most users do not need it; enable it only if you are working on the module itself.

## Verify it worked

Log in as a user with the **Create modules** permission and go to **Configuration →
Development → Module Builder → Analyse**. Run the analysis; when it completes, the
generator is ready and you can add a module entity on the **Modules** screen. See
"How to use it" in the [overview](../index.md) for the full workflow.
