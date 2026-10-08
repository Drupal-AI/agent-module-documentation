# Timeline Block — manual setup guide

**Timeline Block** (`timeline_block`) lets you build a chronological timeline
straight from a block's configuration form and drop it anywhere on your site. Each
entry has a time/phase, a title, and a description (with image support), and the
block renders them as a visual sequence of events in chronological order. It ships
**10 predefined layouts**, and both the CSS and the Twig template can be overridden
in your theme for a fully custom design.

Some content is only legible as a sequence — an organisation's history, a project's
milestones, a legal case's chronology, a product's release history, a conference
programme. Presented as a list of dated paragraphs each reads as plain text;
presented as a timeline, the *shape* of it — the gaps, the clusters, the direction —
is visible at a glance. That is a genuine information-design gain rather than mere
decoration.

A few things are worth thinking about before you commit. Because entries are stored
**in the block configuration**, they are effectively content living in
configuration: quick to set up, but invisible to search and to editorial workflow,
and edited in a place content authors do not usually look. If your timeline needs to
stay current from real content, a view of dated nodes is often the better fit; use
Timeline Block when you want a self-contained, hand-curated timeline in a specific
spot. Keep accessibility in mind too — a timeline is fundamentally a *list* of dated
items, and horizontal timelines are hard to follow on narrow phone screens, so
favour a layout that reads top-to-bottom on mobile.

The module depends only on core's **Block** module and works on Drupal 9, 10, and
11. There is no central settings page — everything is configured on the block
itself. Note that this release is not covered by drupal.org's security-advisory
policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Timeline Block has no admin settings page; you create a timeline by placing and
configuring a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`) and click
   **Place block** in the region you want.
2. Choose the **Timeline Block**.
3. In the block form, add your timeline entries — each with a **time/phase**, a
   **title**, a **description**, and optionally an **image**. A weight/order select
   lets you control the sequence of entries.
4. Pick one of the **10 predefined layouts**, then save.

To customise the look further, copy the module's
`templates/timeline-block.html.twig` into your theme and adjust the markup and CSS.
The template exposes `timeline_data` (each entry's `time`, `title`, and
`description`), plus `timeline_settings` and `timeline_layout`, so you can build
your own layout or wire in custom JavaScript.
