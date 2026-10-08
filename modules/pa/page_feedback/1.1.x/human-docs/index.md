# Page Feedback — manual setup guide

**Page Feedback** (`page_feedback`) adds a lightweight "Was this page helpful?"
prompt to any page through a block. A visitor picks Yes or No, can leave an
optional comment, and each answer is stored as a `page_feedback` content entity.
Editors then read every response on one admin page under **Content**, filter it,
and export it to CSV. It is aimed at content and communications teams who want a
direct answer to "did this page do its job" rather than raw traffic numbers.

The module is plug‑and‑play: there is no field to add to a content type and no
per‑entity configuration. You enable it, place the block on the pages you care
about, and the block automatically attaches each response to the page it sits on.
Submissions are open to anonymous visitors by design, but hardened several ways —
a per‑IP flood limit (the IP is stored only as a one‑way hash, never in clear
text), a required JavaScript token that turns away no‑JS bots, an optional
[Honeypot](https://www.drupal.org/project/honeypot) integration when that module
is present, and a 1000‑character cap on comments. The recorded page URL has its
query string stripped so no accidental personal data is kept.

This branch (**1.1.x**) adds a per‑placement **Wording** panel to the block, so you
can reword the question, the two comment‑box labels, and the notice — or run two
blocks with different questions — without touching code. It also remembers a
visitor's prior answer per path in their browser, and it runs on Drupal 10.3, 11,
and 12. (On the earlier **1.0.x** branch the widget always uses the shipped
wording.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the block's **Wording** panel, field
   by field, plus the two permissions that gate reading and exporting responses.

## Where it lives in the admin menu

Page Feedback adds no configuration page of its own — its settings live on the
**block itself**. You place and configure the block from **Structure → Block
layout** (`/admin/structure/block`), and you review the collected answers at
**Content → Page feedback** (`/admin/content/page-feedback`).

## How to use it

1. Enable the module — the `page_feedback` entity and its admin routes install
   automatically. Nothing appears on the front end until you place the block.
2. Go to **Structure → Block layout** and place the **Page feedback** block
   (category *Content*) in the region and on the pages where you want a
   helpfulness prompt. In the block form you can optionally reword the prompts —
   see [Configuration](configuration/index.md).
3. (Recommended for high‑traffic anonymous pages) install and enable
   [Honeypot](https://www.drupal.org/project/honeypot) — the feedback form adds
   its protection automatically when the module is present.
4. Under **People → Permissions**, grant **View page feedback** to roles that
   should read responses and the restricted **Administer page feedback** to roles
   that should delete or export them.
5. Review responses at **Content → Page feedback**: filter by helpful state and
   URL, delete individually or in bulk, and use **Export** to download the
   filtered list as CSV.
