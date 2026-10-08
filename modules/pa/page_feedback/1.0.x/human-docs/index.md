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

This branch (**1.0.x**) collects Yes/No answers with an optional comment using the
module's built‑in, translatable wording. If you want to reword the question and
comment prompts per block placement, that ability was added in the **1.1.x**
branch — see the 1.1.x guide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no module settings form** on this branch — the widget uses its shipped
wording, and everything else happens by placing a block and setting two
permissions, described in "How to use it" below.

## Where it lives in the admin menu

Page Feedback adds no configuration page of its own. You place its block from
**Structure → Block layout** (`/admin/structure/block`), and you review the
collected answers at **Content → Page feedback**
(`/admin/content/page-feedback`).

## How to use it

1. Enable the module — the `page_feedback` entity and its admin routes install
   automatically. Nothing appears on the front end until you place the block.
2. Go to **Structure → Block layout**, place the **Page Feedback** block in the
   region and on the pages where you want a helpfulness prompt. The block renders
   an Ajax Yes/No form with an optional comment box.
3. (Recommended for high‑traffic anonymous pages) install and enable
   [Honeypot](https://www.drupal.org/project/honeypot) — the feedback form adds
   its protection automatically when the module is present.
4. Under **People → Permissions**, grant the two permissions to the right roles:
   - **View page feedback** (`view page feedback`) lets a role browse and filter
     the collected responses without being able to change anything.
   - **Administer page feedback** (`administer page feedback`) grants full access,
     including single and bulk deletion and CSV export. It is flagged as a
     restricted permission, so hand it only to trusted roles.
5. Review responses at **Content → Page feedback**. Filter by helpful/not‑helpful
   and by URL, delete entries individually or in bulk, and use **Export** to
   download the filtered list as a CSV (the export route is CSRF‑protected).

A cron‑driven cleanup prunes obvious spam entries automatically, so there is
nothing to schedule yourself.
