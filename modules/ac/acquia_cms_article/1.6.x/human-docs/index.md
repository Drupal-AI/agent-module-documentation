# Acquia CMS Article — manual setup guide

**Acquia CMS Article** (`acquia_cms_article`) ships a ready-made **Article
content type** — the blog/news post — with its fields, form display, view
displays, pathauto pattern, and metatag defaults already built. Enable it and
the Article type exists, editor-ready, without a site builder assembling any of
it by hand.

It is one small piece of **Acquia CMS**, Acquia's Drupal distribution, which is
assembled from single-purpose modules like this one. The value and the
limitation are the same fact: this is *distribution configuration, not a generic
feature*. It encodes Acquia's opinions about what an Article should be, and it is
designed to sit alongside the rest of the Acquia CMS family and share their
common layer (`acquia_cms_common`). On an Acquia CMS site it is exactly right; on
an unrelated site it is a strong set of assumptions to take on — usable as a
starting point, but you inherit the whole model, and it expects its siblings to
be present. Enabling it pulls in `acquia_cms_person` (and, through it, the rest
of the chain).

Because it is configuration, what it does is fixed by that config: it creates the
Article content type and wires its displays. Extending it means adding fields and
adjusting displays as you would with any content type, and it travels with a
config export like any other content-type configuration. There is no settings
form of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the dependency chain it brings with it).

## Where it lives in the admin menu

This module has no configuration page of its own. Once enabled it adds an
**Article** content type, which you'll find in the usual core locations:

- **Content → Add content → Article** (`/node/add/article`) to author a post.
- **Structure → Content types → Article** (`/admin/structure/types/manage/article`)
  to review or extend its fields, form display, and view displays.

## How to use it

Editors create Articles from **Content → Add content → Article** and fill in the
pre-built fields. If you need to change the model — add a field, reorder the form,
adjust a view mode — do it on the Article content type under **Structure →
Content types** exactly as you would for any Drupal content type; your changes
export with the rest of your site configuration.
