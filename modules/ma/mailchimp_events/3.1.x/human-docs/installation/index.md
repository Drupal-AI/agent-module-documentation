# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The base **Mailchimp** module and its **Mailchimp Lists** submodule
  (`mailchimp_lists`) — a hard dependency. Mailchimp Events is entirely dependent
  on Mailchimp being installed and configured first.
- A **Mailchimp account and API key**.

## Install with Composer

From the project root:

```bash
composer require drupal/mailchimp_events -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Mailchimp dependency as needed. If you don't already have the base Mailchimp
module, it will be brought in; you can also require it explicitly with
`composer require drupal/mailchimp -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mailchimp_events -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailchimp_events -y
```

`mailchimp_lists` (and the base Mailchimp module) are enabled automatically as
dependencies if they aren't already.

## Verify it worked

First make sure the base **Mailchimp** module is connected to your account (see
[Configuration](../configuration/index.md)). Then define an event and trigger it
as a known user, and confirm the event shows up in your Mailchimp account's
activity for that contact.
