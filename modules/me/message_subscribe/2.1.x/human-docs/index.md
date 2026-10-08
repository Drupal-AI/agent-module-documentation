# Message Subscribe — manual setup guide

**Message Subscribe** (`message_subscribe`) is a **subscription and notification
API** built on top of the Flag, Message, and Message Notify modules. Users
"subscribe" to things — a node, a taxonomy term, another user — by flagging them,
and when something relevant happens your site sends each subscriber a personalized
notification (email by default). It's the engine behind "email me when new content
appears in this section" or "notify a node's author when someone comments."

A key thing to understand up front: the base module is **mostly a developer API,
not an out-of-the-box feature**. On its own it provides no end-user interface for
subscribing — that's the job of the **Message Subscribe UI** submodule. The base
module's job is the plumbing: your (or a contrib module's) code builds a Message
entity and hands it to the `message_subscribe.subscribers` service, which works out
who's subscribed in the relevant "context" (the entity, its author, its referenced
terms, the commented node for comments), filters that list (skipping blocked users,
users who can't view the content, and optionally the person who triggered the
event), and delivers a copy of the message to each recipient. Delivery can run
inline or be pushed through Drupal's queue and processed in batches on cron, so it
scales to large audiences.

Subscriptions are just **Flag** flaggings. Any flag whose machine name starts with
the configured prefix (`subscribe_` by default) counts as a subscription flag. The
module ships ready-made but **disabled** flags — `subscribe_node`, `subscribe_term`,
`subscribe_user` — that you enable and configure like any other flag. Developers can
customize everything through three hooks (add recipients, filter recipients,
personalize each message) and a `DeliveryCandidate` value object.

Three submodules extend it: **Message Subscribe UI** (`message_subscribe_ui`) adds
the user-facing subscriptions interface and the admin permission, **Message
Subscribe Email** (`message_subscribe_email`) adds per-flag email preferences, and
**Message Subscribe Example** (`message_subscribe_example`) is a worked example.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Flag /
   Message / Message Notify dependencies with Composer, and enable the submodules
   you need.
2. [Configuration](configuration/index.md) — the admin settings form, the
   `subscribe_` flags, and the permission you need to enable.

## Where it lives in the admin menu

The admin settings form sits at **Configuration → Messaging → Message subscribe**
(`/admin/config/message/message-subscribe`). The subscription flags are managed at
**Structure → Flags** (`/admin/structure/flags`).

> **Heads-up:** the permission that guards the settings form
> (*Administer message subscribe*) is actually defined by the **Message Subscribe
> UI** submodule. With only the base module enabled, that permission doesn't exist,
> so only user 1 can reach the settings page — enable `message_subscribe_ui` to
> grant it to roles. See [Configuration](configuration/index.md).
