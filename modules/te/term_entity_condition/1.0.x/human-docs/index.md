# Term Entity Condition — manual setup guide

**Term Entity Condition** (`term_entity_condition`) provides a block *visibility
condition* that shows or hides a block based on the taxonomy terms of the entity
currently being viewed. In plain terms: you can place a block so it appears only
on content tagged with a particular term — for example, show a "Latest news"
promo only on nodes tagged *News*.

Drupal's block layout already lets you scope blocks by path, content type, role
and so on, but out of the box there is no clean way to say "only when the current
page's content references this taxonomy term." This module adds exactly that
condition, and like other block conditions it can be **negated** — so you can just
as easily say "everywhere *except* content tagged with this term."

An important distinction: this controls block **visibility (presentation)**, not
access. It decides whether the block is *rendered on the page*, not who is allowed
to see the block's underlying content — it has no access‑control role. If you need
to genuinely restrict access to content, use Drupal's permissions and access
systems, not a visibility condition.

The module works as soon as it is enabled — there is nothing to configure
globally. You use it per block, on the block's configuration form. It depends on
core **Taxonomy** (`taxonomy`), supports **Drupal 10 and 11**, ships no
submodules, and provides no permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once the module is enabled, the condition appears on the visibility settings of
any block:

1. Go to **Structure → Block layout** (`/admin/structure/block`) and either place
   a new block or edit an existing one.
2. On the block configuration form, find the new **taxonomy term** visibility
   condition among the other conditions (path, content type, and so on).
3. Choose the term(s) for which the block should appear. Tick the *Negate the
   condition* option if you instead want the block to appear everywhere except on
   content with those terms.
4. Save the block.

The block will now render only on the canonical pages of content whose terms
match your condition (or everywhere else, if you negated it).
