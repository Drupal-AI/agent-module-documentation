# Installation

## Requirements

- **Drupal 10.5 or 11.2** (`core_version_requirement: ^10.5 || ^11.2`).
- The **AI** module (`drupal/ai` `^1.0`) — AI Metering meters the calls that go
  through it, so it is essential.
- The **Views Data Export** module (`drupal/views_data_export` `^1.10`) — used to
  export the usage log to CSV / JSON.

Both are declared as Composer requirements and are pulled in automatically. This
is a **beta** release, so treat it accordingly on production.

### External services

AI Metering reaches out to two external services (both optional to the core
metering, but needed for full functionality):

- **Frankfurter** — live currency exchange rates, for showing costs in a
  currency other than USD.
- **LiteLLM / models.dev** — per-model pricing data, synced on demand.

A working outbound HTTP connection is needed for currency conversion and pricing
sync.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_metering -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
AI module, Views Data Export, and shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_metering -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_metering -y
```

Enabling it also enables the AI and Views Data Export modules if they are not
already on, and creates the `ai_metering_usage` and `ai_metering_quota` database
tables. From this point on, every AI call through the AI module is metered
automatically. Head to [Configuration](../configuration/index.md) to set quotas,
model routing, pricing, currency, and permissions.
