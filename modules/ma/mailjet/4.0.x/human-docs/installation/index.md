# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Three PHP libraries, all pulled in automatically by Composer:
  **`mailjet/mailjet-apiv3-php ^1.5`** (the official Mailjet SDK),
  **`phpmailer/phpmailer`**, and **Guzzle**.
- A **Mailjet account** with an API key and secret. If you don't have one yet,
  sign up at [mailjet.com](https://www.mailjet.com/) — you'll find the key and
  secret in your Mailjet account under the API keys section.

## Install with Composer

From the project root:

```bash
composer require drupal/mailjet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Mailjet SDK,
PHPMailer, and Guzzle and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mailjet -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailjet -y
```

## Submodules — enable only what you need

The base `mailjet` module is a mail transport. Everything else is optional, and
enabling the whole set brings a marketing platform into your site. Turn on only
the pieces you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Contact lists** | `mailjet_list` | Manage Mailjet contact lists from Drupal. |
| **Subscription** | `mailjet_subscription` | A newsletter sign-up form / double opt-in handling. |
| **Campaigns** | `mailjet_campaign` | Create and run email campaigns. |
| **Event callbacks** | `mailjet_event` | Receives Mailjet event webhooks (opens, clicks, bounces). Authenticate these by signature. |
| **Statistics** | `mailjet_stats` | Surfaces delivery statistics in Drupal. |
| **Commerce** | `mailjet_commerce` | Connects Mailjet to Drupal Commerce (triggered marketing). |
| **Trigger examples** | `mailjet_trigger_examples` | Example triggers — for reference, not production. |

Enable each with `drush en`, for example:

```bash
drush en mailjet_list mailjet_subscription -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Mailjet**
(`/admin/config/system/mailjet`). You should see the Mailjet settings with an
**API** tab. Enter your credentials there (see
[Configuration](../configuration/index.md)) and send a test message to confirm
mail is flowing through Mailjet.
