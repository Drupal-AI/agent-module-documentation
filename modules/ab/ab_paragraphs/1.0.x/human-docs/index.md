# A/B Paragraphs — manual setup guide

**A/B Paragraphs** (`ab_paragraphs`) adds a special "A/B test" paragraph type so
you can run lightweight content experiments directly inside Drupal, without
signing up for a full experimentation platform. An editor authors two or more
variants of a block of content, and the front end shows one variant per visitor.

The choice is **session-based**: each visitor is assigned a variant for the
duration of their browsing session, so the same person keeps seeing the same
version as they move around the site. This makes it a good fit for trying two
headlines, two call-to-action blocks, or two layouts against each other and
seeing which performs better, all as ordinary Drupal content.

Because the variants are just authored content and the selection is decided per
session, there is nothing here that controls who can access a page — this is a
content-editing and engagement feature, not an access-control one. The only
thing to keep in mind is that assigning a variant per session touches the
visitor's session (a minor cookie/privacy consideration).

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once the module is enabled, the A/B test paragraph type becomes available
wherever you use Paragraphs. Add it to a paragraph-reference field on your
content type, then, when editing content, add an A/B test paragraph and author
each variant inside it. On the front end the module picks one variant per visitor
session and shows only that one. There is no separate site-wide settings page —
you configure each experiment by editing the variants on the content itself.
