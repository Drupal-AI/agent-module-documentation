# Message Push — manual setup guide

**Message Push** (`message_push`) is a lightweight bridge between the
[Message](https://www.drupal.org/project/message) module and the
[Push Framework](https://www.drupal.org/project/push_framework). It lets messages
generated in Drupal be delivered as push notifications through the Push Framework's
channels — filling a role similar to
[Message Notify](https://www.drupal.org/project/message_notify), but with the full
flexibility of Push Framework. It also makes the message's tokens available in the
Push Framework notification template.

The way it works is through **subscription types**. Message Push uses the
[Flag](https://www.drupal.org/project/flag) module so users can subscribe to changes
on any kind of entity, and you define subscription types that tie a **flag** to a
**message type** and a **push type**. Common uses: notify users when a comment is
placed on their content, when someone they follow posts a new blog post, or when a
new event is created in their area.

It is important to understand what this module does **not** do: it does not create
any messages itself. You need another mechanism to generate the messages — custom
code or the [ECA](https://www.drupal.org/project/eca) module — and Message Push then
relays them through Push Framework. It depends on
[Message](https://www.drupal.org/project/message) and
[Push Framework](https://www.drupal.org/project/push_framework) (and uses
[Flag](https://www.drupal.org/project/flag)); note that these are intentionally
**not** installed automatically, so you choose the versions yourself. It supports
Drupal 10.2+ and 11.

This module needs configuration before it is useful: you create a flag and a message
type, then define a subscription type that links them. See
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Message, Flag and Push Framework.
2. [Configuration](configuration/index.md) — create a flag and message type, then add
   a subscription type that ties them together.

## Where it lives in the admin menu

Subscription types are managed at **`/admin/config/people/subscription-type`**.
Managing them is gated by the **Administer subscription type**
(`administer subscription_type`) permission, granted at **People → Permissions**.
