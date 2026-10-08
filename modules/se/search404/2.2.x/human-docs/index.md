# Search 404 — manual setup guide

**Search 404** (`search404`) turns your site's "404 Page not found" error into
something useful: a search. When a visitor lands on a URL that no longer exists,
the module pulls keywords out of the requested path and runs a search for them,
showing the results right on the error page instead of a dead end. So a request
for `/some-old-article-title` becomes a search for "some old article title" — a
great way to recover traffic from links to pages that were renamed or removed.

It works out of the box with Drupal's **core Search** module and needs no extra
setup to get going — installing it automatically points the site's 404 page at its
own handler. If you use **Search API** or want results to come from a specific
View, you can switch it to a custom search path instead. It also has built‑in
support for the Search by page and Google CSE modules.

Beyond the basic behaviour, Search 404 is highly tunable. It can jump the visitor
straight to a page when there is a single clear match (or always to the first
result on chosen paths), issue SEO‑friendly 301 redirects, strip out stop words and
file extensions before searching, ignore whole path patterns, abort searches for
image and asset requests to save load, and replace the page title, intro text and
error message with your own wording.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form: search backend,
   keyword parsing, jump‑to‑result, abort rules and custom 404 text.

## Where it lives in the admin menu

The settings form is at **Configuration → Search and metadata → Search 404
settings** (`/admin/config/search/search404`). There is no separate menu item for
the 404 page itself — the module wires that in automatically on install.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). It immediately
   sets your site's 404 page to its search handler.
2. Make sure the core Search module is enabled (or configure a custom search path)
   and that visitors have the *search content* permission so searches can run.
3. Adjust the behaviour on the settings form if the defaults do not suit you.
4. Visit a non‑existent URL to see the keyword search in action.
