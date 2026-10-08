# Drutopia Landing Page — manual setup guide

> **This module is DEPRECATED.** Its maintainers recommend using the generic
> [Drutopia Page](../../drutopia_page/2.0.x/human-docs/index.md) feature instead.
> Do not choose it for a new build — the guidance below is here mainly for people
> maintaining or auditing an existing Drutopia site that still uses it.

**Drutopia Landing Page** (`drutopia_landing_page`) is a
[Drutopia](https://www.drupal.org/project/drutopia) feature that installs a
**Landing Page** content type for building standalone pages such as a home page
or a marketing page. It is a configuration-only module: enabling it imports a
`landing_page` node type together with a paragraph body field
(`field_body_paragraph`), a meta tags field, Display Suite form and view
displays (default, full, teaser), a Pathauto URL pattern, and a
promote-to-front-page override.

Because everything ships as default configuration and there is no custom code,
access to landing pages is governed entirely by core node permissions and the
displays it installs. The module builds on the wider Drutopia stack —
[`drutopia_core`](../../drutopia_core/2.0.x/human-docs/index.md) and
[`drutopia_seo`](../../drutopia_seo/2.0.x/human-docs/index.md) — plus Paragraphs,
Display Suite, Exclude Node Title, Metatag and Pathauto, so a landing page comes
pre-wired for paragraph-composed content and SEO metadata.

If you are starting fresh, use **Drutopia Page** instead, which provides an
equivalent paragraph-driven page type that is actively recommended.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (for legacy maintenance only).

## Where it lives in the admin menu

There is no settings form. The Landing Page content type appears under
**Structure → Content types** (`/admin/structure/types`), and you create landing
pages from **Content → Add content → Landing Page** (`/node/add/landing_page`).

## How to use it

Add a landing page, compose its body from paragraphs, and set its meta tags. The
Pathauto pattern generates the URL alias automatically, and the node title can be
hidden on the page via Exclude Node Title. When you are ready to move off this
deprecated type, plan a migration of existing landing pages to the Page type.
