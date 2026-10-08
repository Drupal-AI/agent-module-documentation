# Installation

## Requirements

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6 || ^11`).
- Core's **Database Logging** module (`dblog`) — the module watches the watchdog
  stream that dblog records, so it must be enabled.
- For the Slack/webhook submodule: the **Key** module (`drupal/key`), used to store
  the webhook URL securely.
- For the Monolog submodule: the **Monolog** contrib module.

> **Security-advisory note:** this project is currently **not covered** by Drupal's
> security advisory policy. Weigh that before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/log_alert_rules -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/log_alert_rules -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en log_alert_rules -y
```

Make sure **Database Logging (dblog)** is enabled too:

```bash
drush en dblog -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Log Alert Rules Webhook** | `log_alert_rules_webhook` | Slack (Block Kit via incoming webhook) and generic webhook notification channels. Depends on the **Key** module; the webhook URL is stored as a Key entity, not plaintext config. |
| **Log Alert Rules Monolog** | `log_alert_rules_monolog` | Routes **Monolog** log records into the alerting engine. Zero-configuration — enable it and alerting behaves on a Monolog site exactly as on a standard site. |

For example, to add Slack/webhook support:

```bash
drush en log_alert_rules_webhook -y
```

If you run **Monolog without** the Monolog submodule, alerts will silently never
fire — the Status report (**Reports → Status report**) shows a warning so the
situation isn't hidden. Enable `log_alert_rules_monolog` to fix it.

## Verify it worked

Log in as an administrator with the **administer log alert rules** permission and
visit **Configuration → System → Log Alert Rules**
(`/admin/config/system/log-alert-rules`). Create a rule, then use its **test**
action against recent log entries to confirm the module can see your logs. Continue
to [Configuration](../configuration/index.md).
