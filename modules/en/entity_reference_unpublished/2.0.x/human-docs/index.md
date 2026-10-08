# Entity Reference Unpublished — manual setup guide

**Entity Reference Unpublished** (`entity_reference_unpublished`) lets an entity
reference field point at **unpublished** content. Out of the box, Drupal's reference
fields only show *published* nodes, media, and taxonomy terms in their autocomplete
and select lists (unless the user has permission to bypass access checks), which
means you can't link to a draft that hasn't gone live yet. This module adds
alternative selection handlers that skip the "published only" rule, so drafts become
selectable.

It ships three handlers — one for **nodes**, one for **media**, and one for
**taxonomy terms**. You don't turn these on globally; instead you pick the matching
**Reference method** on a specific reference field, so you only relax the published
filter where you actually want it. Every other reference field keeps the standard
published-only behavior.

This is handy whenever content needs to be wired together *before* it goes live — a
"related articles" field pointing at scheduled drafts, a curated landing page built
ahead of launch, or hierarchical content where parents and children are edited in
tandem.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Entity Reference Unpublished has **no settings page of its own** and adds no
permissions. You use it on individual reference fields, under **Structure → (an
entity type) → Manage fields → (your reference field)**.

## How to use it

1. Go to the field you want to change — for example **Structure → Content types →
   *(a type)* → Manage fields**, and edit an existing entity reference field (or add
   a new one whose target is nodes, media, or taxonomy terms).
2. On the field's settings form, find **Reference type → Reference method** and choose
   the matching option:
   - **Unpublished Default** — for fields that reference **nodes** (handler
     `unpublished`).
   - **Unpublished Media** — for fields that reference **media** (handler
     `unpublished_media`).
   - **Unpublished Taxonomy term** — for fields that reference **taxonomy terms**
     (handler `unpublished_taxonomy_term`).
3. Optionally restrict which bundles can be referenced (the module relabels this to
   "Content types" / "Media types" / "Vocabularies" depending on the target).
4. Save. From now on the field's autocomplete or select list will include unpublished
   entities of the chosen bundles, so editors can reference drafts.

If you configure fields as code, this simply sets the field config's
`settings.handler` to `unpublished`, `unpublished_media`, or
`unpublished_taxonomy_term` — the target entity type of the field must match the
handler you pick.
