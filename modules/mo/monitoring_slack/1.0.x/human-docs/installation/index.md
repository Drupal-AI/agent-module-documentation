# Installation

## Requirements

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6 || ^11`).
- The **Monitoring** module (`monitoring`) — this module hooks into Monitoring's
  sensor runs, so Monitoring must be installed with sensors configured.
- A **Slack incoming webhook URL**. Create one at
  [api.slack.com/messaging/webhooks](https://api.slack.com/messaging/webhooks).

## Install with Composer

From the project root:

```bash
composer require drupal/monitoring_slack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Monitoring
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monitoring_slack -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monitoring_slack -y
```

> **Note:** at the time of writing this is an alpha release
> (`1.0.0-alpha2`) — test it on a non-production environment first.

## Verify it worked

Log in as an administrator and go to **Configuration → System → Monitoring
settings** (`/admin/config/system/monitoring`). You should now see a **Slack
notifications** section on the form. Continue with
[Configuration](../configuration/index.md) to connect your webhook and send a test
message.
