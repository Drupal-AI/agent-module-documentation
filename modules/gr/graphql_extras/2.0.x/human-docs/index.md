# GraphQL Extras — manual setup guide

**GraphQL Extras** (`graphql_extras`) is a collection of small, read-only field
plugins for **GraphQL v3** that fill in the handy little bits a decoupled or
progressively-decoupled front end usually needs: the current page URL, the
current interface language, whether you're on the front page, root-relative
file and image URLs, and a way to read arbitrary Drupal context objects on an
entity.

These are the sort of values you would otherwise write custom resolvers for.
With this module installed you simply reference the new fields in your queries —
`currentUrl`, `currentLanguage`, `isFrontPage`, `pathWithQueryString`,
`relativeUrl` (for files and image styles), `entityTranslationFromContext`,
`entityHasTranslation`, and a `context` field. Together they make it easy to
build a language switcher that preserves the query string, or to emit
root-relative asset URLs instead of absolute-domain ones in decoupled responses.

Every field plugin is declared secure and resolves only values that are already
derivable and non-sensitive — a URL, a language, a relative path, or context
objects the GraphQL layer already governs. The module adds no routes, no
mutations, and no permissions of its own; access to the underlying data is
governed entirely by your GraphQL v3 server/schema configuration and the
resolved objects' own access checks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside GraphQL v3.

There is **no configuration page** for this module — it is a developer toolkit.
You use it by referencing its fields in your GraphQL queries.

## How to use it

Install it next to a working **GraphQL v3** server, then reference the new
fields in your queries. A few examples of what they give you:

- **`currentUrl`** and **`currentLanguage`** — root-level fields for the URL and
  language of the current request, useful for language-aware navigation.
- **`pathWithQueryString`** — returns a path including its query string as a
  single field, so canonical and language-switch links keep their parameters.
- **`isFrontPage`** — a boolean on the Url field, so a front end can detect the
  home route.
- **`relativeUrl`** — helpers on File and ImageResource that return
  root-relative URLs (via core's `transformRelative()`), keeping asset
  references portable across domains.
- **`context`**, **`entityTranslationFromContext`**, **`entityHasTranslation`**
  — read Drupal context objects and translations on an entity in the schema.

> **Note:** This module targets **GraphQL v3**. It does not provide fields for
> the GraphQL 4.x schema system. It is minimally maintained and is not covered
> by Drupal's security advisory policy — review it before relying on it in
> production.
