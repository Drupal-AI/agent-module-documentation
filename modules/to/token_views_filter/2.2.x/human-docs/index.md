# Tokens in Views Filter Criteria — manual setup guide

**Tokens in Views Filter Criteria** (`token_views_filter`) adds a **Use tokens**
checkbox to Views filters, so a filter's value can contain replacement tokens that
are resolved when the view runs. Instead of a fixed value like a specific user ID,
you can filter on `[current-user:uid]`, `[site:name]`, `[current-page:query:q]` and
similar tokens — giving you dynamic, context-aware filtering without writing a
custom Views handler.

This is a lightweight alternative to contextual filters and relationships. A common
use is a single "My content" block: tokenise an author/uid filter with
`[current-user:uid]` and the same view adapts to whoever is viewing it, so you no
longer need one view per role or a separate contextual-filter setup. Tokens are
resolved against the `view` and `current-page` token types, and unmatched tokens
resolve to an empty string.

The module works by decorating a set of core (and contrib) Views filter plugins —
**string, numeric, date, datetime, combine, list-field** and
**geofield-proximity** filters all gain the checkbox. When you tick *Use tokens*, a
token-browser link appears so you can find the right token, and the value is
token-replaced just before the database query runs. There is no admin settings
page: all configuration lives per filter, inside each View. The module depends on
the **Token** module.

This guide is written for a **human** clicking through the Views UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page — you enable tokens per filter inside a View:

1. Edit the View and open the settings of a filter whose type is supported —
   **string, numeric, date, datetime, combine, list-field** or
   **geofield-proximity**. (Only these filter types show the checkbox.)
2. Tick **Use tokens**. A token-browser link appears, listing the available
   `view` and `current-page` tokens.
3. Put a token in the filter's **Value** field — for example `[current-user:uid]`
   to match the logged-in user, `[site:name]` for the site name, or
   `[current-page:query:q]` for a query-string parameter.
4. Save the View.

When the view executes, the value is token-replaced before the query is built.
Because unmatched tokens clear to an empty string, a filter whose token has no value
simply blanks out. Grouped (exposed) filters are handled too — the selected group
item's value is tokenised the same way.

The choice is stored inside the view's own configuration as a `use_tokens: true`
flag alongside the filter's value, so it deploys with the rest of your exported
Views config. If you need to add token support to a filter type the module does not
already cover, that is a developer task — see the sibling
[`agent/plugins/token-filter.md`](../agent/plugins/token-filter.md) doc.
