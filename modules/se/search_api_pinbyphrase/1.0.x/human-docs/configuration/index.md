# Configuration

The module provides a configuration form where you define which node should be
pinned to the top of results for which search phrase. Reaching this form requires
the **`administer search_api_pinbyphrase`** permission, which an administrator has
by default; grant it to other roles under **People → Permissions**
(`/admin/people/permissions`) if you want non-admins to manage pinned phrases.

## Open the settings form

The quickest route is via **Extend** (`/admin/modules`): find **Search API
PinByPhrase** in the list and click its gear/settings icon to jump straight to the
configuration page. Follow the instructions shown on that form.

## Define your pinned phrases

The form lets you create anywhere from zero to many phrase sets. Each set ties
together three things:

- **Phrase** — the search query text that should trigger the pin. When a visitor's
  query matches this phrase, the associated node is promoted to the top.
- **Node ID** — the ID of the node you want pinned to the top of the results for
  that phrase.
- **Language code** — the language the pinning applies to, so you can pin different
  content per language.

Add as many sets as you need, then save the form. The module is expected to operate
on a **"content"** index, so make sure the node you're pinning lives in the Solr
index you're searching.

## How it takes effect

Behind the scenes the module registers an event subscriber that runs after search
results are extracted. When a query matches one of your configured phrases, the
subscriber pins the matching node so it appears at the top of the result list — no
re-indexing required, since the pinning happens at query time on the returned
results.
