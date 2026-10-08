# Content Moderation Link — manual setup guide

**Content Moderation Link** (`content_moderation_link`) lets editors move content
through its moderation workflow by visiting a specially crafted **URL**, rather than
opening the edit form. That makes it possible to embed a "one-click" moderation
action anywhere a link can go — a listing, a dashboard, an email, or a Slack
message — so an administrator can, for example, publish one or more items straight
from their inbox.

A moderation link looks like this:

```
https://mydomain.com/content-moderation-link/process/in_review/node/108,109
```

The last three parts of the URL specify what happens:

- the **machine name of the target workflow state** (for example `draft` or
  `published`),
- the **machine name of the entity type** (for example `node`),
- one or more **entity IDs** to process (comma-separated).

Crucially, the link is **permissions-aware** — it does **not** bypass moderation
access. The module reuses your existing permissions: to use a link, a user must be
authenticated (they're redirected to log in if not) *and* must have permission to
perform the needed transition from the content's current state to the target state.
In other words, the link only surfaces a transition the user was already allowed to
make; it never grants an unintended one.

From the 1.1.x branch onward you can generate these URLs with a **token**, such as
`[node:moderation-link:published]`, which makes it easy to drop the right link into
emails, views, or templates. The module's only dependency is core **Content
Moderation**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** for this module — its behavior is the moderation URL
(and token) described here, gated entirely by your existing moderation permissions.

## How to use it

1. Make sure the users who will follow moderation links already have the workflow
   transition permissions they need in core Content Moderation.
2. Build a moderation URL in the form
   `/content-moderation-link/process/{target_state}/{entity_type}/{ids}` — or, on
   the 1.1.x branch, generate it with the `[node:moderation-link:{state}]` token in
   an email template, view, or Slack notification.
3. When an authenticated, suitably-permitted user follows the link, the listed
   entities are moved to the target state. Anyone not logged in is sent to the login
   page first, and anyone lacking the transition permission is not allowed to make
   the change.
