# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Push Framework](https://www.drupal.org/project/push_framework)** module
  (`push_framework`) — the base system this channel plugs into.
- Core's **User** module (`user`), enabled on every standard site.
- A **Twilio account** with an SMS‑capable phone number and your Account SID and
  Auth Token.

There are no extra Composer libraries to add by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/pf_twilio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Push Framework
module and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pf_twilio -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pf_twilio -y
```

Drupal enables Push Framework automatically as a dependency if it is not already on.

## Verify it worked

Log in as an administrator and confirm the module appears enabled at
**Extend** (`/admin/modules`). Then head to [Configuration](../configuration/index.md)
to enter your Twilio credentials, and enable the Twilio channel within Push
Framework's own settings.
