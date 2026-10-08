# Configuration

Setting up Questions and Answers has three parts: the global settings form, the Q&A
field you add to a bundle (with its formatter options), and the permissions that
decide who can do what. Moderation happens day to day from the content area.

## Global settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Questions and Answers**, or navigate
   directly to `/admin/config/content/questions-answers`.

Here you set site‑wide options for the Q&A system, including:

- A **no‑access message** shown to users who lack permission to take part.
- A **terms and conditions** link presented alongside the ask/answer forms.
- The address list that receives **email notifications** of new questions.

Adjust these to taste and click **Save configuration**.

## Add the Q&A field to a bundle

A Q&A thread only appears where you attach the field:

1. Go to the bundle you want — for example **Structure → Content types → Article →
   Manage fields**.
2. Add a new field of type **Questions and Answers**.
3. Switch to **Manage display** for that bundle and configure the field's formatter
   options:
   - **Auto‑approve** — whether new questions/answers appear immediately or wait for
     moderation. (Administrators' own posts are auto‑approved regardless.)
   - **"Was this helpful?"** — show or hide the helpful / not‑helpful control.
   - **Date format** — how post dates are displayed.
   - **Notification emails** — the address(es) alerted about activity on this field.

Because the formatter options are per display, you can run an open, auto‑approved
community Q&A on one bundle and a moderated, staff‑only thread on another.

## Permissions

At **People → Permissions** (`/admin/people/permissions`), grant the Q&A
permissions to the roles that should participate. The module provides:

- **Administer questions and answers** — moderate, verify, and manage everything
  (grant to trusted staff only).
- **Ask questions and answers** — post new questions.
- **Answer questions and answers** — post answers (answers can only be added when
  the question is published). Restrict this permission to create a "Q&A with the
  site owners" experience.
- **Report questions and answers** — flag inappropriate posts.
- **Subscribe to questions and answers** — follow a question to get an email when it
  is answered.

Helpful voting is available to logged‑in users when the "was this helpful" option is
enabled.

## Moderation

Moderators work from **Content → Questions and Answers**
(`/admin/content/questions-answers`) and its **moderation** tab
(`/admin/content/questions-answers/moderation`), both gated by **Administer
questions and answers**. From here you approve pending questions and answers, act on
reported items (report counts are shown to admins), and flag answers as
**verified**. A moderation‑alerts block surfaces items awaiting review. The shipped
`qa_staff_member` and `qa_top_contributor` roles are badged on answers, so you can
highlight trusted contributors.

## Views integration

The module ships Views field plugins that expose Q&A data — the answer list, the
author, helpful votes, and whether an item was reported or subscribed to — so you
can build custom listings and dashboards if you need them.
