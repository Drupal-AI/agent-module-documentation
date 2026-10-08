# Questions and Answers — manual setup guide

**Questions and Answers** (`questions_answers`) adds a user‑powered Q&A system to
your site. It works as a **field** you attach to any fieldable entity — a node, a
taxonomy term, a product, and so on — so visitors can ask questions and post
answers right on that entity's page. Think of the "Questions & Answers" section
under a product on a site like Amazon: that is exactly the kind of experience this
module provides, but for any content, not just products.

Once the field is on a bundle, users with the right permissions can ask questions,
answer other people's questions, mark answers as helpful or not helpful, report
inappropriate posts, and subscribe to a question to get an email when it is
answered. Administrators get a moderation queue: new questions and answers can be
auto‑approved or held for review, reported items are surfaced for attention, and
admins can flag answers as **verified**. Two shipped roles — `qa_staff_member` and
`qa_top_contributor` — let you badge trusted answerers. You can even restrict who
may answer, turning the field into a "Q&A with the site owners" channel.

Because everything is driven by permissions and a per‑field formatter, the same
module can behave very differently in two places on the same site — an open
community Q&A on one content type, a staff‑answered help thread on another.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — global settings, adding the Q&A
   field, the formatter options, permissions, and moderation.

## Where it lives in the admin menu

Global settings sit at **Configuration → Content authoring → Questions and
Answers** (`/admin/config/content/questions-answers`), which needs the **Administer
site configuration** permission. The moderation queue lives under
**Content → Questions and Answers** (`/admin/content/questions-answers` and
`/admin/content/questions-answers/moderation`), gated by the **Administer questions
and answers** permission.

## How to use it

A Q&A thread only appears where you add the field. On the bundle you want (for
example an article content type), add a **Questions and Answers** field, then on the
bundle's **Manage display** set its formatter options — auto‑approve, the "was this
helpful" control, the date format, and the notification email list. Grant the
ask/answer/report/subscribe permissions to the roles that should participate, and
the thread — with its ask and answer forms — renders on each entity of that bundle
according to what the current user is allowed to do. The [Configuration
guide](configuration/index.md) walks through each step.
