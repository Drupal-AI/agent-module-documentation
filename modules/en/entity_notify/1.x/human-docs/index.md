# Entity Notify — manual setup guide

**Entity Notify** (`entity_notify`) sends notifications to administrators and
moderators when entities are **created, edited, or deleted** — by email, by
**Telegram**, or both. Operators often want to know the moment something happens on
the site: a new user registers, a webform or other entity is submitted, a node of a
certain type is published. Entity Notify watches the entity types you choose and
fires off a message when one of those events occurs.

You have flexibility over **who** gets notified. Messages can go to the site admin
(user 1), to everyone in one or more chosen roles, to a custom list of email
addresses, and — for comments — to the author of the node that was commented on. On
top of email, the module can post messages to **Telegram bots**, which is what its
dependency on the **Telegram API** module provides.

Entity Notify runs on Drupal 10 and 11. A couple of security points are worth
keeping in mind: a Telegram bot token is a **credential**, so keep it out of plain
configuration (store it as an environment variable / Key rather than committing it),
and the notifications themselves can contain entity data, so send them to
appropriately private inboxes and Telegram chats — the destination inherits the
sensitivity of whatever the notification contains.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Telegram API
   dependency, then enable it.
2. [Configuration](configuration/index.md) — choose which entities to watch, who
   gets notified, and set up the email and Telegram channels.

## Where it lives in the admin menu

Entity Notify provides a settings form where you pick the entity types to watch and
configure the notification recipients and channels. Telegram delivery additionally
relies on the **Telegram API** module's own bot configuration.
