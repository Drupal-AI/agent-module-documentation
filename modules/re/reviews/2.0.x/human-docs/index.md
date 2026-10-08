# Reviews — manual setup guide

**Reviews** (`reviews`) lets authenticated users leave reviews — a rating plus
text — on your site's content. You enable it on a per content type basis, so you
can, for example, allow reviews on "Gigs" and "Artists" on a music site while
leaving other content types alone. Reviews are stored as their own entities, and
every review is subject to moderation: you can require approval before a review is
published, and you can delete any review at any time.

Because reviews are **user-submitted content**, treat them accordingly: display
review text safely (Drupal escapes it, so avoid rendering it as raw markup),
moderate to keep spam and abuse in check (approval and flood control help), and
gate who may submit and who may moderate using the module's permissions. Reviews
may also contain personal data. The module has no access-control role beyond its
own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn the system on, choose which
   content types accept reviews, and set moderation behavior.

## Where it lives in the admin menu

Reviews settings live at **Structure → Reviews → Settings**
(`/admin/structure/reviews/settings`), where you enable the system, pick content
types, and set moderation. Reviews left by users are moderated from **Content →
Reviews** (`/admin/content/reviews`), where you can approve or delete them.
