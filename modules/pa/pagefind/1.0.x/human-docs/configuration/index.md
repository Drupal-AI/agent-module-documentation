# Configuration

Pagefind is configured from its **dashboard**, and the fastest way to a working search is
the **Setup Wizard**. This page walks through the main pieces; you don't need all of them
to get started.

## Start with the Setup Wizard

From the Pagefind dashboard, launch the **Guided Setup Wizard**. It takes you from a
fresh install to a working search page — choosing what to index and creating a search
page — without having to read the manual first. If you just want search working quickly,
run the wizard and stop there.

## Build the index

Searching is answered from a **static index**, so the index must be built before results
appear. Trigger a build from the dashboard (or via the module's Drush tooling). Remember:

- The index is an artifact of static files. You can build it in CI, on staging, or on the
  site itself; production only needs to *serve* the files.
- The binary indexes the whole staging directory in one pass, so peak memory scales with
  the amount of text — budget roughly **200 MB of RAM per 1,000 pages** of substantial
  content, and expect a status‑report warning past ~50,000 documents.

## Mark fields with the expert formatter

Pagefind adds a single **field formatter** that controls how each field participates in
search. Use it on your content's display to:

- mark a field as a **filter** (so it drives facets),
- **weight** it for relevance,
- expose it as **metadata**, or
- make it **sortable**.

This is where you decide what's searchable and how much each field counts toward
relevance.

## Faceted search displays

Through the bundled **Search Displays** UI you can build **filterable, sortable,
paginated listing pages** — archives, libraries, directories — with no code. Create a
display, choose the facets (from the fields you marked as filters) and sort options, and
place it where you want people to search and browse.

## Synonyms

The **synonyms** admin UI lets you define index‑time synonym expansion, so a search for
one term also matches its synonyms. Editing synonyms queues a **coalesced re‑stage** of
the affected content via cron — you don't have to rebuild manually; the index heals
itself on the next cron run.

## Featured results ("best bets")

Promote specific content to the **top of results** for chosen keywords. Featured results
apply on both the classic search page and the React‑based displays, so a curated answer
appears first for the searches that matter most.

## Relevance controls

Pagefind exposes relevance settings — term frequency, term similarity, page length and
term saturation — applied consistently across every search surface, so you can tune how
matches are ranked.

## Multisite collections

If you run several Pagefind‑powered sites, you can merge their indexes into a single
**collection**, giving visitors one search experience that spans all of them.

## Developer tooling

For debugging, the module provides **Drush commands with real diagnostics**, a
**Playground** for live query debugging, and a **Preview** tab that shows exactly what
HTML was staged for any node — useful when a result isn't matching the way you expect.
