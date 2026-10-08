# JSON Feed — manual setup guide

**JSON Feed** (`json_feed`) lets you publish any View as a
[JSON Feed 1.0](https://jsonfeed.org/) endpoint — a modern, machine-readable
alternative (or companion) to RSS and Atom. Feed readers, apps, and decoupled
front-ends that speak JSON Feed can then subscribe to your content as clean JSON
instead of XML.

It works by adding three plugins to Views: a **display** ("JSON Feed") that serves
a JSON response at a path you choose and can attach to another display; a **style**
that assembles the top-level feed object (title, description, home page URL, author,
paging, and so on); and a **row** that maps each of your View's fields to a JSON
Feed item attribute such as `id`, `url`, `title`, `content_html`, `image`, or
`date_published`. Because it is built entirely on Views, there is no separate
settings page — you configure everything on the View itself.

When you attach the JSON feed to a normal page display, the module also adds an
`alternate` link tag and a clickable feed icon to that page, so browsers and
readers can auto-discover the feed. It requires only core's **Views** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add a JSON Feed display to a View and
   map your fields to feed attributes.

## Where it lives in the admin menu

There is no dedicated settings page. Everything happens inside the Views UI at
**Structure → Views** (`/admin/structure/views`) when you add or edit a View.
