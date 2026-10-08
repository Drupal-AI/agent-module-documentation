# Search Exclude — manual setup guide

**Search Exclude** (`search_exclude`) lets you keep whole content types out of Drupal's
core search index entirely. Core's own Search module indexes every node type and only
lets you *filter* by type when someone runs a search; Search Exclude goes further and
stops the excluded types from ever entering the index in the first place — so they never
appear in results, never bloat the index, and never slow down cron indexing.

It works by adding one new search plugin called **Content (Exclude)**, a drop-in
replacement for core's "Content" search that carries an extra *Exclude content types*
checkbox group. Because it is a search plugin rather than a settings page, you use it by
creating a **new search page** that runs this plugin, ticking the content types you want
gone, and then making that page your site's default search. The module depends only on
core's **Search** module, and it ships no permissions, Drush commands or configuration
object of its own — the exclusion list is stored on the search page you create.

Editing an excluded type never dirties the index, and the *Search pages* admin screen
reports honest "n of m indexed" progress against the reduced total. If you use Search API
or Solr instead of core Search, note that this module only affects **core** Search.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — create the "Content (Exclude)" search page,
   tick the content types to exclude, and make it the default.

## Where it lives in the admin menu

Search Exclude adds no menu item of its own. You work with it on the core **Search pages**
screen at **Configuration → Search and metadata → Search pages**
(`/admin/config/search/pages`), where its **Content (Exclude)** plugin appears as a
choice when you add a new search page.
