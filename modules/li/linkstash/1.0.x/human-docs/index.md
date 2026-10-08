# LinkStash — manual setup guide

**LinkStash** (`linkstash`) is a personal bookmarking tool for Drupal 11. Each
user "stashes" links, and LinkStash automatically fetches each link's **title,
description, and thumbnail**, sorts it into a category based on its domain, and —
for video URLs — embeds a responsive player. It's a private, self-hosted
alternative to a browser's bookmarks or a third-party read-later service.

Links are per-user: everyone has full create/read/update/delete control over
their own stash, with access control keeping one person's bookmarks private from
another's. You can save a link from a form at `/linkstash/add`, or install the
included **browser bookmarklet** for one-click saving from any page you're
visiting. Smart auto-categorisation ships with built-in domain rules (Video,
Code, Social, Articles, Documentation), and list/detail views give you exposed
filters for tags, categories, status, and domain so you can find things again.

Because metadata fetching means the site makes a request to whatever URL you
save, LinkStash includes **SSRF protection** (blocking private/RFC 1918
addresses) and XSS-safe rendering. It's built on core's Link, Image, Taxonomy,
Text, and Views modules.

One thing to note: at the documented version LinkStash is a **beta**
("production testing") release and is **not covered** by Drupal's security
advisory policy, so test it before trusting it with anything important.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable, and
   grant the per-user permissions.
2. [Configuration](configuration/index.md) — module settings, tags/categories,
   field display, and the bookmarklet.

## Where it lives in the admin menu

- **Module settings:** **Structure → LinkStash → Settings**
  (`/admin/structure/linkstash/settings`).
- **Field display:** `/admin/structure/linkstash/display`.
- **Tags vocabulary:** `/admin/structure/taxonomy/manage/linkstash_tags`.
- **Categories vocabulary:** `/admin/structure/taxonomy/manage/linkstash_category`.
- **Your bookmarks:** `/linkstash` (browse), `/linkstash/add` (save a link),
  `/linkstash/bookmarklet` (install the bookmarklet).

## How to use it

1. After installing and granting permissions (see Installation), visit
   `/linkstash/bookmarklet` and drag the bookmarklet to your browser's toolbar.
2. On any page you want to keep, click the bookmarklet — or go to
   `/linkstash/add` and paste a URL. LinkStash fetches the title, description,
   and thumbnail automatically and files it under a category based on its domain.
3. Browse and search your collection at `/linkstash`, using the exposed filters
   for tags, categories, status, and domain. Video links show an embedded,
   responsive player in the detail view.
