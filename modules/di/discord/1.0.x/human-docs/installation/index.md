# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No third‑party Composer packages or PHP libraries.
- **Rules** (`drupal/rules`) is *optional* — enable it only if you want to send
  Discord messages as a no‑code Rules action.
- A Discord server where you have permission to create a webhook.

## Install with Composer

From the project root:

```bash
composer require drupal/discord -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/discord -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en discord -y
```

If you plan to trigger Discord messages from Rules, also enable Rules:

```bash
drush en rules -y
```

## Create the Discord webhook

The module cannot send anything until you give it a webhook URL:

1. In Discord, open **Server Settings → Integrations → Webhooks**.
2. Click **New Webhook**, choose the channel that should receive the messages,
   and give the webhook a name.
3. Click **Copy Webhook URL** — you will paste this into Drupal on the
   [Configuration](../configuration/index.md) page.

Treat the webhook URL as a **secret**: anyone who has it can post to your channel.

## Verify it worked

Enable the module, set the webhook URL on the settings page, then open
`/admin/config/services/discord/test_message`, send a test message, and check that
it appears in your Discord channel. If it does, you are ready to send messages
from code or from Rules.
