# Metatag — manual setup guide

**Metatag** (`metatag`) gives you full control over the HTML `<meta>` and `<link>`
tags Drupal outputs in every page's `<head>` — the page title, description, canonical
URL, `robots` directives, Open Graph tags, Twitter Cards, and hundreds more. Instead
of hard‑coding these into a theme, you configure them once as reusable **default meta
tags** and let Drupal fill in the values automatically for each page.

The power comes from two ideas working together. First, **tokens**: a value like
`[current-page:title] | [site:name]` pulls the real title and site name in at render
time, so one setting covers your whole site. Second, **per‑entity defaults and
inheritance**: you set tags globally, then refine them for a specific entity type or
content type, and editors can still override them on an individual node, term, or user.
Values flow from Global → entity type → bundle → the individual entity, with the most
specific value winning. This guide is written for a **human** clicking through the
admin UI; if you want terse, token‑cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

![The Metatag defaults list showing Global, Front page, Content, Taxonomy term and other rows](images/defaults.png)

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and add the submodules (Open Graph, Twitter Cards, …) you need.
2. [Configuration](configuration/index.md) — the module Settings page: value
   separator and which tag groups appear on which entity types.
3. [Managing defaults](managing-defaults/index.md) — edit the Global defaults with
   tokens and add per‑entity‑type defaults.

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Search and metadata → Metatag**:

- Default meta tags: **Metatag** (`/admin/config/search/metatag`)
- Module settings: the **Settings** tab (`/admin/config/search/metatag/settings`)
- Edit one default: `/admin/config/search/metatag/{id}` (e.g. `.../global`)
