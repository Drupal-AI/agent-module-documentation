# JSON:API Multilingual — manual setup guide

**JSON:API Multilingual** (`jsonapi_multilingual`) adds real per-translation
handling to Drupal's JSON:API. Out of the box, core JSON:API serves the
language-negotiated translation of an entity and gives you no way to read, create,
update, or delete one specific translation on its own. This module adds that: per
translation `GET`, `POST`, `PATCH`, and `DELETE` over the existing JSON:API
resource URLs, with a stable HTTP contract that does **not** depend on Drupal's
URL language negotiation.

The key idea is that you pick the target language **per request**, using the
`langCode` query-string parameter, never a URL path prefix. That makes the choice
explicit, cacheable, and accepted on every operation. On reads you can add
`includeFallback=1` to resolve the request through the site's language fallback
chain instead of failing strictly — the entity's default translation is the
terminal candidate, so an existing entity always returns a `200`, and the language
actually served is reported in the `Content-Language` response header and the
`langcode` attribute.

Translation access still flows through JSON:API's normal access layer, so the
module only ever exposes what the requesting client is allowed to see. It composes
cleanly with related modules — JSON:API Menu Items (1.2.8+) honors the same
`langCode` / `includeFallback` selection per menu link, and it works alongside
Next.js (`next_jsonapi`) and Decoupled Router rather than clobbering their
behavior.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its translation dependencies.

There is **no configuration page** for this module — everything is driven by
request query parameters, described below.

## Where it lives in the admin menu

JSON:API Multilingual adds no admin page. You manage languages and translations in
the usual places — **Configuration → Regional and language** and each entity's
translation tab — while this module governs how those translations are read and
written over JSON:API.

## How to use it

Select the translation with `langCode`, and (on reads) optionally add
`includeFallback=1`:

```
# Read a specific translation (404 if it does not exist)
GET /jsonapi/node/article/{uuid}?langCode=fr

# Read with server-side fallback (always returns the best available translation)
GET /jsonapi/node/article/{uuid}?langCode=fr&includeFallback=1

# Create a new translation of an existing entity (409 if it already exists)
POST /jsonapi/node/article/{uuid}?langCode=fr

# Update a single translation (404 if it does not exist — use POST to create)
PATCH /jsonapi/node/article/{uuid}?langCode=fr

# Delete a single translation (400 for the default translation)
DELETE /jsonapi/node/article/{uuid}?langCode=fr
```

A `DELETE` **without** a language deletes the whole entity, while `DELETE` with a
`langCode` removes just that one translation. When creating a translation, only
translatable fields may be sent.

Writes (`POST`, `PATCH`, `DELETE`) require JSON:API to be in read-write mode — that
is, `jsonapi.settings:read_only = false`, exactly as for core JSON:API. In
read-only mode, writes return `405 Method Not Allowed` while reads keep working.
