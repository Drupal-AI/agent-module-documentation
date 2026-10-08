# Drutopia Article — manual setup guide

**Drutopia Article** (`drutopia_article`) is a base *feature* module from the
[Drutopia](https://www.drupal.org/project/drutopia) distribution. It installs a
ready-made, SEO-aware **Article** content type for time-sensitive content such as
news, press releases and blog-style posts — so you don't have to hand-build the
fields, displays and supporting configuration yourself.

Drutopia features are **config-only**: enabling the module installs bundled
configuration and adds no PHP routes, controllers, services or permissions of its
own. Turning it on creates the `article` content type with a body, summary,
image/media (with focal-point cropping), author (people) references and topic
tags, plus an `article_type` classification vocabulary. It also installs form and
view displays (teaser, card, box, full, RSS and more), a Views-based article
listing with an "Add article" action link, a Pathauto URL pattern for clean
aliases, Metatag/RDF SEO defaults, and Search API indexing with facets so the
listing can be filtered by type and topic. Where comments are enabled it wires in
commenting via drutopia_comment.

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

Drutopia Article adds no settings page of its own. After enabling it you'll find:

- **New articles** — the article listing view, which carries an **Add article**
  action link (also reachable at **Content → Add content → Article**,
  `/node/add/article`).
- **The content type** — **Structure → Content types → Article**
  (`/admin/structure/types/manage/article`), where its fields, form display and
  view displays live.
- **The vocabulary** — **Structure → Taxonomy → Article type**
  (`/admin/structure/taxonomy`), for the `article_type` classification terms.

## How to use it

Once enabled, an editor with the appropriate Drutopia role simply adds an Article
from the listing's "Add article" link or from **Content → Add content →
Article**, fills in the body, summary, image, author and topic fields, and
publishes. The article then appears in the faceted listing, is indexed for site
search, and gets an SEO-friendly URL and metadata automatically. Site builders
who want to change the fields or displays edit the `article` content type like any
other.
