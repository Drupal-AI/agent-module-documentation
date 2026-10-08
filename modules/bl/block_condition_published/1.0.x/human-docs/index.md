# Block Condition Published — manual setup guide

**Block Condition Published** (`block_condition_published`) adds a block visibility
condition based on whether the entity being viewed is **published**. So you can show
or hide a block depending on the publication status of the page it appears on.

Core's block visibility conditions cover paths, content types, roles, languages, and
the front page — but not publication status, which turns out to be a real gap once a
site has an editorial workflow. This module fills it. Typical uses: a "this page is a
draft" notice shown only on unpublished content; social sharing buttons hidden on
something not yet public; an editorial toolbar useful only while reviewing; a "last
updated" notice that's right on published pages but misleading on drafts. Without
this condition, the alternatives are a preprocess function checking status, a
duplicated block with path conditions that go stale, or showing the block everywhere
and accepting that it's sometimes wrong.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** the current release is a beta (1.0.0-beta1). Test it before relying on it
> in production.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no separate settings page. The published-status condition appears on the
block's own configuration form under **Structure → Block layout**
(`/admin/structure/block`), alongside the other visibility conditions.

## How to use it

1. Go to **Structure → Block layout** and edit (or place) a block.
2. In the block's visibility settings, use the **published** condition to show or
   hide the block based on whether the viewed entity is published.
3. Save the block.

### Two things to keep straight

- **A visibility condition is presentation, not access.** A block hidden on
  unpublished content is genuinely not rendered — but that says nothing about whether
  the visitor should be able to see the unpublished entity at all. Protecting the
  entity itself is **entity access's** job. Never treat this condition as a way to
  protect anything.
- **The condition varies by the current entity's publication status**, which affects
  caching. If the block's cacheability doesn't vary by that entity, the first
  rendering can be reused — and the visible failure is the embarrassing kind, such as
  a draft notice cached onto a published page. Make sure the block's cache varies
  correctly.
