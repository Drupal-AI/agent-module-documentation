# Drutopia Blog — manual setup guide

**Drutopia Blog** (`drutopia_blog`) is a base *feature* module from the
[Drutopia](https://www.drupal.org/project/drutopia) distribution. It installs a
ready-made **Blog** content type for personal, journal-style posts — a type kept
distinct from news articles — so bloggers can start posting immediately without
hand-building fields and displays.

Drutopia features are **config-only**: enabling the module installs bundled
configuration and adds no PHP routes, controllers, services or permissions of its
own. Turning it on creates the `blog` content type with a body, summary,
media image, author (people) references and topic tags, plus a shared
topics/tags classification vocabulary. It also installs form and view displays
(teaser, card, full and more), a Views-based blog listing with an "Add blog"
action link, a Pathauto URL pattern for clean aliases, Metatag SEO defaults, and
Search API indexing with facets so the listing can be filtered by topic. Where
comments are enabled it wires in commenting via drutopia_comment, and posts can
be added to menus via menu_ui.

Access is governed entirely by core node permissions and the Drutopia editorial
roles (contributor / editor / manager), which the feature augments through its
`config/actions`. Editors add content from the listing's "Add" action; site
builders can customise the installed configuration like any other content type.

It depends on **Drutopia Core** and a stack of related modules (Drutopia SEO,
People and Comment, Display Suite, Facets, Field Group, Paragraphs, Pathauto,
Metatag, Search API and Block Visibility Groups). See the
[Drutopia Core](../../drutopia_core/2.0.x/human-docs/index.md) guide for the
shared base it builds on. It is normally installed as part of a Drutopia site
rather than on its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   feature and its dependencies.

There is **no dedicated configuration page** for this module — it ships
configuration rather than a settings form. You manage what it installs through
the normal content-type, field, display, Views and taxonomy admin, exactly as you
would any other content type.

## Where it lives in the admin menu

Drutopia Blog adds no settings page of its own. After enabling it you'll find:

- **The blog listing** — a Views page carrying an **Add blog** action link (also
  reachable at **Content → Add content → Blog**, `/node/add/blog`).
- **The content type** — **Structure → Content types → Blog**
  (`/admin/structure/types/manage/blog`), where its fields, form display and view
  displays live.

## How to use it

Once enabled, an editor with the appropriate Drutopia role adds a Blog post from
the listing's "Add blog" link or from **Content → Add content → Blog**, fills in
the body, summary, image, author and topic fields, and publishes. The post then
appears in the faceted blog listing, is indexed for site search, and gets an
SEO-friendly URL and metadata automatically. Site builders who want to change the
fields or displays edit the `blog` content type like any other.
