# Site Meta — manual setup guide

**Site Meta** (`sitemeta`) is a small, focused way to set page meta tags — the
page title, description and keywords — for nodes, Views and other pages. Each rule
is stored as a configurable **Site meta** entity, and the values can be built from
core **tokens**, so a description can pull from a field rather than being typed out
by hand. It also adds a Custom Meta tab to the node edit form so you can override
the meta for an individual node.

The problem it solves is basic on‑page SEO without the weight of a large module.
The dominant module in this space is `metatag`, which is comprehensive and
well‑maintained but correspondingly large — tag groups, per‑bundle defaults, Open
Graph, Twitter cards, Schema.org and a substantial configuration surface. Not
every site needs all of that. If your SEO requirement is exactly "set a good title
and description," Site Meta does that job with a much smaller footprint.

Two things are worth deciding before you choose it over the obvious alternative.
First, **what it covers**: it handles titles, descriptions and keywords — not Open
Graph or Twitter cards. Any site that gets shared on social media eventually wants
those, at which point you would install `metatag` anyway. Running both at once
means two systems writing to the same `<head>` with no arbitration, which produces
duplicate tags that search engines handle unpredictably — so pick one. Second,
**tokens versus literal values** decides whether it scales: a separate rule per
page becomes unmanageable past a few dozen, whereas a token‑driven rule per content
type is one rule covering a thousand nodes. The `token` dependency suggests
per‑bundle, token‑driven rules are the intended way to use it.

It works once enabled — there is no central settings form; you manage the rules as
content. It depends on core **Token** (`token`) and provides two permissions of its
own. Version 8.x‑1.7 runs on Drupal 9.3, 10 and 11.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with Token).

## Where it lives in the admin menu

Site meta rules are managed under **Content → Site meta**. That page lists every
Site meta rule currently active on the site.

## How to use it

1. Go to **Content → Site meta** to see the list of active Site meta rules.
2. Click **Add Sitemeta** to create a new meta rule for a page, and set its title,
   description and keywords — using tokens where you want the value to come from a
   field (for example a per‑content‑type description built from the body summary).
3. Edit an existing rule with its **Edit** action.
4. To override the meta for a single node, edit that node and open the **Custom
   Meta** tab under the *Advanced* section of the node edit form, where you can set
   a custom meta just for that node.

Access is governed by two permissions: **add site meta entities**
(`add site meta entities`) and **administer site meta entities**
(`administer site meta entities`). Grant them to the roles that manage SEO.
