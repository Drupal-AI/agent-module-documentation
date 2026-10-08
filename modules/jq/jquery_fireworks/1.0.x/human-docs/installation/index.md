# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Block** module (enabled by default on standard installs) so you can
  place the fireworks block.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_fireworks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jquery_fireworks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_fireworks -y
```

## Verify it worked

Go to **Structure → Block Layout** and place the **Canvas based fireworks** block
in a region (see "How to use it" in the [overview](../index.md)). Reload a page
where the block is visible — you should see the fireworks animation play on the
canvas.
