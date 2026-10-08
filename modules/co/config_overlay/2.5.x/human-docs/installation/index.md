# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no module dependencies beyond
  core's configuration system, which is always present.

Config Overlay is known to work alongside — and is tested against —
[Config Ignore](https://www.drupal.org/project/config_ignore) (8.x‑3.x) and
[Config Split](https://www.drupal.org/project/config_split) (2.0.x), if you use those.

## Install with Composer

From the project root:

```bash
composer require drupal/config_overlay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_overlay -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_overlay -y
```

## Re‑export to see the effect

The whole point of the module is visible the moment you export configuration:

```bash
drush config:export -y
```

Look in your configuration export directory — instead of the full ~200 files of a standard
install, you should now see only a dozen or so, representing just the configuration that
differs from your modules' shipped defaults.

## Verify it worked

After re‑exporting, confirm the export directory is much smaller than before, then run
`drush config:import` on a clean checkout (or another environment) and confirm the site's
configuration still imports cleanly. If both hold, the overlay is working. Because there is
no settings form, there is nothing further to configure — see
[the main guide](../index.md) for the day‑to‑day workflow and the fresh‑install note.
