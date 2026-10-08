# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **[Private Message](https://www.drupal.org/project/private_message)** module
  (`private_message`) — this add-on layers a chat-window UI over it and cannot run
  without it.

## Install with Composer

From the project root:

```bash
composer require drupal/private_message_windows -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Private Message
(and any shared dependencies) at compatible versions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/private_message_windows -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en private_message_windows -y
```

Drupal enables `private_message` at the same time if it isn't already on.

## Verify it worked

With Private Message configured and messaging permissions granted, open the site
as a member and start (or continue) a conversation — it should appear as a docked
chat window in the corner of the page rather than a full-page thread view. Add a
`/private-message/create?recipient=XXX` link somewhere and confirm that clicking
it opens a new conversation window in place.
