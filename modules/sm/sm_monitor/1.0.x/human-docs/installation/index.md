# Installation

## Requirements

- **Drupal 11.3+** (`core_version_requirement: ^11.3`).
- **`sm_metrics`** (Symfony Messenger Metrics) — the source of the statistics.
- **`pinto`** — used to build the module's UI components.
- **Optional:** the **ChartJS** module — if present, a graph is automatically
  activated on each worker card.

Composer pulls in the required module dependencies for you.

## Install with Composer

From the project root:

```bash
composer require drupal/sm_monitor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `sm_metrics`,
`pinto`, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sm_monitor -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sm_monitor -y
```

Note this module is **not covered by the security advisory policy**, so apply
your own judgement before relying on it in production.

## Verify it worked

Open the monitor dashboard from the admin UI. You should see worker cards,
messages, and aggregate statistics drawn from the Metrics module. Install ChartJS
if you want a graph on each worker card.
