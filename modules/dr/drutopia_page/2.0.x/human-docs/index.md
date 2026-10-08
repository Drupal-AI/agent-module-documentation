# Drutopia Page — manual setup guide

**Drutopia Page** (`drutopia_page`) is a base feature of the
[Drutopia](https://www.drupal.org/project/drutopia) distribution that installs a
ready-made Basic **Page** content type for static content — an About-us page, a
policy page, or any standalone page. Enable it and you get a `page` node type
with a body field, a separate summary field, a paragraph body field
(`field_body_paragraph`), a meta tags field, Display Suite form and view
displays (default, full, teaser), an RDF mapping and a Pathauto URL pattern.

Alongside the content model, the feature grants page create and edit permissions
to the Drutopia editorial roles — **contributor** (create and edit own pages),
**editor** and **manager** (create and edit any page) — through its config
actions, so an editorial team can start managing pages immediately. Everything ships as configuration; there is no custom code,
and security posture is entirely that of the standard node and permissions
system plus the role grants above.

It depends on the wider Drutopia stack —
[`drutopia_core`](../../drutopia_core/2.0.x/human-docs/index.md) and
[`drutopia_seo`](../../drutopia_seo/2.0.x/human-docs/index.md) — plus Display
Suite, Paragraphs, Entity Reference Revisions, Metatag, Pathauto and Token. It is
also the foundation for
[`drutopia_storyline`](../../drutopia_storyline/2.0.x/human-docs/index.md), whose
submodule can add a timeline field to pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Drutopia dependencies.

## Where it lives in the admin menu

There is no settings form. The Page content type appears under **Structure →
Content types** (`/admin/structure/types`); create pages from **Content → Add
content → Page** (`/node/add/page`). The role permissions it grants can be
reviewed at **People → Permissions** (`/admin/people/permissions`).

## How to use it

Add a page, write its body and summary, optionally compose richer content from
paragraphs, and set its meta tags. Pathauto generates the URL alias
automatically. Extend the type with extra fields, adjust the Display Suite
layouts, or tune the `node_page` Pathauto pattern to match your URL scheme as
needed.
