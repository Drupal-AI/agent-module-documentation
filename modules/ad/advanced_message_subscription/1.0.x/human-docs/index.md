# Advanced Message Subscription — manual setup guide

**Advanced Message Subscription** (`advanced_message_subscription`) adds
fine-grained subscription control on top of the contributed **Message** module.
Where Message handles creating and storing activity/notification messages, this
module lets users (and administrators) choose *which* of those message
notifications they subscribe to — for example per message type or category — so
notification delivery can be tailored to each person's preferences rather than
being all-or-nothing.

It is a user-engagement / messaging helper. It manages notification
subscriptions and provides its own permission; it plays no role in access control
beyond that permission, and it does not itself create or send the messages —
that is the Message module's job.

This module is an early **alpha** release (`1.0.0-alpha9`) and its own
documentation is brief, so the exact subscription screens depend on your Message
setup. Treat the details below as a starting point.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module does not add a prominent top-level admin section. Its subscription
options appear alongside the Message module's own configuration and on the
user-facing subscription settings, and it adds a permission you grant under
**People → Permissions** (`/admin/people/permissions`) to control who may manage
their notification subscriptions.

## How to use it

1. Make sure the **Message** module is installed and configured with the message
   types you want people to be able to subscribe to.
2. Under **People → Permissions**, grant the subscription-management permission to
   the roles that should be able to control their own notification preferences.
3. Users then choose which message types or categories they subscribe to from
   their subscription settings, and delivery is tailored accordingly.
