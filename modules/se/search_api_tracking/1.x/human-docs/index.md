# Search API Tracking — manual setup guide

**Search API Tracking** (`search_api_tracking`) records the searches people run
through Search API into your site's database, so you can report on what visitors
are actually looking for. Search API does the searching, but it does not keep a
record of the queries; this module adds that missing analytics layer.

For each tracked search it stores the datetime, a tracking *type* (see below),
the user ID (handy for excluding logged-in staff), the keywords, the sort field,
sort order, and the language. The tracking types cover the moment a user presses
submit, searches that return no results, autocomplete searches, and use of the
"did you mean" suggestion. The empty-result searches are often the most valuable
— they show you the content your visitors expect but cannot find. The module also
ships a ready-made **View** (permissioned to the administrator role) that you can
customise into a dashboard of performed searches.

The module depends on **Search API** and on the **Views Filter Select**
(`views_filter_select`) module. It provides its own permission and a swappable
storage backend (the database is the default). Multiple search forms are
supported — for example a search box in the header and another on the search page
itself — although the empty-result tracking requires the keyword to be present in
both forms.

A privacy note worth taking seriously: **search queries can be personal or
sensitive** — people search for health conditions, names, and private topics. A
stored query log is a record that carries privacy weight. Restrict who can read
the log, set a retention limit, consider whether queries should be stored against
identifiable users, and keep the table out of casual database sharing.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   pull in its Views Filter Select dependency, and enable it.

## How to use it

Once enabled, the module begins logging Search API searches. To review them, go
to **Structure → Views** and open the bundled **Search API Tracking** view (it is
granted to the administrator role by default). Alter the view — its fields,
filters, and access — to match how you want to read the data. Because the storage
is swappable, developers can replace the default database backend if they need to
send the data elsewhere.
