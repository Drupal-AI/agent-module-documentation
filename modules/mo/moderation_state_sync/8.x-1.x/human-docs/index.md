# Moderation State Sync — manual setup guide

**Moderation State Sync** (`moderation_state_sync`) keeps the Content Moderation
state aligned **between the translations of a node**. On a multilingual site, when
one translation of a node changes moderation state — for example moving to
Draft, Published, or Archived — the other translations follow, so your languages
never drift into inconsistent published/unpublished states.

A typical case: the moderation state is translatable for a bundle, and you want
the rule "if the source language becomes unpublished, all other languages become
unpublished too" so that things like sitemap inclusion stay consistent per node
across languages. The module depends only on core **Content Moderation** and
works across Drupal 8 through 11.

Setup is not a settings page — you enable syncing **per state, inside each
workflow's settings**. Because moderation state governs publish status (and
therefore visibility), syncing state deliberately publishes or unpublishes
translations together. That is the intended behavior, but it is worth
understanding before you turn it on. The module follows Content Moderation's own
access and plays no access-control role of its own. This guide folds the setup
into this page rather than a separate configuration chapter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **A note on release status:** this project is at an alpha release and is **not
> covered by Drupal's security advisory policy**. Test on a non-production
> environment first.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Content Moderation.

There is **no dedicated configuration page** for this module. You enable syncing
inside each workflow's settings, as described in "How to use it" below.

## Where it lives in the admin menu

Moderation State Sync adds no admin page of its own. You configure it on the core
workflow form at **Configuration → Workflow → Workflows → *(your workflow)*
→ Settings** (`/admin/config/workflow/workflows`).

## How to use it

1. Make sure your site is **multilingual** and uses core **Content Moderation**
   with the moderation state made **translatable** for the relevant bundle.
2. Go to **Configuration → Workflow → Workflows**
   (`/admin/config/workflow/workflows`) and edit the workflow you use.
3. In the workflow's **Workflow settings**, find the desired **states** and tick
   **Enable moderation state sync** for each state that should stay in sync across
   translations.
4. Save the workflow. From now on, when one translation of a node enters a
   sync-enabled state, the module aligns the other translations to match.

> **Remember:** because syncing changes publish status across languages, enabling
> it can publish or unpublish translations together. Confirm this is the behavior
> you want before turning it on for a live site.
