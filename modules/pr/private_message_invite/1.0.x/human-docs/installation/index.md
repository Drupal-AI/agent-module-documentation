# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **[Private Message](https://www.drupal.org/project/private_message)** module
  (`private_message`) — Private Message Invites extends its threads and cannot run
  without it.

## Install with Composer

From the project root:

```bash
composer require drupal/private_message_invite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Private Message
(and any shared dependencies) at compatible versions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/private_message_invite -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en private_message_invite -y
```

Drupal enables `private_message` at the same time if it isn't already on.

## Verify it worked

After enabling and granting the invite permission (see
[Configuration](../configuration/index.md)), open any private-message thread as an
authorised user. You should see an **Invite Members** action link on the thread
page — that's the module working.
