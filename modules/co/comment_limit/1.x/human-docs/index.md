# Comment Limit — manual setup guide

**Comment Limit** (`comment_limit`) caps how many comments a single user may post
on a given comment field, something Drupal core doesn't do on its own. Once a user
reaches the configured maximum, they can't add more comments there. The limit is
adjustable per comment field / per node type, so you can tune it to each kind of
content.

A classic use case is when comments double as **reviews or ratings** — for
example, letting each user review and rate a product only once. More broadly it's
a moderation and anti‑abuse guardrail: it stops one voice from flooding a thread
and blunts automated comment spam that relies on sheer volume. Because the limit
is enforced at submission time, it governs what actually gets created rather than
hiding comments after the fact.

Keep in mind it's a blunt instrument — it counts comments, not quality, so a
genuinely active participant hits the same cap as a flooder. Set the limit high
enough not to frustrate real discussion while still bounding abuse, and treat it as
one layer alongside your usual anti‑spam measures (moderation, CAPTCHA) rather than
a replacement for them. It works on Drupal 9, 10, and 11 with no other
dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the per‑field limit and review
   the permission it adds.

## Where it lives in the admin menu

Comment Limit doesn't add a big central settings page; you set the maximum on the
comment field itself, per content type. It also adds a permission you'll find at
**People → Permissions** (`/admin/people/permissions`). See
[Configuration](configuration/index.md) for the details.
