# Message recipient group — manual setup guide

**Message recipient group** (`message_recipient_group`) extends
[Message recipient](https://www.drupal.org/project/message_recipient) with one extra
source of recipients: a **Group**. With it, a Message's audience can be resolved from
the membership of a [Group](https://www.drupal.org/project/group), so a notification
flow can target "everyone in group X" without you maintaining that list by hand.

It slots into the recipient-collector model that Message recipient provides: this
module contributes a collector that reads Group membership and turns it into the list
of users who should receive the message. That makes it a natural fit for
group-scoped notifications — announcements to a team, updates to members of a space,
and similar audience-by-membership patterns.

Two practical notes. It depends on the **`message_recipient_entity`** component of the
Message recipient project (and, through it, on the
[Group](https://www.drupal.org/project/group) module), so both must be present. And,
like the rest of this family, it is an **early alpha release** the maintainers say is
not yet production-ready. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Message recipient and Group.

There is **no configuration page** for this module — it adds a group-based recipient
collector that you use through Message recipient, as described below.

## How to use it

1. Set up [Message recipient](https://www.drupal.org/project/message_recipient) (and
   its UI submodule) and the [Group](https://www.drupal.org/project/group) module.
2. Enable this module.
3. On a message template's recipient collectors, add the **group** collector this
   module provides and point it at the Group whose members should receive the message.
4. When the notification flow sends the message, the collector resolves the current
   membership of that Group into the recipient list.
