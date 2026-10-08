# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or newer**.
- The **Mail System** module (`drupal/mailsystem` `^4`) — required, and used to
  select this module as the mailer.
- The **`mailchimp/transactional` PHP library** (`^1.0.47`) — the official
  Mailchimp Transactional SDK. This is a Composer library, not a Drupal module, and
  Composer installs it for you when you require the module with dependencies.
- A **Mailchimp Transactional (Mandrill) account** and an **API key**, plus a
  verified sender address in that account.

## Install with Composer

From the project root:

```bash
composer require drupal/mailchimp_transactional -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer pull
in both the Mail System module and the `mailchimp/transactional` PHP library
alongside the Drupal module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mailchimp_transactional -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailchimp_transactional -y
```

This also enables Mail System if it isn't already on. If you previously used the old
**Mandrill** module, its settings, permissions, and Mail System assignments are
migrated automatically during install.

Next, configure the API key and sender, and select the mailer in Mail System — see
[Configuration](../configuration/index.md).

## Submodules — enable only what you need

Mailchimp Transactional ships three optional submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Activity** | `mailchimp_transactional_activity` | Per‑entity/per‑user email activity views, so you can see the delivery history for a given user. Adds `administer …` and `view mailchimp transactional activity` permissions. |
| **Reports** | `mailchimp_transactional_reports` | An account‑wide sending dashboard (volume, opens, clicks) drawn from your Mailchimp Transactional account. Adds a `view mailchimp transactional reports` permission. |
| **Template** | `mailchimp_transactional_template` | Maps Drupal mail keys to Mailchimp Transactional templates, so outgoing mail can be wrapped in a designed template. Adds an `administer mailchimp transactional templates` permission. |

Enable any of them with `drush en`, for example:

```bash
drush en mailchimp_transactional_reports -y
```

Each requires the base module, which is already present once you've installed it
above.
