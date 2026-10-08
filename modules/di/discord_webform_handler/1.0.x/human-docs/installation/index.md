# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Webform** module (`drupal/webform`) — a hard dependency. Composer pulls it
  in automatically if it is not already present.
- No third‑party Composer packages or PHP libraries.
- A Discord server where you have permission to create a webhook.

## Install with Composer

From the project root:

```bash
composer require drupal/discord_webform_handler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and pull in Webform if needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/discord_webform_handler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en discord_webform_handler -y
```

Webform will be enabled as a dependency if it is not already.

## Create the Discord webhook

You will need a webhook URL for each channel you want submissions to land in:

1. In Discord, open the target channel's settings (the gear icon) → **Integrations**.
2. Click **Create Webhook**, choose the channel, and give it a name/avatar.
3. Click **Copy Webhook URL** — you will paste it into the handler on the
   [Configuration](../configuration/index.md) page.

Treat the webhook URL as a **secret**: anyone who has it can post to your channel.

## Verify it worked

After adding the Discord handler to a form and pasting in the webhook URL (see
[Configuration](../configuration/index.md)), submit the form once and confirm the
submission appears in your Discord channel.
