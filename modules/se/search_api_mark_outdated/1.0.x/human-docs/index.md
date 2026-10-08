# Search API Mark Outdated — manual setup guide

**Search API Mark Outdated** (`search_api_mark_outdated`) visually flags content
in your Search API views that hasn't been updated within a period you decide is
"fresh." Search results normally present everything as equally current, which on a
site with years of content is quietly misleading: a policy page last touched in
2019 looks exactly like one revised last week. This module surfaces a page's age
right where people actually encounter content — in search — rather than hiding it
in an admin report.

That dual audience is the point. For a **reader**, an age marker is a form of
honesty: it signals how much to trust what follows. For an **editor**, the same
marker doubles as a work queue that shows up in the ordinary course of using the
site, instead of requiring a deliberate content audit. The module depends only on
the **Search API** module and works on Drupal 10 and 11.

Two things are worth deciding rather than leaving to a default. First, **what
counts as outdated varies enormously by content type** — a news article is stale
within a month, an organisational history is fine for a decade — so a single
site-wide threshold will be wrong for most of the site; set the threshold per
content type. Second, **"changed" is not the same as "reviewed"**: fixing a typo
resets the changed timestamp without anyone actually verifying the content, so this
marker measures editing activity, not accuracy. If accuracy is what you care about,
maintain a separate reviewed-date field and sort or mark on that instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module works within your Search API views. Build (or edit) a view backed by a
Search API index, and use the module's freshness marker on the results so items
older than your chosen threshold are visibly flagged. Because the marker rides
along with normal search results, both readers and editors see the age signal in
place — decide the threshold with the content-type differences above in mind, and
remember that it reflects when a page was last *changed*, not when it was last
*reviewed*.
