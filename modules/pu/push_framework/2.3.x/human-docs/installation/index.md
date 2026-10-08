# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Advanced Queue** module (`advancedqueue`) — the durable queue backend
  Push Framework relies on for retry and backoff. Pulled in automatically.
- Core **Node**, **Text**, and **User** — enabled automatically as dependencies.
- At least one **channel module** (Email, Slack, Twilio, OneSignal, etc.) to
  actually deliver notifications — the framework sends nothing on its own.
- A **queue runner** (cron or a dedicated worker) to process queued jobs.

## Install with Composer

From the project root:

```bash
composer require drupal/push_framework -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Advanced Queue.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/push_framework -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en push_framework -y
```

## Submodules

Push Framework ships one submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **ECA Push Framework** | `eca_push_framework` | Lets [ECA](https://www.drupal.org/project/eca) models emit Push Framework messages, so you can trigger notifications from no-code automation rather than writing PHP. Requires the ECA module. |

Enable it only if you use ECA:

```bash
drush en eca_push_framework -y
```

## Recommended companion module

For deciding **what** to push and **to whom**, the maintainers recommend the
[DANSE](https://www.drupal.org/project/danse) module, which supplies source and
recipient plugins that plug into Push Framework.

## Verify it worked

1. Go to **Configuration → System → Push Framework**
   (`/admin/config/system/push_framework`) and confirm the settings form loads.
2. Install and enable at least one **channel module**, then confirm it appears as
   an available channel.
3. Make sure your **queue runner** is processing the Advanced Queue queue (via
   cron or a worker) — see [Configuration](../configuration/index.md).
