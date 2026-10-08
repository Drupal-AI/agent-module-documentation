# Hold My Draft — manual setup guide

**Hold My Draft** (`hold_my_draft`) solves a familiar content‑moderation
headache. Imagine a page with a published revision and several forward drafts —
work in progress, waiting on approval. Then someone spots a typo on the *published*
page. With core revisions alone, fixing it means either losing the in‑progress
draft work or publishing it before it's ready.

Hold My Draft lets an editor **"hold" the latest revision (draft)** — freezing the
forward drafts so they can safely edit the published revision, then **restore the
held drafts** to the top of the revision list and carry on. In short: pause the
draft, fix what's live, resume the draft.

A draft‑hold is initiated from a node's **Revisions** tab. The module ships
**separate permissions** for *starting* a hold and for *completing* (releasing)
one, so you can decide which roles do which. It depends on core **Node** and
**Content Moderation**, and runs on Drupal 10 and 11. It has no settings form —
the whole workflow lives on the Revisions tab, gated by those permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant its permissions.

There is **no configuration page** for this module — it has no settings form. The
only setup beyond enabling it is granting the start/complete permissions,
described below.

## Where it lives in the admin menu

Hold My Draft adds no admin settings page. You use it from a node's **Revisions**
tab (`/node/{id}/revisions`), where the draft‑hold actions appear for users who
have the relevant permission.

## How to use it

1. Make sure the content type uses **Content Moderation** (an editorial workflow
   with draft and published states) — Hold My Draft builds on it.
2. Grant the module's permissions (start and complete draft‑holds) to the
   appropriate roles at **People → Permissions**.
3. When you need to correct the published version while drafts are pending, open
   the node's **Revisions** tab and **start a draft‑hold**. This pauses the
   forward drafts.
4. Edit and save the published revision as needed.
5. Back on the **Revisions** tab, **complete (release) the hold** to restore the
   drafts to the top of the revision list, and resume editing them.
