# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- A **JavaScript build toolchain** — SDX uses Vite (with hot module replacement) to
  build framework components, so Node.js and the framework packages you choose are
  part of the picture beyond the Drupal module itself.
- No dependent contrib Drupal modules and no third-party PHP Composer libraries are
  declared, but you will pull in JavaScript dependencies for your chosen framework
  (React, Vue, or Svelte) during setup.

This is an early release (`1.0.0-alpha15`) — treat it as pre-production and test on a
non-production copy first.

## Install with Composer

From the project root:

```bash
composer require drupal/sdx -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sdx -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sdx -y
```

## Run the setup wizard

Unlike most modules, SDX needs a build pipeline to be useful. After enabling it, run
the module's setup wizard, which walks you through choosing a framework (React, Vue,
or Svelte), a bundler, and the JavaScript package setup. Follow the project's README
for the exact commands, since the front-end steps depend on the framework you pick.

Once set up, you author components in Drupal's SDC directory structure and render
them from Twig with the `sdx()` function — see
[How to use it](../index.md#how-to-use-it) in the main guide.
