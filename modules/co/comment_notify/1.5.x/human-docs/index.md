# Comment Notify — manual setup guide

**Comment Notify** (`comment_notify`) emails people when new comments are posted,
so a discussion keeps its participants in the loop. It adds a *"Notify me when new
comments are posted"* checkbox to the comment form — available to logged‑in users
**and anonymous visitors** (who subscribe with the email address they leave) — and
can also notify the author of the content whenever someone comments on it.

This is the classic "someone replied to your comment, come back and read it"
feature that turns a one‑off visitor into a returning participant. Commenters can
choose to follow **all comments** on a piece of content or only **replies to their
own comment**, and every notification email carries a one‑click unsubscribe link
so people are never trapped in a thread. Logged‑in users also get default
subscription preferences on their account page, so they can opt in once and follow
everything automatically.

The emails are built from token‑based templates, so you can include things like
`[node:title]`, `[comment:author]`, and `[comment:body]`, and you can write
separate wording for the two kinds of recipient — the *watcher* (a subscribed
commenter) and the *entity author* (the person whose content was commented on).
Templates are defined per entity type, so node‑comment emails can read differently
from taxonomy‑term‑comment emails. It depends on core's **Comment** module and the
contributed **Token** module.

Which comment forms show the checkbox is controlled per bundle, so you can offer
follow‑up notifications on articles but not on basic pages, for example. Two
permissions govern who can administer the feature and who can subscribe.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Token) with
   Composer, enable it, and set permissions.
2. [Configuration](configuration/index.md) — the settings page, field by field:
   which bundles are enabled, subscription modes, defaults, and email templates.

## Where it lives in the admin menu

Its settings form is at **Configuration → People → Comment Notify**
(`/admin/config/people/comment_notify`), reachable by users with the **Administer
comment notify** permission.

## How to use it

1. Enable notifications on the comment fields you want (by default only
   `node--article--comment` is enabled) — see [Configuration](configuration/index.md).
2. Grant the **Subscribe to comments** permission to the roles (including
   *Anonymous user*, if you want visitors to subscribe) that should see the
   checkbox.
3. Visitors and users now get a *"Notify me when new comments are posted"* option
   when they comment, and each notification email includes an unsubscribe link.
   Logged‑in users can set a standing default on their own account page.
