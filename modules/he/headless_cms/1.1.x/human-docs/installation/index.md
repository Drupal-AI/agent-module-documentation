# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Consumers** module (`consumers`) — a hard dependency. Composer pulls it
  in automatically with the command below.
- For a full decoupled setup you'll typically also run a web-services stack
  (JSON:API or REST, authentication such as Simple OAuth, and CORS configured in
  your site services), though those are part of your headless architecture rather
  than requirements of this module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/headless_cms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Consumers module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/headless_cms -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en headless_cms -y
```

This also enables the Consumers module if it wasn't already on.

## Submodules — enable only what you need

Each feature is its own submodule, so turn on only the ones your project uses:

| Submodule | What it adds |
|-----------|--------------|
| **Preview** | Preview of unpublished content and revisions in an external front-end app. |
| **Notify** | Sends entity and cache events to front-end apps via pluggable transports (Webhook and NATS built in). |

Enable them with `drush en` using their machine names as listed on the module's
Extend page, for example:

```bash
drush en headless_cms_notify -y
```

(Check the exact submodule machine names on the **Extend** page after install.)

## Verify it worked

Log in as a user with the **`administer headless_cms settings`** permission. The
Headless CMS settings should be reachable, and — because the module builds on
Consumers — you should be able to configure its behaviour against the consumers
registered on your site. Continue to [Configuration](../configuration/index.md).
