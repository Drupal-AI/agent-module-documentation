# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** (`node`) and **User** (`user`) modules — both are enabled on a
  standard Drupal install, and Drupal will pull them in automatically as
  dependencies if they are not.
- No third‑party Composer packages or PHP libraries.
- A Discord server where you have permission to create a webhook.

## Install with Composer

From the project root:

```bash
composer require drupal/discord_notifications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/discord_notifications -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en discord_notifications -y
```

## Create the Discord webhook

The module has nothing to send to until you create a webhook:

1. In Discord, open **Server Settings → Integrations → Webhooks**.
2. Click **New Webhook** and choose the channel that should receive the
   notifications.
3. Click **Copy Webhook URL** — you will paste it into Drupal on the
   [Configuration](../configuration/index.md) page.

Treat the webhook URL as a **secret**: anyone who has it can post to your channel.

## Verify it worked

Once you have set the webhook URL and enabled at least one notification type (see
[Configuration](../configuration/index.md)), trigger a matching event — for
example, create a piece of content or register a test user — and confirm that a
colour‑coded message appears in your Discord channel.
