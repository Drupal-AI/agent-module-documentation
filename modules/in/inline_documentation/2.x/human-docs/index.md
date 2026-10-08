# Inline Documentation — manual setup guide

**Inline Documentation** (`inline_documentation`) lets your team add and read
short bits of documentation *in place*, right on the pages where they matter,
instead of parking everything in a separate wiki or a pile of Word documents.
Once enabled, the module adds a small round blue button to the bottom‑right
corner of every page. Clicking it toggles a panel that lists the documentation
notes attached to the site, so the people who need help can find it exactly where
they are working.

The idea is simple: nobody enjoys writing long documentation, and nobody enjoys
hunting through it. So you keep each note short and place it where it is
relevant. You navigate to the page in question, click *Add documentation*, and
write a quick explanation. You can add as many notes as you like to a page, and
you can even attach a note to a specific element on the page. The module stores
these notes as their own **Inline Documentation** content type, which it creates
for you on install.

This makes it a natural fit for onboarding new editors, capturing "how we do
this here" process notes, and documenting a custom admin UI in situ — the kind of
knowledge that usually lives only in someone's head. It works on Drupal 8.8 all
the way through Drupal 11 and needs no third‑party libraries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no central settings page you *must* visit to start using the module — it
works as soon as it is enabled, and the day‑to‑day workflow happens on your site's
own pages, described in "How to use it" below.

## Where it lives in the admin menu

Inline Documentation does not add a Configuration‑section settings form of its own.
Instead, its presence shows up as the floating blue button on every page, and its
notes are stored as **Inline Documentation** nodes that you can also find through
the site's content listing. Two permissions control access: **View inline
documentation overview** (`view inline documentation overview`) lets a user open
the panel and read notes, and **Manage inline documentation settings**
(`manage inline documentation settings`) lets a user administer the feature. Grant
these on **People → Permissions** to the roles that should see and manage
documentation.

## How to use it

1. Log in as a user who has the **View inline documentation overview** permission.
2. Navigate to the page you want to document.
3. Click the round blue button in the bottom‑right corner to open the
   documentation panel, then choose **Add documentation**.
4. Write a short, focused note — keep each one small and add several rather than
   one long essay. If you want the note tied to a particular part of the page, you
   can attach it to a DOM element on that page.
5. Save. From then on, anyone with permission who visits that page can open the
   panel and read your note right where it applies.
