# /llms.txt — manual setup guide

**/llms.txt** (`llms_txt`) serves a dynamic **`/llms.txt`** file for your site — a
Markdown "homepage for LLMs." The `llms.txt` convention is an emerging standard,
alongside `robots.txt` and `sitemap.xml`, for giving AI agents and crawlers a
concise, machine-readable summary of what a site offers and where the important
content lives. This module lets you author and edit that file from the Drupal
admin instead of maintaining a static file by hand.

The published `/llms.txt` is assembled from two sources, in order. First comes a
**config body** — a block of Markdown you edit on the module's config form that
supports tokens (core tokens like `[site:name]` and `[site:slogan]`, plus the
module's own menu tokens). After that come any published **sections**, which are
small content entities (a title plus a Markdown body) that you add, edit, and
reorder in the admin. This split is deliberate: the generic top matter lives in
exportable configuration (stays in code), while environment-specific sections
live in the database (so staging vs. production notes don't clutter your exported
config). The module also adds a token that renders any site menu as a nested
Markdown link list, which is a handy way to hand AI agents a navigation map.

The module requires core's **Text** module, works on Drupal 10.3+ and 11.1+, and
needs PHP 8.1.6 or newer. It **conflicts** with the `llmstxt` and
`llms_txt_generator` modules, so do not run those alongside it. If the optional
`markdownify_views` module is installed, you also get tokens that render
Markdown-tagged Views into the file. A single permission, *Administer /llms.txt
configuration*, gates the admin pages. One deployment note: because `.txt` files
in the web root are often blocked, your web server must be told to pass
`/llms.txt` through to Drupal — see [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the required web-server tweak.
2. [Configuration](configuration/index.md) — author the config body and manage
   the section entities.

## Where it lives in the admin menu

The config form is at **Content → llms.txt** (`/admin/content/llms-txt`), and the
sections are managed at `/admin/content/llms-txt/sections`. The served file is at
the site root, `/llms.txt`.

## How to use it

Enable the module, add the web-server rule so `/llms.txt` reaches Drupal, then
edit the config body and add a few sections in the admin. Visit `/llms.txt` to
see the assembled Markdown. See [Configuration](configuration/index.md) for the
details of each source.
