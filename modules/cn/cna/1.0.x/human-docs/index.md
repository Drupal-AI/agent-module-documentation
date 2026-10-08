# Comment Notify Author — manual setup guide

**Comment Notify Author** (`cna`) sends an email to a node's author whenever a
comment is posted or updated on their content. It is the small, focused answer to
"let content owners know when someone comments on their post" — without the
weight of a full subscriptions or notifications system. It reacts to core's
comment hooks, stores nothing extra, and adds no new entities.

The recipient is always the **owner of the commented node**, using their account
email and preferred language. The message uses your site name and includes the
commenter's name, the node title, and a link to the comment. You can toggle
notifications for **new comments** and for **comment updates** independently, and
comment-update notifications only fire when the comment is published.

Because it sends mail, you should have a working mail system configured on the
site first (SMTP or another mail transport) — otherwise the notifications have no
way out. There is no per-user opt-in or opt-out; the two global toggles control
the behaviour for everyone. If a node owner has no valid email, the send is
skipped and logged.

It depends only on core's **Comment** module and works on any comment-enabled
entity that returns a Node as the commented entity. It is security-advisory
covered, and the only route it adds is its own admin settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Comment dependency.
2. [Configuration](configuration/index.md) — the two notification toggles.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Comment Notify Author**
(`/admin/config/system/cna`), reachable by users with the **Administer CNA
configuration** permission.
