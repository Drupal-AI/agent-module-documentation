# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No third-party PHP libraries are required.
- The module has no other module dependencies for its core features. If you want
  to trigger Slack messages from the **Rules** module, install `drupal/rules`
  separately — it is only needed for the optional "Send message to Slack" Rules
  action, not for sending from code or the test form.

You will also need access to a **Slack workspace** where you can create an
Incoming Webhook (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/slack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/slack -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slack -y
```

The module ships no submodules. Once enabled, head to
[Configuration](../configuration/index.md) to paste in your webhook URL — until
you do, no messages can be delivered.
