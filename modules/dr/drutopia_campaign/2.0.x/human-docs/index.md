# Drutopia Campaign — manual setup guide

**Drutopia Campaign** (`drutopia_campaign`) is a base *feature* module from the
[Drutopia](https://www.drupal.org/project/drutopia) distribution. It installs a
ready-made **Campaign** content type for grassroots and advocacy sites — a
campaign page is a central place to explain an issue, publish news about its
activity, list out demands, post calls to action and raise funds.

Drutopia features are **config-only**: enabling the module installs bundled
configuration and adds no PHP routes, controllers, services or permissions of its
own. Turning it on creates the `campaign` content type with background/body
fields, the ability to list demands and updates, a responsive hero image/media,
and a `campaign_type` classification vocabulary. It also installs form and view
displays (teaser, card, full and more), a Views-based campaign listing with an
"Add campaign" action link, a Pathauto URL pattern for clean aliases, Metatag SEO
defaults, and Search API indexing with facets so the listing can be filtered by
type. Campaign bodies can be composed with Paragraphs, and pages can be added to
menus via menu_ui.

Access is governed entirely by core node permissions and the Drutopia editorial
roles (contributor / editor / manager), which the feature augments through its
`config/actions`. Editors add content from the listing's "Add" action; site
builders can customise the installed configuration like any other content type.

It depends on **Drutopia Core** and a stack of related modules (Drutopia SEO,
Display Suite, Facets, Field Group, Paragraphs, Pathauto, Metatag, Search API and
Block Visibility Groups). See the
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

Drutopia Campaign adds no settings page of its own. After enabling it you'll
find:

- **The campaign listing** — a Views page carrying an **Add campaign** action
  link (also reachable at **Content → Add content → Campaign**,
  `/node/add/campaign`).
- **The content type** — **Structure → Content types → Campaign**
  (`/admin/structure/types/manage/campaign`), where its fields, form display and
  view displays live.
- **The vocabulary** — **Structure → Taxonomy → Campaign type**
  (`/admin/structure/taxonomy`), for the `campaign_type` classification terms.

## How to use it

Once enabled, an editor with the appropriate Drutopia role adds a Campaign from
the listing's "Add campaign" link or from **Content → Add content → Campaign**,
explains the issue in the body, lists demands and updates, adds a hero image and
publishes. The campaign then appears in the faceted listing, is indexed for site
search, and gets an SEO-friendly URL and metadata automatically. Site builders
who want to change the fields or displays edit the `campaign` content type like
any other.
