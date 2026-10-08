# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Webform** module (`webform`) enabled — this module adds a handler to
  Webform, so it is a hard dependency.
- A **Slack incoming webhook URL** for the channel you want to notify (see *How to
  use it* in the [main guide](../index.md)).

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/slack_webform_handler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Webform module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slack_webform_handler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slack_webform_handler -y
```

Drupal enables the Webform module automatically as a dependency if it is not
already on.

## Verify it worked

Attach the Slack handler to a test form (see the [main guide](../index.md)),
submit the form once, and confirm the notification appears in your chosen Slack
channel. If nothing arrives, double-check that the webhook URL is correct and
still active in Slack.
