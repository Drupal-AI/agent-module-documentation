# Moderation State Condition — manual setup guide

**Moderation State Condition** (`moderation_state_condition`) provides a Drupal
**condition plugin** based on content-moderation states. Anywhere Drupal uses its
condition system — most commonly block visibility — you can now show or hide
something depending on the current entity's moderation state: Draft, Published,
Archived, or any custom state in your workflow.

The classic use is a block that appears only in certain editorial states — an "in
review" banner that shows only on draft content, or a call-to-action block that
appears only once content is published. It depends on core **Workflows** and
**Content Moderation** and works on Drupal 10 and 11.

One important distinction: this module governs **display**, not access. It decides
*where things appear* based on moderation state; it does not control who may view
the underlying content. Access to moderated content is still governed by Content
Moderation's own permissions. There is no settings page of its own — you use the
condition wherever Drupal exposes conditions, so this guide folds the setup into
this page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Workflows and Content Moderation.

There is **no configuration page** for this module. You apply the condition
wherever Drupal conditions are used, as described in "How to use it" below.

## Where it lives in the admin menu

Moderation State Condition adds no admin settings page of its own. It appears as a
condition option inside condition-aware UIs — most notably the block placement
form at **Structure → Block layout** (`/admin/structure/block`).

## How to use it

The most common place to use it is block visibility:

1. Make sure your site uses core **Content Moderation** with a workflow applied
   to the relevant content.
2. Go to **Structure → Block layout** (`/admin/structure/block`) and place (or
   configure) a block.
3. In the block's configuration, open the **Visibility** settings. You will find
   a condition for the **moderation state**.
4. Select the workflow state(s) in which the block should appear (for example,
   only in *Draft*, or only in *Published*), and save the block.

The block now shows or hides according to the moderation state of the content
being viewed. Any other feature that consumes Drupal's condition system can use
this condition the same way.
