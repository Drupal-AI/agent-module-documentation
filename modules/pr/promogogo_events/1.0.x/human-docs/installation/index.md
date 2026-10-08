# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Block** module (to place the events block).
- A **Promogogo partner account** — specifically its **Partner ID** — for the
  feed.
- **Outbound HTTP access** from your server to the Promogogo API.

No other contributed modules or third‑party PHP libraries are needed; the module
relies on Drupal core's HTTP client and Single Directory Components.

## Install with Composer

From the project root:

```bash
composer require drupal/promogogo_events -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/promogogo_events -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en promogogo_events -y
```

## Verify it worked

Go to **Configuration → Web services → Promogogo Events**
(`/admin/config/services/promogogo-events`) and confirm you can enter a **Partner
ID**. Once you have entered a valid one, place the **Promogogo events** block from
**Structure → Block layout** and check that live events appear. See the
[main guide](../index.md#how-to-use-it) for the full setup.
