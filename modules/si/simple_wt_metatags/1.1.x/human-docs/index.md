# Simple WT Metatags — manual setup guide

**Simple WT Metatags** (`simple_wt_metatags`) is a lightweight way to manage the
handful of SEO and Open Graph tags that actually matter — the meta description, the
canonical URL, and the core Open Graph title, description and image — without
installing the full Metatag module.

Rather than giving you a sprawling tag editor, it lets you map existing fields on
your content types and taxonomy vocabularies to those tags, and define site-wide
fallbacks for pages that are not entities (Views, the front page, custom routes). It
automatically injects a canonical URL on every front-end route to head off
"duplicate content" warnings in Google Search Console (and steps aside gracefully if
core already placed one). It reads the page title straight into the Open Graph title,
pulls the meta and Open Graph descriptions from a plain-long-text field you nominate
(word-safe truncated to 200 characters), and outputs a full Open Graph image set —
`og:image` plus width, height, secure URL and alt — from a media image reference
field you pick. The description field also supports Drupal tokens for dynamic values.

The module does its work through one settings form where you enter the machine names
of the fields to read, plus the global fallbacks. It defines its own permission for
who may configure it, and it has no access-control role beyond that — the meta values
it emits simply reflect whatever is already on the page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — map your fields to meta tags and set the
   global fallbacks.

## Where it lives in the admin menu

The settings form is at **Configuration → Search and metadata → Simple WT Metatags
Settings** (`/admin/config/search/simple-wt-metatags`).
