# Installation

## Requirements

- **Drupal 10.2, or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **VotingAPI** module (`drupal/votingapi`, `^3.0 || ^4.0`) — Rate stores
  every vote through it, so it must be present.
- Core's **Node**, **Views**, and **Datetime** modules, which Drupal enables
  automatically as dependencies.
- *Optional:* the **Charts** module (`drupal/charts`) if you want charts drawn on
  the per‑node voting results tab.

## Install with Composer

From the project root:

```bash
composer require drupal/rate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in VotingAPI and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rate -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rate -y
```

This also enables VotingAPI and the core dependencies if they are not already on.
Enabling Rate installs its permissions and config schema but does **not** create
any widget — the module does nothing visible until you build one.

## Submodules

Rate ships no submodules.

## Next steps

Head to [Configuration](../configuration/index.md) to build your first widget,
attach it to a content type, and grant the voting permission it generates.
