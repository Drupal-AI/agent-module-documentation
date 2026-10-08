# Message Notify Logger — manual setup guide

**Message Notify Logger** (`message_notify_logger`) adds verbose, database-backed
logging to the [Message Notify](https://www.drupal.org/project/message_notify)
module. Every time a message notification is sent, it records the event to the
database, giving teams an audit trail of what was delivered — which message, to which
recipient, over which channel, and whether it succeeded or failed.

The problem it addresses is visibility. By default, when a notification goes out
there is little record that it happened, which makes it hard to answer "did that user
actually get the email?" or to debug why a notification never arrived. This module
turns those deliveries into inspectable log entries so you can audit and troubleshoot
message-based notifications after the fact.

It depends on [Message Notify](https://www.drupal.org/project/message_notify) and
supports Drupal 9, 10 and 11. There is no settings page — once enabled it logs
delivery activity automatically.

One important caveat from the module's own notes: this logging relies on specific
**forks of the Message Notify and Message Subscribe stack** that add the "logger
delegation" and "origin" hooks it needs. Without those upstream patches/forks in
place, the logging will not capture events. Confirm your Message stack provides the
required hooks before you depend on this module in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and note
   the upstream fork requirement.

There is **no configuration page** for this module — it logs Message Notify
deliveries automatically once the required hooks are present.

## How to use it

After enabling, notification deliveries are written to Drupal's database log. Review
them the way you would any log activity — through Drupal's log reports (Reports →
Recent log messages) — to audit which notifications were sent and to investigate
delivery failures. Because the logging depends on the forked Message stack hooks
noted above, verify those are in place if you see no entries.
