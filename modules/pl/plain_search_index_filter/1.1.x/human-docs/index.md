# Plain Search Index Filter — manual setup guide

**Plain Search Index Filter** (`plain_search_index_filter`) provides a Twig filter,
**`strip_tags_safe`**, that removes HTML from text cleanly — specifically for feeding
tidy plain text into a search index. Its advantage over Twig's built-in `striptags`
is that it **preserves spacing**: where `striptags` can jam adjacent words together
when it removes tags, `strip_tags_safe` keeps a break so words stay separated. It also
strips the *contents* of `<script>` and `<style>` tags, so scripts and CSS never leak
into your indexed text or search snippets.

It is aimed at sites where clean, readable indexed text really matters — academic
databases, corporate sites, libraries — and it pairs naturally with **Search API**
when you index rendered HTML. You apply the filter in a Twig template (typically a
search-index view mode template) to sanitise the output before it reaches the index.

Newer releases also add a small **settings page**, so you can preserve specific HTML
tags when stripping (keeping semantic markup you want in the index) and optionally
convert relative links to absolute URLs (useful when an external search system indexes
your content). See [Configuration](configuration/index.md) for those options.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings page: allowed HTML tags and
   converting relative links to absolute URLs.

## Where it lives in the admin menu

The settings page is at **Configuration → System → Plain Search Index Filter
settings** (`plain_search_index_filter.settings`), and a **Configure** link is also
available next to the module on the **Extend** page for quick access.

## How to use it

The core of the module is the `strip_tags_safe` Twig filter. In a template that
produces the text you want to index — for example a `node--search-index.html.twig` —
capture the rendered content and run it through the filter:

```twig
{% set renderContent %}
  {{ content }}
{% endset %}
{{ renderContent|strip_tags_safe }}
```

The output is clean plain text with spacing preserved and script/style contents
removed, ready to be indexed. For guidance on setting up a Search API index that uses
rendered HTML, see the Search API documentation referenced on the project page.
