# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- A supported **executable on the server** — currently **Yarn** must be installed
  and on the PATH for the module to have anything to run. Without it, the plugin
  manager's `getExecutable()` returns nothing available.
- No other module dependencies, and no third‑party Composer or PHP library
  requirements declared by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/npm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/npm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix. DDEV's web container
> includes Node/Yarn tooling, which makes it a convenient place to use this
> module during development.

## Enable the module

```bash
drush en npm -y
```

## A word on where to enable it

Because this module can execute commands on the server (see the security note on
the [overview page](../index.md)), enable it in **development and build
environments**, not casually on production. There is no UI that triggers npm on
its own — actions only run when custom code calls the executable — but the
capability it grants is powerful, so keep it out of environments where untrusted
users could reach code that uses it.

## Verify it worked

Confirm Yarn is available in the environment (`yarn --version`), then, from
custom code, fetch the executable via
`\Drupal::service('plugin.manager.npm_executable')->getExecutable()` and run a
harmless action. If Yarn is installed and on the PATH, an executable is returned;
if not, none is available and npm actions cannot run until you install it.
