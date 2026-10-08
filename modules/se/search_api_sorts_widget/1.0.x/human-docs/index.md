# Search API Sorts Widget — manual setup guide

**Search API Sorts Widget** (`search_api_sorts_widget`) presents the sorting
options from the **Search API Sorts** module as a proper form control — a dropdown
or a set of radio buttons — instead of the list of links that the parent module
renders by default.

The reasoning is a usability one. `search_api_sorts` gives a search page its
sorting mechanism (relevance, date, title, and so on) and renders each option as a
link, with the current one marked. That works, but it looks like nothing else on
the page: every other search control — the keyword box, the facets, the
items-per-page selector — is a form element. Visitors read a row of links as
*navigation* and a dropdown labelled "Sort by" as a *control*, which is exactly how
every other search interface they have used presents sorting. This module supplies
that familiar presentation, with separate labels for the ascending and descending
version of each sort and an optional auto-submit.

It requires the **Search API Sorts** module and core's **Block** module, and works
on Drupal 10 and 11. It adds its own `administer search_api_sorts_widget`
permission. Note that this release (1.0.x) is a **beta**, the project is minimally
maintained, and it is not covered by Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — switch a search index's sorts to the
   form widget and set the labels.

## Where it lives in the admin menu

The widget is configured per Search API index, from a **Sorts widget** tab on the
index's admin pages under **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api/index/[INDEX]`), behind the
`administer search_api` permission. See [Configuration](configuration/index.md).

## Two implementation details to check

These are what separate a working sort control from an annoying one:

**Submission without JavaScript.** A select that only sorts when a script fires
needs a visible submit button as a fallback, or the control is dead for anyone the
script never reached. The module's auto-submit option is a convenience — make sure
there is still a way to submit without it.

**URL state.** The chosen sort should live in the query string, so a sorted results
page can be linked, bookmarked, shared and returned to with the browser's back
button. A sort held only in the session breaks all four — the classic "going back
loses my place" complaint.
