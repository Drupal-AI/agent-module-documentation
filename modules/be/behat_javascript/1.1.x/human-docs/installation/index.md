# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **`drupal/drupal-extension`** — the Behat DrupalExtension, which discovers and
  wires up the module's subcontext. It's pulled in as a Composer requirement.
- A working Behat + Mink setup using the **`selenium2`** driver (a real browser),
  since JavaScript‑error capture only runs in real‑browser `@javascript`
  scenarios.

> **Test/CI only.** This module attaches an error‑capturing script to every page
> and is explicitly not for production. Enable it only in your test or CI
> environment.

## Install with Composer

From the project root:

```bash
composer require drupal/behat_javascript -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Since this is a testing dependency, you may prefer to add
it with `composer require --dev`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/behat_javascript -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en behat_javascript -y
```

Enable it only in the environment where you run tests. Once enabled and with
DrupalExtension configured in your `behat.yml`, the subcontext is picked up
automatically — see [How to use it](../index.md#how-to-use-it).

## Configuration

The module adds a single optional setting (a list of error patterns to ignore) at
**Configuration → Development → Behat Javascript**. It's described in
[How to use it](../index.md#how-to-use-it) — there's no separate configuration
page for it. There are no submodules.
