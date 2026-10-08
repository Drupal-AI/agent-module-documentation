# Revision Author Tokens — manual setup guide

**Revision Author Tokens** (`revision_author_tokens`) fills a real gap in Drupal's
token system: it adds tokens for the author of a node **revision** — the person who
made the current version — rather than the node's owner. Core's `[node:author]`
token names who *created* the node, which is not the same as who *last changed* it.
For any "who edited this page" message, the revision author is the useful identity,
and core has no token for it.

The module adds three node tokens:

- `[node:revision-author]` — the name of the user who created the current revision.
- `[node:revision-author-uid]` — that user's user ID.
- `[node:revision-author-email]` — that user's email address.

You can use these anywhere tokens are consumed — Views, ECA/Rules actions, message
templates, Metatag, Pathauto, custom blocks, and mail bodies. There is nothing to
configure: once the module is enabled the tokens are available immediately.

It depends on the contributed **Token** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** and no post-install setup — the tokens work as
soon as the module is enabled.

## How to use it

Wherever a token field or token pattern is available (a Views field, an ECA/Rules
message, a Metatag pattern, a mail template), insert one of the tokens:

- `[node:revision-author]` for the reviser's name,
- `[node:revision-author-uid]` for their user ID,
- `[node:revision-author-email]` for their email address.

> **Privacy caution:** these tokens name a real person. Putting a revision author
> into a public URL alias, a meta description, or a rendered field discloses who
> edited a page to every visitor. Keep them to internal notifications and admin-only
> displays unless disclosing the editor is genuinely intended.
