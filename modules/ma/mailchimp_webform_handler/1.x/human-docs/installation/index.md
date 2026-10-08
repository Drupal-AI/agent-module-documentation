# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Webform** module (`webform`) — a hard dependency, since this module adds a
  webform handler.
- A **Mailchimp account and API key** for each audience you want to subscribe
  people to.

Note that, unlike some Mailchimp integrations, this module does **not** require the
full Mailchimp module to be enabled — the handler talks to Mailchimp with its own
key.

## Install with Composer

From the project root:

```bash
composer require drupal/mailchimp_webform_handler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Webform isn't already installed, add it the same way
(`composer require drupal/webform -W`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mailchimp_webform_handler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailchimp_webform_handler -y
```

Webform is enabled automatically as a dependency if it isn't already.

## Verify it worked

Edit a webform, open its **Handlers** settings, and confirm you can add the
Mailchimp handler. After configuring it with your API key, list, and field mapping
(see the [overview](../index.md#how-to-use-it)), submit a test entry and check that
the contact appears in the intended Mailchimp audience.
