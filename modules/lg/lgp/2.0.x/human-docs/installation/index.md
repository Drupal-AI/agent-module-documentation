# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^10 | ^9`).
- **Drush** for the live‑tail console command (`drush lg-console` / `drush lgc`).
- A writable system temp directory (LGP writes `lgp.log` there).
- No other modules and no third‑party PHP libraries are required.

> **Development only.** The project explicitly warns against running LGP in
> production. Install it in a dev or staging environment and remove it before you
> deploy.

## Install with Composer

From the project root:

```bash
composer require drupal/lgp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If your project separates development dependencies, this
is a good candidate for `composer require --dev`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lgp -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lgp -y
```

There are no submodules, permissions, or configuration to set up.

## Verify it worked

1. Confirm **Lazy Guinea Pig** is enabled on **Extend** (`/admin/modules`).
2. Visit the **Status report** (`/admin/reports/status`) and look for the entry
   showing the path to the `lgp.log` file.
3. Add a quick `lp('hello from lgp');` somewhere that runs, load the page (or run
   `drush ev "_lp('hello')"`), then run `drush lgc` — you should see the entry
   appear in the tailed output.

That's everything; there is no configuration step. See the module's
[main page](../index.md) for the full list of logging helpers.
