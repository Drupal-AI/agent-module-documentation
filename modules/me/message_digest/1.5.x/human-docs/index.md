# Message Digest — manual setup guide

**Message Digest** (`message_digest`) adds daily, weekly, or custom-interval
**digest** delivery on top of Drupal's Message and Message Notify stack. Instead
of firing off an individual email every time a user gets a notification, it
collects a user's messages and sends them as a single periodic digest on cron —
a daily or weekly roundup rather than a flood of emails.

It works by registering **digest notifier plugins**. Each digest interval you
define is a small config entity (an interval like `1 day` or `1 week`), and the
module automatically produces a matching notifier for it. When a message is sent
using a digest notifier, it is not emailed straight away — it is recorded in a
database table. On cron, the module finds users whose interval has elapsed,
groups their pending messages, renders them, and sends one digest email.

Out of the box it ships **daily** and **weekly** intervals, and you can add your
own (for example "every 3 days") without writing code. Two alter hooks let other
modules regroup or reorder the messages in a digest, change the view modes used
to render them, or veto delivery entirely (for instance, to skip blocked users).
An optional submodule, **Message Digest UI** (`message_digest_ui`), lets each
user pick their own notification frequency.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Message
   dependencies with Composer, and enable it.
2. [Configuration](configuration/index.md) — manage digest intervals and hook
   your notifications up to a digest notifier.

## Where it lives in the admin menu

The digest intervals are managed at **Configuration → Message → Message digest**
(`/admin/config/message/message-digest`), under the Message settings. You need
the **Administer message digest** permission to reach it.

## How to use it

1. Make sure cron runs regularly — digests are assembled and sent on cron.
2. Review or add **digest intervals** (see
   [Configuration](configuration/index.md)).
3. Send your Message notifications using a **digest notifier id** (for example
   `message_digest:daily`) instead of an immediate notifier. From then on those
   messages are collected and delivered as a digest.
