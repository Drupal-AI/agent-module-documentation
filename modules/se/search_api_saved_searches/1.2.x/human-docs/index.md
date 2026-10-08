# Search API Saved Searches — manual setup guide

**Search API Saved Searches** (`search_api_saved_searches`) lets a visitor save a
search they have run and be emailed when new content matches it later. It is the
familiar "alert me about new listings like this" feature from job boards and
property sites, brought to any Search API search on your Drupal site.

Because it captures whatever filters were active — facets, Views exposed filters,
keywords — a saved search reproduces exactly the result set the visitor was
looking at. Visitors can also create a saved search without running it first.
Notifications go out by email with token replacement, and the sending frequency
(for example a daily or weekly digest) can be governed by administrators and, if
you allow it, adjusted by users themselves. Registered users get a list of their
saved searches to manage; anonymous visitors can subscribe with just an email
address, which is confirmed by an activation link before any alerts are sent.

The module is built around two kinds of entity: an individual saved search, and a
**saved-search type** that carries the behaviour — the notification schedule, the
activation rules and which index it is bound to. That means you can run several
different "alert products" side by side on one site, each with its own schedule.
How alerts are delivered is extensible through a notification plugin type, so
delivery is not locked to email. It depends on the **Search API** module (1.20 or
newer) plus core's **Options** and **User** modules, and this release is marked
stable and is covered by Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set up saved-search types and their
   notification behaviour.

## Where it lives in the admin menu

Once enabled, you manage saved-search **types** at the saved-search type
collection (`entity.search_api_saved_search_type.collection`), reached under the
Search API administration area. That is where you define how alerts behave; see
[Configuration](configuration/index.md).

## Two things to plan for

**Cron cost.** Notifications run on cron and re-execute each saved query. The work
scales with the number of saved searches, so a popular site should check that its
cron budget can keep up.

**Privacy.** Anonymous saved searches store an email address and a query, which is
personal data. Decide on a retention policy and cover it in your privacy notice —
and note that the activation-link flow exists precisely to stop someone
subscribing an email address they do not own.

**Two known issues to configure around.** Any search View used with saved
searches should have caching disabled, and if such a View also uses facets it
should not use AJAX. Both are documented upstream; set your Views up accordingly.
