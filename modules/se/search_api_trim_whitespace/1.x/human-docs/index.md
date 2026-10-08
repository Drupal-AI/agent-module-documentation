# Search API Trim Whitespace — manual setup guide

**Search API Trim Whitespace** (`search_api_trim_whitespace`) adds a Search API
processor that strips errant whitespace and non-printable characters out of text
as it is indexed. If you have ever indexed formatted text and seen doubled
spaces, invisible characters, or stray `&nbsp;` fragments turning up in your
search result snippets, this is the module that cleans them up.

The problem it solves is a familiar one: content pasted from software like
Microsoft Word — or text that has already passed through Search API's own HTML
Filter — often carries extra markup, extra spaces, and invisible tags. Left
alone, a result description that should read *"I am the search result
description."* can render with a floating space before the full stop. Enable this
processor, place it **after** the HTML Filter in your index's processor chain,
and the stored text is normalised so those artefacts disappear.

It works purely on indexed text and has no security surface, no settings page,
and no permissions. It depends only on **Search API**. The one thing to confirm
is that it does not strip whitespace that is meaningful to your particular content
— in practice this is rarely an issue.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module adds no settings page. After enabling it, edit the Search API index
you want to clean up (**Configuration → Search and metadata → Search API** → your
index → the **Processors** tab), turn on the trim-whitespace processor, and make
sure it is ordered **after** the HTML Filter processor. Save the index and
re-index so the normalised text is stored.
