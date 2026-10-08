# Automatic Anchors — manual setup guide

**Automatic Anchors** (`auto_anchors`) generates `id` attributes on chosen
elements — usually headings — so any section of a page can be linked to
directly. A WYSIWYG editor produces `<h2>Refunds</h2>` with no attributes, and
nothing puts an anchor there on its own; this module derives one from the heading
text, making every heading on the site addressable.

A deep link into a document is one of the most useful things a site can offer and
one of the least often provided. Support staff want to send a customer to the
right paragraph of a policy rather than the top of a five-thousand-word page;
documentation cross-references a specific step; a table of contents needs targets
to point at. All of that needs an `id` on the heading, and generating those
automatically is what this module does.

Two things determine whether the links keep working, and both are about
**stability**. An id derived from heading text **changes when the heading is
edited**, so a link anyone shared to the old text can break silently — for
long-lived content, prefer a stable derivation, or keep old ids alongside new
ones. And **ids must be unique on the page**: two sections called "Overview"
collide, and the deduplication rule (usually a numeric suffix) means which one a
link lands on depends on document order — so inserting a new section can quietly
redirect an existing link.

The current release is `3.0.0-beta1`, a **beta**, on Drupal 10.1 or 11. It adds a
`show automatic anchor links` permission (for showing the visible permalink
control) and an `administer automatic anchors` permission, marked as restricted
access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling, configure the module through its settings (config object
`auto_anchors.settings`), which decide which elements get `id` attributes.
Because those settings can change how content is rendered, the settings form is
gated by the `administer automatic anchors` permission (restricted access). If
you want the visible "permalink" control shown next to anchored headings, grant
the `show automatic anchor links` permission to the appropriate roles at
**People → Permissions** (`/admin/people/permissions`). Keep the two stability
caveats above in mind for any content whose links need to stay valid over time.
