# Fragments — manual setup guide

**Fragments** (`fragments`) provides a content entity type for **reusable pieces of
content** — a fielded, bundleable thing that exists to be referenced from several
places at once. Think of the "tips" that appear across many pages, a shared
disclaimer, a call‑to‑action reused between nodes, or a set of locations shown in a
table: content you want to maintain in one place and have update everywhere it
appears.

Drupal already offers three near‑misses for this, and each is a compromise.
**Block content** is reusable but its placement lives in the block layout system, so
positioning becomes configuration rather than content. **Paragraphs** are fielded and
composable but are owned by their host entity and revisioned with it, which makes
genuine reuse across nodes awkward. **Nodes** are reusable but carry a URL, a listing
presence, and a whole publishing apparatus you may not want. Fragments is a fourth
option: fielded like a paragraph, independent like a node, and invisible (no route of
its own) like a block. Fragments are fieldable and revisionable, and you define as
many **fragment types** (bundles) as you need.

Two things are worth settling before you adopt it. First, **where a fragment's
access comes from**: an entity with no route still renders inside other entities, so
decide whether an unpublished fragment inside a published node should be visible, and
check that any JSON:API or search consumers agree. Second, **reuse is both the point
and the failure mode**: editing a fragment changes it everywhere it appears, so give
editors a way to see what references a fragment before they change it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module, plus a few recommended companions.
2. [Configuration](configuration/index.md) — creating fragment types, adding fields,
   and setting up permissions.

## Where it lives in the admin menu

Fragment types are managed at **Structure → Fragment types**
(`/admin/structure/fragment_type`, route `entity.fragment_type.collection`). That's
where you add bundles and their fields. See
[Configuration](configuration/index.md).

## How to use it

Once you've defined at least one fragment type and added fields to it
(see [Configuration](configuration/index.md)), the day‑to‑day flow is:

1. **Create fragments** — add fragment content of your defined type(s) and fill in
   the fields (for example a title and body for a "Tip").
2. **Reference them** — add an **entity reference** field (targeting fragments) on
   the content that should display them — a node, a paragraph, or another entity —
   and pick the fragment(s) to show. Configure that field's display formatter to
   render the referenced fragment.
3. **Maintain in one place** — edit the fragment once and every place that references
   it reflects the change.

> **Tip:** With the **Inline Entity Form** module you can create a new fragment right
> inside the form where you reference it, which is far more convenient than jumping
> to a separate screen — see the recommended modules in
> [Installation](installation/index.md).
