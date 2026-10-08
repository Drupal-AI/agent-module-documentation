# Content Moderation Reviewer — manual setup guide

**Content Moderation Reviewer** (`content_moderation_reviewer`) extends Drupal
core's Content Moderation so you can say *who* should review a given piece of
content, not just what state it is in. On complex editorial workflows it is easy
to move a page into a "Needs review" state and then have nobody actually know
they are responsible for it. This module attaches a reviewer directly to the
moderation workflow, making editorial accountability explicit.

Once enabled, every content bundle that has a Content Moderation workflow applied
to it automatically gains a **Moderation reviewer** field. That field appears on
the node edit form right under the **Moderation state** dropdown provided by core
Content Moderation. It's an autocomplete field: as you pick a moderation state,
the list of selectable reviewers updates over AJAX to show only users who have
access to transition *from* the state you chose — so you can only assign someone
who is actually able to act on the content at that point.

There is nothing to configure on a settings page — the reviewer field is added
automatically to moderated bundles, so the module starts working as soon as it is
enabled and a workflow is in place. It builds on core's **Workflows** and
**Content Moderation** modules and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** This release is an alpha (2.0.0-alpha5) and the project is not covered
> by Drupal's security advisory policy. Evaluate it carefully before relying on it
> in production.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — the reviewer field is added
automatically to any bundle that uses a Content Moderation workflow. See "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin settings page. Its effect shows up on **node add/edit
forms** for moderated content: a **Moderation reviewer** autocomplete field sits
just below the Moderation state dropdown.

## How to use it

1. Make sure a **Content Moderation** workflow exists (**Configuration →
   Workflow → Workflows**) and is applied to the content types you want to track
   reviewers for.
2. Edit a piece of content of one of those types. Below the **Moderation state**
   dropdown you'll see the new **Moderation reviewer** field.
3. Choose the target moderation state, then start typing a user's name in the
   reviewer autocomplete. The list is filtered to users who can act on the
   content from that state — change the state and the list refreshes.
4. Save. The chosen reviewer is now recorded as the person responsible for
   reviewing that content at its current stage.
