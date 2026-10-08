<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter Term — using the filter page

## Routes
- `/allcontent` (`filter_term.allcontent`) — the results table. Accepts query params: `vocabulary`, `term`, `content_type`, `title`, `users`.
- `/admin/config/filter_term/vocab` (`filter_term.vocab`) — the filter form for authenticated users.

## How it works
`VocabForm` collects a vocabulary (AJAX-loads its terms), a term, a title string, a content type and an author, then redirects to `filter_term.allcontent` with those values as route/query parameters. `DefaultController::content()` runs one of three DB-API selects depending on which of vocabulary/term are set, applies optional content-type/title/author conditions, and renders a sortable, 3-per-page table with View/Edit operation links.

## Operational notes
- The table's `Status` column exposes published/unpublished state; the query does not call node access, so results are not filtered per-user. Anyone with `access content` sees the same list.
- Values are bound as query conditions via the database API (parameterised), so the filter inputs are not string-concatenated into SQL.
- There is no exported configuration — behaviour depends entirely on the site's vocabularies, content types and nodes.
